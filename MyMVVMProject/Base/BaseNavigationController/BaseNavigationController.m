//
//  BaseNavigationController.m
//  MyMVVMProject
//
//  Created by winbei on 2018/8/14.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) id popDelegate;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
//自定义手势返回
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *popRecognizer;
@property(nonatomic,assign) BOOL isSystemSlidBack;//是否开启系统右滑返回
@end

@implementation BaseNavigationController
//APP生命周期中 只会执行一次

+(void)initialize{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //去掉阴影线
    [navBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置全局手势返回
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    //只有在使用转场动画时，禁用系统手势，开启自定义右划手势
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}
#pragma mark 解决手势失效问题
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}
//根视图禁用右划返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count == 1 ? NO : YES;
}

//push
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
//        if ([viewController conformsToProtocol:@protocol(XYTransitionProtocol)] && [self isNeedTransition:viewController]) {
//            viewController.hidesBottomBarWhenPushed = NO;
//        }else{
//            viewController.hidesBottomBarWhenPushed = YES;
//        }
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    //修改tabBar的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[RootViewController class]]) {
        RootViewController * vc = (RootViewController *)viewController;
        if (vc.isHidenNavBar) {
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

#pragma mark -- NavitionContollerDelegate
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (!self.interactivePopTransition) { return nil; }
    return self.interactivePopTransition;
}
#pragma mark UIGestureRecognizer handlers
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    //    progress = MIN(1.0, MAX(0.0, progress));
    //    NSLog(@"右划progress %.2f",progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

@end
