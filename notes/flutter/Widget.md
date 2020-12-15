## Widget

### Widget的渲染过程

Widget是对视图的一种结构化描述，存储视图渲染的配置信息，如布局、渲染属性、事件响应信息等。

Element是Widget的一个实例化对象，承载视图构建的上下文信息，连接结构化配置信息到最终渲染。

RenderObject是主要负责实际渲染的对象，布局和绘制过程在RenderObject中完成，合成和渲染过程在Skia中完成。

渲染过程分三步：

* 通过Widget树生成对应的Element树
* 创建相应的RenderObject对象并关联到Element.renderObject属性上
* 构建RenderObject树，以完成渲染

三者间的关系：

<img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/Widget_Element_RenderObject.png" alt="Widget_Element_RenderObject" style="zoom:50%;" />

#### Element树的意义

Widget被设计成不可变的，当视图渲染的配置信息发生变化时，Flutter会重建Widget树，这样会造成大量对象的销毁与重建，而Element被设计为可变的，它将Widget树的变化做了抽象，只将真正需要修改的部分同步到真实的RenderObject树中，降低对真实渲染视图的修改，提高渲染效率。



#### Element与RenderObject对象的创建与更新

Flutter在遍历Widget树时，调用createElement去同步Widget的配置，从而生成对应节点的Element对象，在Element创建完毕后，Flutter会调用Element的mount方法，完成与之关联的RenderObject对象的创建；

如果Widget的配置数据发生了变化，那么持有该Widget的Element节点会被标记为dirty，在下一个周期的绘制时，Flutter会触发Element树的更新，并使用最新的Widget数据更新关联的RenderObject对象。



#### 示例

<img src="/Volumes/Julien/Mine/MobileAwesome/resources/flutter/f4d2ac98728cf4f24b0237958d0ce0b9.png" alt="f4d2ac98728cf4f24b0237958d0ce0b9" style="zoom:100%;" />



![3536bd7bc00b42b220ce18ba86c2a26d](/Volumes/Julien/Mine/MobileAwesome/resources/flutter/3536bd7bc00b42b220ce18ba86c2a26d.png)

