//
//  UIButton+FontScale.m
//  FoodManage
//
//  Created by DeshPeng on 2018/10/26.
//  Copyright © 2018 pzs. All rights reserved.
//

#import "UIButton+FontScale.h"
#import <objc/runtime.h>

static const NSUInteger unScale = 888;
//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define iPhone6Scale KScreenWidth/375.0

@implementation UIButton (FontScale)


+ (void)load {
    Method imp   = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        if (self.titleLabel.tag != unScale) {
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize * iPhone6Scale];
        }
    }
    return self;
}

@end

@implementation UILabel (FontScale)

+ (void)load {
    Method imp   = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成888跳过
        if (self.tag != unScale) {
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize * iPhone6Scale];
        }
    }
    return self;
}

@end
