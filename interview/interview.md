## interview

1. 元类的作用

   * Class的定义

     <img src="/Volumes/XiaoZhongWen/Work/MobileAwesome/interview/res/Class.png" alt="Class" style="zoom:50%;" />

   * objc_class的定义

     <img src="/Volumes/XiaoZhongWen/Work/MobileAwesome/interview/res/objc_class.png" alt="objc_class" style="zoom:50%;" />

   * objc_object的定义

     <img src="/Volumes/XiaoZhongWen/Work/MobileAwesome/interview/res/objc_object.png" alt="objc_object" style="zoom:50%;" />

   * isa_t的定义

     <img src="/Volumes/XiaoZhongWen/Work/MobileAwesome/interview/res/isa_t.png" alt="isa_t" style="zoom:50%;" />

   * 类的结构

     <img src="/Volumes/XiaoZhongWen/Work/MobileAwesome/interview/res/isa.png" alt="isa" style="zoom:50%;" />

     `isa` 顾名思义 `is a` 表示对象所属的类。

     `isa` 指向他的类对象，从而可以找到对象上的方法。

     同一个类的不同对象，他们的 isa 指针是一样的

2. 

