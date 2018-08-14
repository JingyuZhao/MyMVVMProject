//
//  BaseTabBar.m
//  MyMVVMProject
//
//  Created by winbei on 2018/8/13.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//
/*
 自定义Tabbar一般就两种方式：
 1.在原 UItabBar 样式的基础上扩展
 2.完全自定义 UITabBar 的样式
 本文采用第一种方式
 */
/*
 使用原生的 tabBarItem，在这基础上添加自定义控件
 思路：
 1.往 tabBar 上添加自定义的控件
 2.重新布局 tabBarItem 和 自定义控件
 3.使用自定义的 tabBar
 */
#import "BaseTabBar.h"

@interface BaseTabBar()
@property (nonatomic,strong) UIButton *centerBtn;
@end
@implementation BaseTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tintColor = [UIColor colorWithRed:215/255.0 green:111/255.0 blue:96/255.0 alpha:1.0];
        [self addSubview:self.centerBtn];
    }
    return self;
}
#pragma mark 重写layoutSubviews 重新布局tabBarItem和自定义控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //把tabBarButton取出来,然后进行重新布局
    NSMutableArray *tabBarButtonsArr = [NSMutableArray new];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonsArr addObject:subview];
        }
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    //设置中间按钮的位置，居中，凸起一点点
    self.centerBtn.center = CGPointMake(barWidth/2, barHeight/2 - centerBtnHeight/2);
    //重新布局其他tabBarItem的位置，平均分配其他的item的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth)/tabBarButtonsArr.count;
    // 逐个布局tabBarItem，修改UITabBarButton的frame
    [tabBarButtonsArr enumerateObjectsUsingBlock:^(UIView  *_Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx>=tabBarButtonsArr.count/2) {
            //重新设置x坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx*barItemWidth + centerBtnWidth;
        }else{
            frame.origin.x = idx * barItemWidth;
        }
        //重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    [self bringSubviewToFront:self.centerBtn];
    
}

#pragma mark 懒加载
-(UIButton *)centerBtn{
    if (_centerBtn==nil) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(0, 0, 80, 60);
        [_centerBtn setImage:[UIImage imageNamed:@"button_write"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(centerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}
-(void)centerBtnAction{
    NSLog(@"点击了按钮");
}
#pragma mark 修改hit：test方法
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.clipsToBounds||self.hidden||self.alpha<=0.01) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    //如果时间发生在tabBar里面直接返回
    if (result) {
        return result;
    }
    //这里遍历那些超出的部分就可以了
    for (UIView *subview in self.subviews) {
        CGPoint subpoint = [subview convertPoint: point fromView:self];
        result = [subview hitTest:subpoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
    
}
@end
