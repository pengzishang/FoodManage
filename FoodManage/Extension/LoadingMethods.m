//
//  LoadingMethods.m
//  homesecurity
//
//  Created by pzs on 2017/12/28.
//  Copyright © 2017年 boyue. All rights reserved.
//

#import "LoadingMethods.h"
#import "MBProgressHUD.h"
@implementation LoadingMethods

static NSUInteger const MBPTag = 2345;

+ (UIView *)getCurrentView {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return [window subviews][0];
}

+ (UIView *)topView {
    UIViewController *resultVC;
    resultVC = [LoadingMethods _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC.view;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [LoadingMethods _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [LoadingMethods _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

/**
 *  开始一段屏幕提示
 *
 *  @param mainTitle <#mainTitle description#>
 *  @param subTitle  <#subTitle description#>
 */
+ (void)startAnimationWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        UIView *frontView = [LoadingMethods getCurrentView];
        UIView *frontView = [LoadingMethods topView];
        MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:frontView];
            hud.tag = MBPTag;
            [hud setRemoveFromSuperViewOnHide:YES];
            [hud showAnimated:YES];
            [frontView addSubview:hud];
        }
        hud.label.text = mainTitle;
        hud.detailsLabel.text = subTitle;
    });
}

/**
 *  停止一段屏幕动画
 *
 *  @param mainTitle <#mainTitle description#>
 *  @param subTitle  <#subTitle description#>
 */
+ (void)stopAnimationWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle {
    [self stopAnimationWithMainTitle:mainTitle subTitle:subTitle deley:0.5];
}

+ (void)stopAnimationWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle deley:(NSTimeInterval)time {
    [self stopAnimationWithMainTitle:mainTitle subTitle:subTitle deley:time complete:nil];
}

+ (void)stopAnimationWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle deley:(NSTimeInterval)time complete:(void(^)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *frontView = [LoadingMethods topView];
        MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
        if (hud) {
            hud.label.text = mainTitle;
            hud.detailsLabel.text = subTitle;
            [hud hideAnimated:YES afterDelay:time];
            hud.completionBlock = ^{
                if (complete) {
                    complete();
                }
            };
        }
        
    });
}

+ (void)stopAnimation
{
    UIView *frontView = [LoadingMethods topView];
    MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
    [hud hideAnimated:YES];
}


/**
 *  一段短暂显示的动画
 *
 *  @param time      <#time description#>
 *  @param mainTitle <#mainTitle description#>
 *  @param subTitle  <#subTitle description#>
 */

+ (void)showForShortTime:(NSUInteger)time mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle {
    [LoadingMethods showForShortTime:time mainTitle:mainTitle subTitle:subTitle complete:^{
        
    }];
}

+ (void)showForShortTime:(NSUInteger)time mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle complete:(void(^)(void))complete
{
    UIView *frontView = [LoadingMethods topView];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:frontView];
            hud.tag = MBPTag;
            [hud setRemoveFromSuperViewOnHide:YES];
            [hud showAnimated:YES];
            [hud setCompletionBlock:^{
                if (complete) {
                    complete();
                }
            }];
            [frontView addSubview:hud];
        }
        hud.label.text = mainTitle;
        hud.detailsLabel.text = subTitle;
        [hud hideAnimated:YES afterDelay:time];
    });
    
}

+ (void)showOnlyTextShortTime:(NSUInteger)time text:(NSString *)text complete:(void(^)(void))complete
{
    UIView *frontView = [LoadingMethods topView];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:frontView];
            hud.tag = MBPTag;
            [hud setRemoveFromSuperViewOnHide:YES];
            [hud showAnimated:YES];
            [hud setCompletionBlock:^{
                if (complete) {
                    complete();
                }
            }];
            [frontView addSubview:hud];
        }
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.color = [UIColor blackColor];
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:time];
    });
}

+ (void)progressWithprogress:(NSUInteger)progress mainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle complete:(void (^)(void))complete
{
    //        UIView *frontView = [LoadingMethods getCurrentView];
    UIView *frontView = [LoadingMethods topView];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [frontView viewWithTag:MBPTag];
        if (!hud) {
            hud = [[MBProgressHUD alloc] initWithView:frontView];
            hud.tag = MBPTag;
            //            hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
            hud.progress = 0.f;
            [hud setRemoveFromSuperViewOnHide:YES];
            [hud showAnimated:YES];
            [hud setCompletionBlock:^{
                if (complete) {
                    complete();
                }
            }];
            [frontView addSubview:hud];
        }
        else
        {
            hud.progress = progress;
            hud.label.text = [NSString stringWithFormat:@"正在下载：%@%%",mainTitle];
            hud.detailsLabel.text = subTitle;
            if (progress >= 1.f) {
                [hud hideAnimated:YES afterDelay:1];
                hud.label.text = @"下载完成";
                hud.detailsLabel.text = subTitle;
            }
            [frontView setNeedsDisplay];
        }
        
    });
}

@end
