# Implementation details

## 接口访问的并发量控制及统一回调

* 请求对象

```objective-c
@interface Target: NSObject

/// 请求类型
@property (nonatomic, assign) RequestType requestType;

/// 认证value
@property (nonatomic, copy) NSString *authorization;

/// 请求的url
@property (nonatomic, copy) NSString *url;

/// 可接受的类型集合
@property (nonatomic, strong) NSSet *acceptableContentTypes;

/// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;

/// 成功回调
@property (nonatomic, copy) void (^success)(id _Nullable task, id _Nullable responseObject);

/// 失败回调
@property (nonatomic, copy) void (^failure)(id _Nullable task, NSError * _Nullable error);

@end
```

* 处理请求

  ![bf1](../../resources/iOS/bf1.png)

  ![bf1](../../resources/iOS/bf2.png)

  ![bf1](../../resources/iOS/bf3.png)

## NSTimer强引用问题的解决方案

* 用dispatch_source_t封装一个Timer

  ```objective-c
  dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                              0,
                                              0,
                                              self.privateSerialQueue);
  - (void)schedule {
      [self resetTimerProperties];
  
      __weak MSWeakTimer *weakSelf = self;
  
      dispatch_source_set_event_handler(self.timer, ^{
          [weakSelf timerFired];
      });
  
      dispatch_resume(self.timer);
  }
  
  - (void)invalidate {
      // We check with an atomic operation if it has already been invalidated. Ideally we would synchronize this on the private queue,
      // but since we can't know the context from which this method will be called, dispatch_sync might cause a deadlock.
      if (!OSAtomicTestAndSetBarrier(7, &_timerFlags.timerIsInvalidated))
      {
          dispatch_source_t timer = self.timer;
          dispatch_async(self.privateSerialQueue, ^{
              dispatch_source_cancel(timer);
              ms_release_gcd_object(timer);
          });
      }
  }
  ```

  

* 用NSProxy代理

  ```objective-c
  @interface WeakProxy: NSProxy
  @property (nonatomic, weak)id target;
  + (instancetype)proxyWithTarget:(id)target;
  @end
    
  @implementation WeakProxy
  + (instancetype)proxyWithTarget:(id)target {
      WeakProxy *proxy = [[self class] alloc];
      proxy.target = target;
      return proxy;
  }
  
  //获取target类中的sel方法的方法签名
  - (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
      return [self.target methodSignatureForSelector:sel];
  }
  
  - (void)forwardInvocation:(NSInvocation *)invocation {
      //判断target是否实现了该方法
      if ([self.target respondsToSelector:invocation.selector]) {
          //让target调用该方法
          [invocation invokeWithTarget:self.target];
      }else {
          //找不到该方法
          [invocation doesNotRecognizeSelector:invocation.selector];
      }
  }
  
  @end
    
  _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[TargetProxy proxyWithTarget:self] selector:@selector(yourMethod) userInfo:nil repeats:YES];
  ```

  

## 高清大图的解码及异步渲染过程

[如何处理iOS中照片的方向](http://www.cocoachina.com/articles/12021)

* SDWebImage 图片解码过程

  * 将图片元数据编码为UIImage对象

    ![sd_decode_1](../../resources/iOS/sd_decode_1.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_2.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_3.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_4.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_5.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_6.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_7.png)

  * 解码UIImage对象为新的解码后的UIImage对象

    ![sd_decode_1](../../resources/iOS/sd_decode_8.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_9.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_10.png)

    ![sd_decode_1](../../resources/iOS/sd_decode_11.png)

* YYImage 图片解码过程

  * decodeForDisplay
  
    ![sd_decode_1](../../resources/iOS/yy_decodeForDisplay.png)
  
  * decodeOnly 直接获取解码图片，非通过画布绘制生成
  
    1. CGImageSourceCreateWithData(data) 创建 ImageSource
    2. CGImageSourceCreateImageAtIndex(source) 创建一个未解码的 CGImage
    3. CGImageGetDataProvider(image) 获取这个图片的数据源
    4. CGDataProviderCopyData(provider) 从数据源获取直接解码的数据
  
    ![sd_decode_1](../../resources/iOS/yy_decode.png)
  
* YYWebImage 边下载、边显示

  图片本身有 3 种常见的编码方式：

  <img src="https://blog.ibireme.com/wp-content/uploads/2015/11/image_baseline.gif" alt="image_baseline" style="zoom:50%;" /><img src="https://blog.ibireme.com/wp-content/uploads/2015/11/image_interlaced.gif" alt="image_interlaced" style="zoom:50%;" /><img src="https://blog.ibireme.com/wp-content/uploads/2015/11/image_progressive.gif" alt="image_progressive" style="zoom:50%;" />

  

  1. baseline，即逐行扫描。默认情况下，JPEG、PNG、GIF 都是这种保存方式
  2. interlaced，即隔行扫描。PNG 和 GIF 在保存时可以选择这种格式
  3. progressive，即渐进式。JPEG 在保存时可以选择这种方式

  ```
  在下载图片时，首先用 CGImageSourceCreateIncremental(NULL) 创建一个空的图片源，随后在获得新数据时调用CGImageSourceUpdateData(data, false) 来更新图片源，最后在用CGImageSourceCreateImageAtIndex() 创建图片来显示。
  ```

  * 实现过程

    1. 创建NSURLConnection，发起下载请求

       ![sd_decode_1](../../resources/iOS/yy_progressive_1.png)

    2. 创建NSMutableData对象，用于接收图片元数据

       ![sd_decode_1](../../resources/iOS/yy_progressive_2.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_3.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_4.png)

    3. 接收图片数据并更新source

       ![sd_decode_1](../../resources/iOS/yy_progressive_5.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_6.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_7.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_8.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_9.png)

       ![sd_decode_1](../../resources/iOS/yy_update_1.png)

       ![sd_decode_1](../../resources/iOS/yy_update_2.png)

       ![sd_decode_1](../../resources/iOS/yy_update_3.png)

       ![sd_decode_1](../../resources/iOS/yy_progressive_4.png)

## 富文本的布局计算及渲染过程





## 崩溃问题监控



## 卡顿问题监控



## OOM监控



## 电量消耗监控



## Cocoapods如何在组件的开发期间控制组件版本

