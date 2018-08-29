//
//  IndexViewController.m
//  MyMVVMProject
//
//  Created by winbei on 2018/8/13.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

#import "IndexViewController.h"
#import "DrawView.h"
@interface IndexViewController()

@end

@implementation IndexViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self testOne];
}
#pragma mark 添加测试图片
-(void)testOne{
    DrawView *dview = [[DrawView alloc]initWithFrame:self.view.frame];
    dview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dview];
}
@end
