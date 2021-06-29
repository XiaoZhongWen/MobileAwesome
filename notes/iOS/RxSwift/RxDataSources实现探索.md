# RxDataSources实现探索

## rx是什么

`tableView.rx.items`

```swift
public struct Reactive<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ReactiveCompatible {
    associatedtype CompatibleType
    
    static var rx: Reactive<CompatibleType>.Type { get set }
    var rx: Reactive<CompatibleType> { get set }
}

extension ReactiveCompatible {
    public static var rx: Reactive<Self>.Type {
        get {
            return Reactive<Self>.self
        }
        set { }
    }
    
    public var rx: Reactive<Self> {
        get {
            return Reactive(self)
        }
        set {}
    }
}

extension NSObject: ReactiveCompatible {}
```

* NSObject 遵守`ReactiveCompatible`协议,  该协议定义了rx的静态属性及类成员属性
* UITableView继承自NSObject, 所以UITableView的实例也拥有类成员属性rx
* 协议`ReactiveCompatible`的扩展提供了该协议的默认实现
* rx是Reactive<CompatibleType>类型, tableView.rx则是结构Reactive<UITableView>的实例



## tableView.rx.items

```swift
extension Reactive where Base: UITableView {
  public func items<
            DataSource: RxTableViewDataSourceType & UITableViewDataSource,
            O: ObservableType>
        (dataSource: DataSource)
        -> (_ source: O)
        -> Disposable
        where DataSource.Element == O.E {

// self.datasource.bind(to: tableView.rx.items(dataSource: ds)), 当这句话执行时，下面的闭包会被调用，参数source即为self.datasource
        return { source in
            // This is called for sideeffects only, and to make sure delegate proxy is in place when
            // data source is being bound.
            // This is needed because theoretically the data source subscription itself might
            // call `self.rx.delegate`. If that happens, it might cause weird side effects since
            // setting data source will set delegate, and UITableView might get into a weird state.
            // Therefore it's better to set delegate proxy first, just to be sure.
            _ = self.delegate
            // Strong reference is needed because data source is in use until result subscription is disposed
     
// source -> PublishSubject<[SectionOfContactModel]>, subscribeProxyDataSource为协议ObservableType的扩展方法
            return source.subscribeProxyDataSource(ofObject: self.base, dataSource: dataSource as UITableViewDataSource, retainDataSource: true) { [weak tableView = self.base] (_: RxTableViewDataSourceProxy, event) -> Void in
                guard let tableView = tableView else {
                    return
                }
                dataSource.tableView(tableView, observedEvent: event)
            }
        }
    }
}
```



## bind

```swift
public func bind<R>(to binder: (Self) -> R) -> R {
	return binder(self)
}
```



## subscribeProxyDataSource

```swift
extension ObservableType {
            func subscribeProxyDataSource<DelegateProxy: DelegateProxyType>(ofObject object: DelegateProxy.ParentObject, dataSource: DelegateProxy.Delegate, retainDataSource: Bool, binding: @escaping (DelegateProxy, Event<E>) -> Void)
                -> Disposable
                where DelegateProxy.ParentObject: UIView
                , DelegateProxy.Delegate: AnyObject {
                let proxy = DelegateProxy.proxy(for: object)
                let unregisterDelegate = DelegateProxy.installForwardDelegate(dataSource, retainDelegate: retainDataSource, onProxyForObject: object)
                // this is needed to flush any delayed old state (https://github.com/RxSwiftCommunity/RxDataSources/pull/75)
                object.layoutIfNeeded()

                let subscription = self.asObservable()
                    .observeOn(MainScheduler())
                    .catchError { error in
                        bindingError(error)
                        return Observable.empty()
                    }
                    // source can never end, otherwise it would release the subscriber, and deallocate the data source
                    .concat(Observable.never())
                    .takeUntil(object.rx.deallocated)
                    .subscribe { [weak object] (event: Event<E>) in

                        if let object = object {
                            assert(proxy === DelegateProxy.currentDelegate(for: object), "Proxy changed from the time it was first set.\nOriginal: \(proxy)\nExisting: \(String(describing: DelegateProxy.currentDelegate(for: object)))")
                        }
                        
                        binding(proxy, event)
                        
                        switch event {
                        case .error(let error):
                            bindingError(error)
                            unregisterDelegate.dispose()
                        case .completed:
                            unregisterDelegate.dispose()
                        default:
                            break
                        }
                    }
                    
                return Disposables.create { [weak object] in
                    subscription.dispose()
                    object?.layoutIfNeeded()
                    unregisterDelegate.dispose()
                }
            }
        }
```



### DelegateProxy是什么？

