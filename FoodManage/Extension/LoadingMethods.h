//
//  LoadingMethods.h
//  homesecurity
//
//  Created by pzs on 2017/12/28.
//  Copyright © 2017年 boyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingMethods : NSObject

/**
 短时间动画
 
 @param time <#time description#>
 @param maintitle <#maintitle description#>
 @param subTitle <#subTitle description#>
 */
+ (void)showForShortTime:(NSUInteger)time mainTitle:(NSString *_Nullable)maintitle subTitle:(NSString *_Nullable)subTitle;

+ (void)showForShortTime:(NSUInteger)time mainTitle:(NSString *_Nullable)maintitle subTitle:(NSString *_Nullable)subTitle complete:(void(^ _Nullable)(void))complete;

/**
 只显示文字

 @param time <#time description#>
 @param text <#text description#>
 @param complete <#complete description#>
 */
+ (void)showOnlyTextShortTime:(NSUInteger)time text:(NSString *_Nullable)text complete:(void(^_Nullable)(void))complete;
/**
 开始显示一段屏幕提示
 
 @param mainTitle <#mainTitle description#>
 @param subTitle <#subTitle description#>
 */
+ (void)startAnimationWithMainTitle:(NSString *_Nullable)mainTitle subTitle:(NSString *_Nullable)subTitle;

/**
 停止显示屏幕提示
 
 @param mainTitle <#mainTitle description#>
 @param subTitle <#subTitle description#>
 */
+ (void)stopAnimationWithMainTitle:(NSString *_Nullable)mainTitle subTitle:(NSString *_Nullable)subTitle;

+ (void)stopAnimationWithMainTitle:(NSString *_Nullable)mainTitle subTitle:(NSString *_Nullable)subTitle deley:(NSTimeInterval)time;

+ (void)stopAnimationWithMainTitle:(NSString *_Nullable)mainTitle subTitle:(NSString *_Nullable)subTitle deley:(NSTimeInterval)time complete:(void(^_Nullable)(void))complete;

+ (void)stopAnimation;

/**
 进度圈

 @param progress <#progress description#>
 @param mainTitle <#mainTitle description#>
 @param subTitle <#subTitle description#>
 @param complete <#complete description#>
 */
+ (void)progressWithprogress:(NSUInteger)progress mainTitle:(NSString *_Nullable)mainTitle subTitle:(NSString *_Nullable)subTitle complete:(void(^_Nullable)(void))complete;
@end
