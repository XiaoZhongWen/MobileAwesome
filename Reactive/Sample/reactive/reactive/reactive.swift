//
//  reactive.swift
//  reactive
//
//  Created by 肖仲文 on 2021/6/16.
//

import Foundation

public protocol DelegateProxyType {}

public protocol ObservableType : ObservableConvertibleType {

}

public protocol Disposable {
    /// Dispose resource.
    func dispose()
}

final private class Map<SourceType, ResultType>: Producer<ResultType> {
    typealias Transform = (SourceType) throws -> ResultType

    private let _source: Observable<SourceType>

    private let _transform: Transform

    init(source: Observable<SourceType>, transform: @escaping Transform) {
        self._source = source
        self._transform = transform

#if TRACE_RESOURCES
        _ = increment(_numberOfMapOperators)
#endif
    }

//    override func composeMap<R>(_ selector: @escaping (ResultType) throws -> R) -> Observable<R> {
//        let originalSelector = self._transform
//        return Map<SourceType, R>(source: self._source, transform: { (s: SourceType) throws -> R in
//            let r: ResultType = try originalSelector(s)
//            return try selector(r)
//        })
//    }
//
//    override func run<O: ObserverType>(_ observer: O, cancel: Cancelable) -> (sink: Disposable, subscription: Disposable) where O.E == ResultType {
//        let sink = MapSink(transform: self._transform, observer: observer, cancel: cancel)
//        let subscription = self._source.subscribe(sink)
//        return (sink: sink, subscription: subscription)
//    }

    #if TRACE_RESOURCES
    deinit {
        _ = decrement(_numberOfMapOperators)
    }
    #endif
}

internal func _map<Element, R>(source: Observable<Element>, transform: @escaping (Element) throws -> R) -> Observable<R> {
    return Map(source: source, transform: transform)
}

public class Observable<Element> : ObservableType {
    public func asObservable() -> Observable<Element> {
        return self
    }

    /// Type of elements in sequence.
    public typealias E = Element

    internal func composeMap<R>(_ transform: @escaping (Element) throws -> R) -> Observable<R> {
        return _map(source: self, transform: transform)
    }
}

public final class PublishRelay<Element>: ObservableType {
    public typealias E = Element
    private let _subject: PublishSubject<Element>
    public init() {
        self._subject = PublishSubject()
    }
    public func asObservable() -> Observable<Element> {
        return self._subject.asObservable()
    }
}

class Producer<Element> : Observable<Element> {

}

public protocol ObservableConvertibleType {
    /// Type of elements in sequence.
    associatedtype E

    /// Converts `self` to `Observable` sequence.
    ///
    /// - returns: Observable sequence that represents `self`.
    func asObservable() -> Observable<E>
}

extension ObservableType {
    func subscribeProxyDataSource<T: DelegateProxyType>(ofObject object: T) {}
}

extension ObservableType {

    /**
     Projects each element of an observable sequence into a new form.

     - seealso: [map operator on reactivex.io](http://reactivex.io/documentation/operators/map.html)

     - parameter transform: A transform function to apply to each source element.
     - returns: An observable sequence whose elements are the result of invoking the transform function on each element of source.

     */
    public func map<R>(_ transform: @escaping (E) throws -> R)
        -> Observable<R> {
        return self.asObservable().composeMap(transform)
    }
}

extension ObservableType {
    public func bind(to relay: PublishRelay<E?>) -> Disposable {
        return self.map { $0 as E }.bind(to: relay)
    }
}
