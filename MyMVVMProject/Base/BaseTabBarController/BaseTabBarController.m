//
//  BaseTabBarController.m
//  MyMVVMProject
//
//  Created by winbei on 2018/8/13.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBar.h"
#import "BaseViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 利用KVO来使用自定义的tabBar
    [self setValue:[[BaseTabBar alloc] init] forKey:@"tabBar"];
    
    [self addAllChildViewController];
    
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    NSArray *titles = @[@"发现", @"关注", @"消息", @"我的"];
    NSArray *images = @[@"icon_tabbar_home~iphone", @"icon_tabbar_subscription~iphone", @"icon_tabbar_notification~iphone", @"icon_tabbar_me~iphone"];
    NSArray *selectedImages = @[@"icon_tabbar_home_active~iphone", @"icon_tabbar_subscription_active~iphone", @"icon_tabbar_notification_active~iphone", @"icon_tabbar_me_active~iphone"];
    NSArray *classArr = @[@"IndexViewController",@"BaseViewController",@"BaseViewController",@"BaseViewController"];
    for (NSInteger i=0; i<selectedImages.count; i++) {
        Class vc = NSClassFromString(classArr[i]);
        BaseViewController *homeVC = (BaseViewController *)[[vc alloc] init];
        [self addChildViewController:homeVC title:titles[i] imageNamed:images[i] selectedImageName:selectedImages[i]];
    }
   
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageName:(NSString *)selectedImageName
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:nav];
}

@end
