//
//  BaseNavgationController.m
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "BaseNavgationController.h"

@implementation BaseNavgationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
