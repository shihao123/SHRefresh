//
//  UIScrollView+SHRefresh.m
//  SHRefreshDemo
//
//  Created by zhugang on 17/1/12.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "UIScrollView+SHRefresh.h"
#import <objc/objc-runtime.h>
#define RefreshHeight 80
#define Sweight [UIScreen mainScreen].bounds.size.width

@implementation UIScrollView (SHRefresh)
-(void)addRefreshWithTarget:(id)target action:(SEL)action
{
    if (!self.refreshView)
    {
        self.refreshView = [[RefreshView alloc] init];
    }
    self.refreshView.frame = CGRectMake(0, -RefreshHeight, Sweight, RefreshHeight);
    [self addSubview:self.refreshView];
    self.refreshView.actionTarget = target;
    self.refreshView.action = action;
}

-(void)beginRefresh
{
    [self.refreshView viewBeginRefresh];
}

-(void)endRefresh
{
    [self.refreshView viewEndRefresh];
}

#pragma mark runtime添加属性
-(RefreshView *)refreshView
{
    return objc_getAssociatedObject(self, @"refreshView");
}
- (void)setRefreshView:(RefreshView *)refreshView
{
    objc_setAssociatedObject(self, @"refreshView", refreshView, OBJC_ASSOCIATION_RETAIN);

}

@end
