//
//  UIViewController+ClassNamePrint.m
//
//  Created by pzs on 2017/10/12.
//  Copyright © 2017年 Hub 6. All rights reserved.
//

#import "UIViewController+ClassNamePrint.h"

@implementation UIViewController (ClassNamePrint)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//       Method viewDidLoad              = class_getInstanceMethod(self, @selector(viewDidLoad));
//        Method viewDidLoadWithPrintName = class_getInstanceMethod(self, @selector(viewDidLoadWithPrintName));
//       method_exchangeImplementations(viewDidLoad, viewDidLoadWithPrintName);
//    });
}


- (void)viewDidLoadWithPrintName {
    [self viewDidLoadWithPrintName];
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        NSLog(@"\n          根视图:%@ 被载入\n", self);
    } else {
        NSInteger pre = [self.navigationController.viewControllers indexOfObject:self] - 1;
        if (pre >= 0 && self.navigationController.viewControllers.count > pre) {
            NSLog(@"\n          视图:%@ 被载入\n          上一个视图:%@\n", self, self.navigationController.viewControllers[pre]);
        }
    }

}


@end
