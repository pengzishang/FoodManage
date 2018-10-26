//
//  UIViewController+Refresh.h
//
//  Created by pzs on 2017/4/24.
//  Copyright © 2017年 usmeibao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WeakSelf(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;

#define StrongSelf(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;

@interface UIViewController (Refresh)

/*
 *添加下拉刷新，block方式
 */
- (void)addRefreshHeaderWithBlock:(void (^)(void))block;

/*
 *添加上拉刷新，block方式
 */
- (void)addRefreshFooterWithBlock:(void (^)(void))block;

- (void)removeRefreshHeader;

//
- (void)removeRefreshFooter;

/*
 *启动下拉刷新,用户可以主动启动下拉刷新来获取首次数据，但上拉用于获取分页数据，由MJRefresh启动。
 */
- (void)beginRefreshHeader;

/*
 *结束刷新，内部区分header和footer
 */
- (void)endRefresh;

/*
 *结束刷新,并告知无更多数据，footer方法
 */
- (void)endRefreshWithNoMoreData;


/**
 隐藏header
 */
- (void)hideHeader;

/**
 显示header
 */
- (void)displayHeader;

/**
 隐藏footer
 */
- (void)hideFooter;


/**
 显示footer
 */
- (void)displayFooter;
@end
