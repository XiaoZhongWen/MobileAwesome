## interview

1. 元类的作用

   * Class的定义

     <img src="./res/Class.png" alt="Class" style="zoom:50%;" />

   * objc_class的定义

     <img src="./res/objc_class.png" alt="objc_class" style="zoom:50%;" />

   * objc_object的定义

     <img src="./res/objc_object.png" alt="objc_object" style="zoom:50%;" />

   * isa_t的定义

     <img src="./res/isa_t.png" alt="isa_t" style="zoom:50%;" />

   * 类的结构

     <img src="./res/isa.png" alt="isa" style="zoom:50%;" />

     `isa` 顾名思义 `is a` 表示对象所属的类。

     `isa` 指向他的类对象，从而可以找到对象上的方法。

     同一个类的不同对象，他们的 isa 指针是一样的
     
     

2. 一个OC对象如何进行内存布局

   - 所有父类的成员变量和自己的成员变量都会存放在该对象所对应的存储空间中.
   - 每一个对象内部都有一个isa指针,指向他的类对象,类对象中存放着本对象的

   1. 对象方法列表（对象能够接收的消息列表，保存在它所对应的类对象中）
   2. 成员变量的列表,
   3. 属性列表,

   它内部也有一个isa指针指向元对象(meta class),元对象内部存放的是类方法列表,类对象内部还有一个superclass的指针,指向他的父类对象。

   每个 Objective-C 对象都有相同的结构，如下图所示：

   <img src="./res/oc_memory_layout.png" alt="oc_memory_layout" style="zoom:50%;" />

- 根对象就是NSObject，它的superclass指针指向nil

- 类对象既然称为对象，那它也是一个实例。类对象中也有一个isa指针指向它的元类(meta class)，即类对象是元类的实例。元类内部存放的是类方法列表，根元类的isa指针指向自己，superclass指针指向NSObject类

  

3. 关联对象的存储形式

   关联对象存储在散列表AssociationsHashMap中，它是一个单例对象，保存了所有分类对象的关联对象散列表，key有分类对象内存地址的hash值；对象AssociationsHashMap中的ObjectAssociationMap保存具体分类对象所有的关联对象，key为关联对象的关联字符串，ObjcAssociation是对关联对象的封装。

   * 内存布局

     <img src="./res/association_layout.png" alt="association_layout" style="zoom:50%;" />

   * 获取关联对象

     <img src="./res/_object_get_associative_reference.png" alt="_object_get_associative_reference" style="zoom:50%;" />

   

   * 移除所有关联对象

     <img src="./res/_object_remove_assocations.png" alt="_object_remove_assocations" style="zoom:50%;" />

