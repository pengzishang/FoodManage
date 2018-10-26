//
//  UIViewController+Refresh.m
//
//  Created by pzs on 2017/4/24.
//  Copyright © 2017年 usmeibao. All rights reserved.
//

#import "UIViewController+Refresh.h"
#import "MJRefresh.h"
@implementation UIViewController (Refresh)

- (void)setRefreshScrollView:(UIScrollView *)refreshScrollView {
    objc_setAssociatedObject(self, @selector(refreshScrollView), refreshScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)refreshScrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, _cmd);
    if (scrollView) {
        return scrollView;
    }
    if ([self isKindOfClass:[UITableViewController class]]) {
        scrollView = [(UITableViewController *) self tableView];
    } else if ([self isKindOfClass:[UICollectionViewController class]]) {
        scrollView = [(UICollectionViewController *) self collectionView];
    } else if ([self isKindOfClass:[UIViewController class]]) {
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UITableView class]] || [subview isKindOfClass:[UICollectionView class]]) {
                scrollView = (UIScrollView *) subview;
                break;
            }
        }
    }
    [self setRefreshScrollView:scrollView];
    return scrollView;
}

- (void)addRefreshHeaderWithBlock:(void (^)(void))block; {
    if (self.refreshScrollView.mj_header == nil) {
        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (block) {
                block();
            }
        }];
        refreshHeader.activityIndicatorViewStyle                  = UIActivityIndicatorViewStyleWhite;
        self.refreshScrollView.mj_header                          = refreshHeader;
        self.refreshScrollView.mj_header.automaticallyChangeAlpha = YES;
    }
}

- (void)addRefreshFooterWithBlock:(void (^)(void))block {
    //存在重复添加的可能，故先置空。
    if (self.refreshScrollView.mj_footer) {
        [self removeRefreshFooter];
    }

    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];

    refreshFooter.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.refreshScrollView.mj_footer         = refreshFooter;
}

- (void)removeRefreshHeader {
    self.refreshScrollView.mj_header = nil;
}

- (void)removeRefreshFooter {
    self.refreshScrollView.mj_footer = nil;
}

- (void)beginRefreshHeader {
    if (self.refreshScrollView.mj_header.isRefreshing) {
        return;
    }
    [self.refreshScrollView.mj_header beginRefreshing];
}

- (void)endRefresh {
    if ([self.refreshScrollView.mj_header isRefreshing]) {
        [self.refreshScrollView.mj_header endRefreshing];
    } else if ([self.refreshScrollView.mj_footer isRefreshing]) {
        [self.refreshScrollView.mj_footer endRefreshing];
    }
}

- (void)endRefreshWithNoMoreData {
    [self.refreshScrollView.mj_footer endRefreshingWithNoMoreData];
}

- (void)hideHeader {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.3];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshScrollView.mj_header.hidden = YES;
        });
    });

}

- (void)displayHeader {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.3];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshScrollView.mj_header.hidden = NO;
        });
    });
}

- (void)hideFooter {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.3];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshScrollView.mj_footer.hidden = YES;
        });
    });

}

- (void)displayFooter {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:0.3];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.refreshScrollView.mj_footer.hidden = NO;
        });
    });
}

@end
