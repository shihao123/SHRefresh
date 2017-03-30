//
//  UIScrollView+SHRefresh.h
//  SHRefreshDemo
//
//  Created by zhugang on 17/1/12.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshView.h"
@interface UIScrollView (SHRefresh)
@property (nonatomic,strong) RefreshView*refreshView;

-(void)addRefreshWithTarget:(id)target action:(SEL)action;

-(void)beginRefresh;

-(void)endRefresh;

@end
