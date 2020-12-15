## State

### 声明式UI编程

Flutter的视图开发是声明式的，其核心设计思想是将视图和数据分离。在声明式UI编程中，除了设计好Widget布局方案外，还要提前维护一套文案数据集，并为需要变化的Widget绑定数据集中的数据，使Widget根据这个数据集完成渲染。当需要变更界面文案时，只要改变数据集中的文案数据，并通知Flutter框架触发Widget的重新渲染即可。



### StatelessWidget 与 StatefulWidget 的选择

* StatelessWidget

  一旦创建成功就不再关心、也不响应任何数据变化进行重绘

  <img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/StatelessWidget.png" alt="StatelessWidget" style="zoom:50%;" />

* StatefulWidget

  Widget的展示，除了父 Widget 初始化时传入的静态配置之外，还需要处理用户的交互或其内部数据的变化，并体现在 UI 上，Widget 创建完成后，还需要关心和响应数据变化来进行重绘。

<img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/StatefulWidget.png" alt="StatefulWidget" style="zoom:50%;" />

父 Widget 是否能通过初始化参数完全控制其 UI 展示效果，如果能，就使用StatelessWidget，负责使用StatefulWidget



### StatefulWidget不能替代StatelessWidget的原因

StatefulWidget 的滥用会直接影响 Flutter 应用的渲染性能，Widget 是不可变的，更新则意味着销毁 + 重建（build）。StatelessWidget 是静态的，一旦创建则无需更新；而对于 StatefulWidget 来说，在 State 类中调用 setState 方法更新数据，会触发视图的销毁和重建，也将间接地触发其每个子 Widget 的销毁和重建。如果我们的根布局是一个 StatefulWidget，在其 State 中每调用一次更新 UI，都将是一整个页面所有 Widget 的销毁和重建。