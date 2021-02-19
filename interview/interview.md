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

   * 编译后得到的类中

     不能向编译后得到的类中增加实例变量

     因为编译后的类已经注册在 runtime 中，类结构体中的 objc_ivar_list 实例变量的链表 和 instance_size 实例变量的内存大小已经确定，同时runtime 会调用 class_setIvarLayout 或 class_setWeakIvarLayout 来处理 strong weak 引用。所以不能向存在的类中添加实例变量

   * 运行时创建的类中

     能向运行时创建的类中添加实例变量

     运行时创建的类是可以添加实例变量，调用 class_addIvar 函数。但是得在调用 objc_allocateClassPair 之后，objc_registerClassPair 之前

     

6. weak的底层实现

   <img src="./res/objc_initWeak.png" alt="objc_initWeak" style="zoom:33%;" /><img src="./res/objc_initWeak.png" alt="objc_initWeak" style="zoom:33%;" />

   * 不持有对象，对对象弱引用

     * OC对象及其所有弱引用对象的关联保存在SideTable表中的weak_table中

       ```c++
       struct SideTable {
           spinlock_t slock;
           RefcountMap refcnts; // 引用计数表
           weak_table_t weak_table; // weak表
       
           SideTable() {
               memset(&weak_table, 0, sizeof(weak_table));
           }
       
           ~SideTable() {
               _objc_fatal("Do not delete SideTable.");
           }
       
           void lock() { slock.lock(); }
           void unlock() { slock.unlock(); }
           void forceReset() { slock.forceReset(); }
       
           // Address-ordered lock discipline for a pair of side tables.
       
           template<HaveOld, HaveNew>
           static void lockTwo(SideTable *lock1, SideTable *lock2);
           template<HaveOld, HaveNew>
           static void unlockTwo(SideTable *lock1, SideTable *lock2);
       };
       
       struct weak_table_t {
           weak_entry_t *weak_entries;
           size_t    num_entries;
           uintptr_t mask;
           uintptr_t max_hash_displacement;
       };
       
       /// Adds an (object, weak pointer) pair to the weak table.
       id weak_register_no_lock(weak_table_t *weak_table, id referent, 
                                id *referrer, bool crashIfDeallocating);
       
       /// Removes an (object, weak pointer) pair from the weak table.
       void weak_unregister_no_lock(weak_table_t *weak_table, id referent, id *referrer);
       
       /// Called on object destruction. Sets all remaining weak pointers to nil.
       void weak_clear_no_lock(weak_table_t *weak_table, id referent);
       ```

       

     * 通过OC对象的地址可以获取该对象对应的SideTable表

       ```c++
       // 在storeWeak函数中完成
       SideTable *newTable = &SideTables()[newObj];
       ```

     * SideTables()返回SideTablesMap，它是一个全局的hash表，以对象的内存地址作为key，获取对应的SideTable

       ```
       使用hash表来管理对象的引用计数表及weak表是出于以下考虑:
       1. 内存中的对象个数是巨大的，如果用一个SideTable来管理，会导致频繁的内存分配及回收，hash冲突的概率会提高，导致对象插入及查找操作的效率下降，多线程环境下，对表频繁的加锁和解锁会极大的影响性能
       2. SideTablesMap是一个全局hash表，当通过对象的内存地址的操作来进行hash计算后，内存中的对象会比较均匀的分布到SideTablesMap中的各个hash表中
       3. SideTable结构中，有一个自旋锁，当通过对象的内存地址获取到相应的SideTable实例后，在对SideTable实例进行实际数据操作前会进行加锁，操作完毕后解锁；由于不需要对全局的hash表加解锁，保证了效率；仅仅对对象所在的SideTable实例加解锁，保证了数据的安全读写，这里用到了分离锁策略
       ```

     * 将对象的内存地址及weak变量保存在weak_entry_t中

       ```c
       struct weak_entry_t {
           DisguisedPtr<objc_object> referent;
           union {
               struct {
                   weak_referrer_t *referrers;
                   uintptr_t        out_of_line_ness : 2;
                   uintptr_t        num_refs : PTR_MINUS_2;
                   uintptr_t        mask;
                   uintptr_t        max_hash_displacement;
               };
               struct {
                   // out_of_line_ness field is low bits of inline_referrers[1]
                   weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
               };
           };
       
           weak_entry_t(objc_object *newReferent, objc_object **newReferrer)
               : referent(newReferent)
           {
               inline_referrers[0] = newReferrer;
               for (int i = 1; i < WEAK_INLINE_COUNT; i++) {
                   inline_referrers[i] = nil;
               }
           }
       };
       ```

     * 通过OC对象的地址获取该对象在weak表中的weak_entry_t

       ```c
       // 在weak_register_no_lock函数中完成
       weak_entry_t *entry;
           if ((entry = weak_entry_for_referent(weak_table, referent))) {
               append_referrer(entry, referrer);
           } 
           else {
               weak_entry_t new_entry(referent, referrer);
               weak_grow_maybe(weak_table);
               weak_entry_insert(weak_table, &new_entry);
           }
       ```

       

   * 当对象销毁时，与之相关的所以weak变量被置空

     <img src="./res/objc_destoryWeak.png" alt="objc_destoryWeak" style="zoom:33%;" />

     * weak变量置空

       ```c
       void
       weak_unregister_no_lock(weak_table_t *weak_table, id referent_id, id *referrer_id)
       // 1. 调用weak_entry_for_referent获取对应的entry
       // 2. 调用remove_referrer(entry, referrer) 将weak变量置空
       ```

       

     * 置空OC对象关联的所有weak变量

       ```c
       // 将所有相关的weak变量置空
       void 
       weak_clear_no_lock(weak_table_t *weak_table, id referent_id) 
       // 调用weak_entry_for_referent查询referent_id对应的entry
       // 循环将entry中referrers的各元素置空
       ```

   

