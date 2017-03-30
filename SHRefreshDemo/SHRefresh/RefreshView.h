//
//  RefreshView.h
//  SHRefreshDemo
//
//  Created by zhugang on 17/1/12.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RefreshStatus) {
    RefreshStateNormal = 0,    //正常状态
    RefreshStatePullDown,       //下拉状态
    RefreshStateRefresh,    //刷新状态
};
static NSString *normalTitle  = @"下拉更新";
static NSString *pulldownTitle  = @"松手更新";
static NSString *RefreshTitle  = @"更新中...";

@interface RefreshView : UIView

@property (nonatomic, strong) UIImageView *animationView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSArray *animationImages;

@property (nonatomic,weak) id actionTarget;

@property (nonatomic)SEL action;

@property (nonatomic,strong) UIScrollView *parentView;

@property (nonatomic) RefreshStatus refreshStatus;

-(void)viewBeginRefresh;

-(void)viewEndRefresh;

@end
