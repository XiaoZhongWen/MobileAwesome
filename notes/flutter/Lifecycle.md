## Lifecycle

### State生命周期

指关联的 Widget 所经历的，从创建到显示再到更新最后到停止，直至销毁等各个过程阶段。

<img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/lifecycle_state.png" alt="lifecycle_state" style="zoom:50%;" />

1. 创建阶段
   * Flutter 通过调用 StatefulWidget.createState() 来创建一个 State，通过构造方法，接收父 Widget 传递的初始化 UI 配置数据，决定 Widget 最初的呈现效果。
   * initState，会在 State 对象被插入视图树的时候调用，它在 State 的生命周期中只会被调用一次，可以在这里做一些初始化工作。
   * didChangeDependencies 则用来专门处理 State 对象依赖关系变化。
   * build，作用是构建视图，根据父 Widget 传递过来的初始化配置数据，以及 State 的当前状态，创建一个 Widget 然后返回。
2. 更新阶段
   * setState，当状态数据发生变化时，调用这个方法告诉 Flutter，使用更新后的数据重建 UI。
   * didChangeDependencies：State对象的依赖关系发生变化后，如系统语言 Locale 或应用主题改变时。
   * didUpdateWidget，当 Widget 的配置发生变化时，比如，父 Widget 触发重建
3. 销毁阶段
   * 当组件的可见状态发生变化时，deactivate 函数会被调用，这时 State 会被暂时从视图树中移除，值得注意的是，页面切换时，由于 State 对象在视图树中的位置发生了变化，需要先暂时移除后再重新添加，重新触发组件构建，因此这个函数也会被调用。
   * 当 State 被永久地从视图树中移除时，Flutter 会调用 dispose 函数，可以在这里进行最终的资源释放、移除监听、清理环境，等。

<img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/lifecycle_scene.png" alt="lifecycle_scene" style="zoom:50%;" />

![lifecycle_desc](/Volumes/Julien/Mine/MobileAwesome/resources/flutter/lifecycle_desc.png)



### App生命周期

```dart

abstract class WidgetsBindingObserver {
  //页面pop
  Future<bool> didPopRoute() => Future<bool>.value(false);
  //页面push
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);
  //系统窗口相关改变回调，如旋转
  void didChangeMetrics() { }
  //文本缩放系数变化
  void didChangeTextScaleFactor() { }
  //系统亮度变化
  void didChangePlatformBrightness() { }
  //本地化语言变化
  void didChangeLocales(List<Locale> locale) { }
  //App生命周期变化
  void didChangeAppLifecycleState(AppLifecycleState state) { }
  //内存警告回调
  void didHaveMemoryPressure() { }
  //Accessibility相关特性回调
  void didChangeAccessibilityFeatures() {}
}
```

![lifecycle_app](/Volumes/Julien/Mine/MobileAwesome/resources/flutter/lifecycle_app.png)



#### 帧绘制回调

除了需要监听 App 的生命周期回调做相应的处理之外，有时候我们还需要在组件渲染之后做一些与显示安全相关的操作。在 iOS 开发中，我们可以通过 dispatch_async(dispatch_get_main_queue(),^{…}) 方法，让操作在下一个 RunLoop 执行， 在 Flutter 中实现同样的需求, 依然使用 WidgetsBinding 来实现。

WidgetsBinding 提供了单次 Frame 绘制回调，以及实时 Frame 绘制回调两种机制，来分别满足不同的需求：

* 单次 Frame 绘制回调

  通过 addPostFrameCallback 实现。它会在当前 Frame 绘制完成后进行进行回调，并且只会回调一次。

* 实时 Frame 绘制回调

  通过 addPersistentFrameCallback 实现。这个函数会在每次绘制 Frame 结束后进行回调，可以用做 FPS 监测。