4. category的底层实现

   * 分类在_read_images函数中被注册到一个全局的hash表中

     <img src="./res/category_register.png" alt="category_register" style="zoom:50%;" />

   * _read_images函数在运行时调用map_images时被间接调用

   * 保存分类信息的全局静态hash表是unattachedCategories

     ```c++
     class UnattachedCategories : public ExplicitInitDenseMap<Class, category_list>
     {
     public:
         void addForClass(locstamped_category_t lc, Class cls)
         {
             runtimeLock.assertLocked();
     
             if (slowpath(PrintConnecting)) {
                 _objc_inform("CLASS: found category %c%s(%s)",
                              cls->isMetaClass() ? '+' : '-',
                              cls->nameForLogging(), lc.cat->name);
             }
           // result -> std::pair<iterator, bool>
           // result.first -> iterator
           // iterator -> DenseMapIterator<Class, category_list, DenseMapValueInfo<category_list>, DenseMapInfo<Class>, detail::DenseMapPair<Class, category_list>>;
           // result.first->second -> category_list
             auto result = get().try_emplace(cls, lc);
             if (!result.second) {
                 result.first->second.append(lc);
             }
         }
       ...
     }
     ```

   * unattachedCategories通过成员方法addForClass注册分类

   * addForClass接收两个参数，一个参数是与分类关联的类，另一个是locstamped_category_t

     ```c++
     struct locstamped_category_t {
         category_t *cat;
         struct header_info *hi;
     };
     ```

   通过以上操作，类与分类就被关联在hash表unattachedCategories中了，通过类就能够在hash表unattachedCategories中找到其所有的分类

   ​	

   * unattachedCategories保存的是存根类的分类信息，存根类即还不知道其元类的类

   * 当存根类的元类被确定后，会调用methodizeClass函数，将分类中定义的对象方法、类方法、属性、协议信息合并到类信息中（类对象、元类对象中）

   * 如果类不是存根类，则直接将分类中定义的对象方法、类方法、属性、协议信息合并到类信息中（类对象、元类对象中）

     <img src="./res/category_combine.png" alt="category_combine" style="zoom:50%;" />

   * 合并分类中的信息到类信息中（类对象、元类对象中）通过函数attachCategories实现

     ```c++
     // Attach method lists and properties and protocols from categories to a class.
     // Assumes the categories in cats are all loaded and sorted by load order, 
     // oldest categories first.
     static void
     attachCategories(Class cls, const locstamped_category_t *cats_list, uint32_t cats_count,
                      int flags)
     {
         if (slowpath(PrintReplacedMethods)) {
             printReplacements(cls, cats_list, cats_count);
         }
         if (slowpath(PrintConnecting)) {
             _objc_inform("CLASS: attaching %d categories to%s class '%s'%s",
                          cats_count, (flags & ATTACH_EXISTING) ? " existing" : "",
                          cls->nameForLogging(), (flags & ATTACH_METACLASS) ? " (meta)" : "");
         }
     
         /*
          * Only a few classes have more than 64 categories during launch.
          * This uses a little stack, and avoids malloc.
          *
          * Categories must be added in the proper order, which is back
          * to front. To do that with the chunking, we iterate cats_list
          * from front to back, build up the local buffers backwards,
          * and call attachLists on the chunks. attachLists prepends the
          * lists, so the final result is in the expected order.
          */
         constexpr uint32_t ATTACH_BUFSIZ = 64;
         method_list_t   *mlists[ATTACH_BUFSIZ];
         property_list_t *proplists[ATTACH_BUFSIZ];
         protocol_list_t *protolists[ATTACH_BUFSIZ];
     
         uint32_t mcount = 0;
         uint32_t propcount = 0;
         uint32_t protocount = 0;
         bool fromBundle = NO;
         bool isMeta = (flags & ATTACH_METACLASS);
         auto rw = cls->data();
     
         for (uint32_t i = 0; i < cats_count; i++) {
             auto& entry = cats_list[i];
     
             method_list_t *mlist = entry.cat->methodsForMeta(isMeta);
             if (mlist) {
                 if (mcount == ATTACH_BUFSIZ) {
                     prepareMethodLists(cls, mlists, mcount, NO, fromBundle);
                     rw->methods.attachLists(mlists, mcount);
                     mcount = 0;
                 }
                 mlists[ATTACH_BUFSIZ - ++mcount] = mlist;
                 fromBundle |= entry.hi->isBundle();
             }
     
             property_list_t *proplist =
                 entry.cat->propertiesForMeta(isMeta, entry.hi);
             if (proplist) {
                 if (propcount == ATTACH_BUFSIZ) {
                     rw->properties.attachLists(proplists, propcount);
                     propcount = 0;
                 }
                 proplists[ATTACH_BUFSIZ - ++propcount] = proplist;
             }
     
             protocol_list_t *protolist = entry.cat->protocolsForMeta(isMeta);
             if (protolist) {
                 if (protocount == ATTACH_BUFSIZ) {
                     rw->protocols.attachLists(protolists, protocount);
                     protocount = 0;
                 }
                 protolists[ATTACH_BUFSIZ - ++protocount] = protolist;
             }
         }
     
         if (mcount > 0) {
             prepareMethodLists(cls, mlists + ATTACH_BUFSIZ - mcount, mcount, NO, fromBundle);
             rw->methods.attachLists(mlists + ATTACH_BUFSIZ - mcount, mcount);
             if (flags & ATTACH_EXISTING) flushCaches(cls);
         }
     
         rw->properties.attachLists(proplists + ATTACH_BUFSIZ - propcount, propcount);
     
         rw->protocols.attachLists(protolists + ATTACH_BUFSIZ - protocount, protocount);
     }
     ```

   通过分类信息合并：

   * 一个类所对应的分类下的对象方法，存放在该类的类对象的方法列表里面
   * 一个类所对应的分类下的类方法，会存放在该类的元类对象的方法列表里面
   * Category编译之后的底层结构是struct category_t，里面存储着分类的对象方法、类方法、属性、协议信息在程序运行的时候，runtime会将Category的数据，合并到类信息中（类对象、元类对象中）
   * Class Extension在编译的时候，它的数据就已经包含在类信息中
   * Category是在运行时，才会将数据合并到类信息中

5. 增加实例变量的方法