```swift
source.subscribeProxyDataSource(ofObject: self.base, dataSource: dataSource as UITableViewDataSource, retainDataSource: true) { [weak tableView = self.base] (_: RxTableViewDataSourceProxy, event) -> Void in
                guard let tableView = tableView else {
                    return
                }
                dataSource.tableView(tableView, observedEvent: event)
            }
// DelegateProxy的类型是RxTableViewDataSourceProxy

class RxTableViewDataSourceProxy: DelegateProxy<UITableView, UITableViewDataSource>
    , DelegateProxyType 
    , UITableViewDataSource
class DelegateProxy<P: AnyObject, D>: _RXDelegateProxy {
        public typealias ParentObject = P
        public typealias Delegate = D
  ...
}
// 由以上可知，RxTableViewDataSourceProxy的关联类型ParentObject的类型是UITableView，Delegate的类型是UITableViewDataSource

func subscribeProxyDataSource<DelegateProxy: DelegateProxyType>(ofObject object: DelegateProxy.ParentObject, dataSource: DelegateProxy.Delegate, retainDataSource: Bool, binding: @escaping (DelegateProxy, Event<E>) -> Void)
                -> Disposable
                where DelegateProxy.ParentObject: UIView
                , DelegateProxy.Delegate: AnyObject {...}
// 所有函数subscribeProxyDataSource中，DelegateProxy的类型是RxTableViewDataSourceProxy，DelegateProxy.ParentObject的类型是UITableView，DelegateProxy.Delegate的类型是UITableViewDataSource
```







## DelegateProxyType

```swift
extension DelegateProxyType {
  
  public static func createProxy(for object: AnyObject) -> Self {
        return castOrFatalError(factory.createProxy(for: object))
    }
  
  fileprivate static func assignedProxy(for object: ParentObject) -> AnyObject? {
        let maybeDelegate = objc_getAssociatedObject(object, self.identifier)
        return castOptionalOrFatalError(maybeDelegate)
    }
  
  public static func proxy(for object: ParentObject) -> Self {
        MainScheduler.ensureRunningOnMainThread()

        let maybeProxy = self.assignedProxy(for: object)

        let proxy: AnyObject
        if let existingProxy = maybeProxy {
            proxy = existingProxy
        }
        else {
            proxy = castOrFatalError(self.createProxy(for: object))
            self.assignProxy(proxy, toObject: object)
            assert(self.assignedProxy(for: object) === proxy)
        }
        let currentDelegate = self._currentDelegate(for: object)
        let delegateProxy: Self = castOrFatalError(proxy)

        if currentDelegate !== delegateProxy {
            delegateProxy._setForwardToDelegate(currentDelegate, retainDelegate: false)
            assert(delegateProxy._forwardToDelegate() === currentDelegate)
            self._setCurrentDelegate(proxy, to: object)
            assert(self._currentDelegate(for: object) === proxy)
            assert(delegateProxy._forwardToDelegate() === currentDelegate)
        }

        return delegateProxy
    }
  
  
  public static func installForwardDelegate(_ forwardDelegate: Delegate, retainDelegate: Bool, onProxyForObject object: ParentObject) -> Disposable {
        weak var weakForwardDelegate: AnyObject? = forwardDelegate as AnyObject
        let proxy = self.proxy(for: object)

        assert(proxy._forwardToDelegate() === nil, "This is a feature to warn you that there is already a delegate (or data source) set somewhere previously. The action you are trying to perform will clear that delegate (data source) and that means that some of your features that depend on that delegate (data source) being set will likely stop working.\n" +
            "If you are ok with this, try to set delegate (data source) to `nil` in front of this operation.\n" +
            " This is the source object value: \(object)\n" +
            " This is the original delegate (data source) value: \(proxy.forwardToDelegate()!)\n" +
            "Hint: Maybe delegate was already set in xib or storyboard and now it's being overwritten in code.\n")

        proxy.setForwardToDelegate(forwardDelegate, retainDelegate: retainDelegate)

        return Disposables.create {
            MainScheduler.ensureRunningOnMainThread()

            let delegate: AnyObject? = weakForwardDelegate

            assert(delegate == nil || proxy._forwardToDelegate() === delegate, "Delegate was changed from time it was first set. Current \(String(describing: proxy.forwardToDelegate())), and it should have been \(proxy)")

            proxy.setForwardToDelegate(nil, retainDelegate: retainDelegate)
        }
    }
}
```



```swift
let datasource = PublishSubject<[SectionOfContactModel]>()
var ds:RxTableViewSectionedReloadDataSource<SectionOfContactModel>
self.datasource.bind(to: tableView.rx.items(dataSource: ds)).disposed(by: disposeBag)
```



