//
//  RefreshView.m
//  SHRefreshDemo
//
//  Created by zhugang on 17/1/12.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "RefreshView.h"
#define Refresh_Height 80
#define Sweight [UIScreen mainScreen].bounds.size.width

@implementation RefreshView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.animationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        self.animationView.frame = CGRectMake(Sweight/2-80, 0, 80, 80);
        [self addSubview:self.animationView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Sweight/2, 30, Sweight/2, 20)];
        self.titleLabel.text = normalTitle;
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.parentView = (UIScrollView *)newSuperview;
        [self.parentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGFloat offset = self.parentView.contentOffset.y;
        NSLog(@"%f",offset);
        if (self.parentView.isDragging) {
            if (self.refreshStatus == RefreshStateNormal && -offset >= Refresh_Height) {
                self.refreshStatus = RefreshStatePullDown;
            }
            else if (self.refreshStatus == RefreshStatePullDown && -offset < Refresh_Height){
                self.refreshStatus = RefreshStateNormal;
            }
        }
        else if(!self.parentView.isDragging){
            
            if (self.refreshStatus == RefreshStatePullDown) {
                
                self.refreshStatus = RefreshStateRefresh;
            }
        }
    }
    
}
-(void)viewBeginRefresh
{
    self.refreshStatus = RefreshStateRefresh;
    
}
-(void)viewEndRefresh
{
    self.refreshStatus = RefreshStateNormal;
}

//设置刷新状态
- (void)setRefreshStatus:(RefreshStatus)refreshStatus{
    _refreshStatus = refreshStatus;
    switch (_refreshStatus) {
        case RefreshStateNormal:
            self.titleLabel.text = normalTitle;
            [self endAnimation];
            [self changeContentInset:0];
            break;
        case RefreshStatePullDown:
            self.titleLabel.text = pulldownTitle;
            [self beginAnimation];
            break;
        case RefreshStateRefresh:
            self.titleLabel.text = RefreshTitle;
            [self beginAnimation];
            [self changeContentInset:Refresh_Height];
            [self refreshAction];
            
            break;
    }
}
- (void)beginAnimation
{
    self.animationView.animationImages = self.animationImages;
    self.animationView.animationDuration = 2;
    [self.animationView startAnimating];
}
- (void)endAnimation
{
    [self.animationView stopAnimating];
    self.animationView.image = [UIImage imageNamed:@"1"];
}
//改变contentInset
- (void)changeContentInset:(CGFloat)top
{
    self.parentView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
}
//执行动作
- (void)refreshAction
{
    [self.actionTarget performSelector:self.action withObject:nil afterDelay:0];
}

- (NSArray *)animationImages {
    if (_animationImages == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i < 20; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
            [array addObject:image];
        }
        _animationImages = array;
    }
    return  _animationImages;
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
