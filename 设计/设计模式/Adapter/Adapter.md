# iOS 设计模式 - 适配器
## 原理图
### 对象适配器
![](/Users/mye/Downloads/Work/XiaoZhongWen/Design Pattern/Adapter/Object Adapter.png)

### 类适配器
多重继承
![](/Users/mye/Downloads/Work/XiaoZhongWen/Design Pattern/Adapter/Class Adaptor.png)

## 说明
* 为了让客户端尽可能的通用,我们使用适配器模式来隔离客户端与外部参数的联系,只让客户端与适配器通信.
* 实现重用没有提供给客户端所要求接口的类的方式
* 协同具有不兼容接口类之间的工作

## 代码实现

名片协议

```
//
//  BusinessCardAdapterProtocol.h
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BusinessCardAdapterProtocol <NSObject>

- (NSString *)name;

- (UIColor *)lineColor;

- (NSString *)phoneNumber;

@end

```

适配器

```
//
//  BusinessCardAdapter.h
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessCardAdapterProtocol.h"

@interface BusinessCardAdapter : NSObject <BusinessCardAdapterProtocol>

/**
 *  输入对象
 */
@property (nonatomic, weak) id data;

/**
 *  与输入对象建立联系
 *
 *  @param data 输入的对象
 *
 *  @return 实例对象
 */
- (instancetype)initWithData:(id)data;

@end

//
//  BusinessCardAdapter.m
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import "BusinessCardAdapter.h"
#import <UIKit/UIKit.h>

@implementation BusinessCardAdapter

- (instancetype)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        self.data = data;
    }
    
    return self;
}

- (NSString *)name {
    
    return nil;
}

- (UIColor *)lineColor {
    
    return nil;
}

- (NSString *)phoneNumber {
    
    return nil;
}

@end

```

客户端

```
//
//  BusinessCard.h
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCardAdapterProtocol.h"

@interface BusinessCard : UIView

- (void)loadData:(id<BusinessCardAdapterProtocol>)data;

@end

//
//  BusinessCard.m
//  Adapter
//
//  Created by mye on 2019/3/12.
//  Copyright © 2019 mye. All rights reserved.
//

#import "BusinessCard.h"

@interface BusinessCard()

/**
 *  名字
 */
@property (nonatomic, strong) NSString *name;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor  *lineColor;

/**
 *  电话号码
 */
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UILabel  *phoneNumberLabel;

@end

@implementation BusinessCard

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.backgroundColor     = [UIColor whiteColor];
    self.layer.borderWidth   = 0.5f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset  = CGSizeMake(5, 5);
    self.layer.shadowRadius  = 1.f;
    self.layer.shadowColor   = [UIColor grayColor].CGColor;
    
    
    self.nameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 25)];
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20.f];
    [self addSubview:self.nameLabel];
    
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, 200, 5)];
    [self addSubview:self.lineView];
    
    
    self.phoneNumberLabel               = [[UILabel alloc] initWithFrame:CGRectMake(41, 105, 150, 20)];
    self.phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    self.phoneNumberLabel.font          = [UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:16.f];
    [self addSubview:self.phoneNumberLabel];
}

- (void)loadData:(id <BusinessCardAdapterProtocol>)data {
    
    self.name        = [data name];
    self.lineColor   = [data lineColor];
    self.phoneNumber = [data phoneNumber];
}

@synthesize name        = _name;
@synthesize lineColor   = _lineColor;
@synthesize phoneNumber = _phoneNumber;

- (void)setName:(NSString *)name {
    
    _name           = name;
    _nameLabel.text = name;
}

- (NSString *)name {
    
    return _name;
}

- (void)setLineColor:(UIColor *)lineColor {
    
    _lineColor                = lineColor;
    _lineView.backgroundColor = _lineColor;
}

- (UIColor *)lineColor {
    
    return _lineColor;
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    
    _phoneNumber           = phoneNumber;
    _phoneNumberLabel.text = phoneNumber;
}

- (NSString *)phoneNumber {
    
    return _phoneNumber;
}

@end

```