7. dealloc的底层实现

   <img src="./res/dealloc.png" alt="dealloc" style="zoom:50%;" />

   

8. autoreleasepool的底层实现

   所有加入到自动释放池中的对象，都被保存在**AutoreleasePoolPage**中，它是一个由**AutoreleasePoolPage**组成的双向链表结构

   * AutoreleasePoolPage数据结构

     <img src="./res/AutoreleasePoolPage.png" alt="AutoreleasePoolPage" style="zoom:50%;" />

   * 自动释放池内存布局

     <img src="./res/autoreleasepool_struct.png" alt="autoreleasepool_struct" style="zoom:50%;" />

   * AutoreleasePoolPage内存布局

     <img src="./res/AutoreleasePoolPage_Memory.png" alt="AutoreleasePoolPage_Memory" style="zoom:50%;" />

   * next指针

     ```
     指向AutoreleasePoolPage对象中，下一个添加到自动释放池对象所要存放的地址。类似于栈顶指针
     ```

   * objc_autoreleasePoolPush 方法

     <img src="./res/autoreleaseFast.png" alt="autoreleaseFast" style="zoom:50%;" />

   * objc_autoreleasePoolPop 方法

     ```
     1. 使用 pageForPointer 获取当前 token 所在的 AutoreleasePoolPage
     2. 调用 releaseUntil 方法释放栈中的对象，直到 stop
     3. 调用 child 的 kill 方法
     ```

     <img src="./res/pop_process.png" alt="pop_process" style="zoom:50%;" />

9. 如何检测内存泄漏

   * MLeaksFinder
   * Instruments中的Leak动态分析

   

10. 如何调试BAD_ACCESS错误

    * 通过 Zombie

      ```
      原理
      1. 开启Zombie Objects后，dealloc将会被hook，被hook后执行dealloc，内存并不会真正释放，系统会修改对象的isa指针，指向_NSZombie_前缀名称的僵尸类，将该对象变为僵尸对象
      2. 僵尸类做的事情比较单一，就是响应所有的方法：抛出异常，打印一条包含消息内容及其接收者的消息，然后终止程序
      3. Zombie Objects是无法检测内存越界的
      ```

    * 设置全局断点快速定位问题代码所在行

    * Address Sanitizer

      ```
      作用
      1. 内存释放后又被使用
      2. 内存重复释放
      3. 释放未申请的内存
      4. 使用栈内存作为函数返回值
      5. 使用了超出作用域的栈内存
      6. 内存越界访问
      
      原理
      1. 启用Address Sanitizer后，会在APP中增加libclang_rt.asan_ios_dynamic.dylib，它将在运行时加载
      2. Address Sanitizer替换了malloc和free的实现。当调用malloc函数时，它将分配指定大小的内存A，并将内存A周围的区域标记为”off-limits“
      3. 当free方法被调用时，内存A也被标记为”off-limits“，同时内存A被添加到隔离队列，这个操作将导致内存A无法再被重新malloc使用
      4. 当访问到被标记为”off-limits“的内存时，Address Sanitizer就会报告异常
      ```