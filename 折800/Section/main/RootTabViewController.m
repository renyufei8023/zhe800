//
//  RootTabViewController.m
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "RootTabViewController.h"
#import "PersonalCenterViewController.h"
#import "IntegralMallViewController.h"
#import "BrandGroupViewController.h"
#import "ClassViewController.h"
#import "RootViewController.h"
#import "BaseNavgationController.h"
#import "RDVTabBarItem.h"

@implementation RootTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewControllers];
}

- (void)setupViewControllers
{
    RootViewController *rootVC = [RootViewController new];
    UINavigationController *nav_root = [[BaseNavgationController alloc]initWithRootViewController:rootVC];
    
    ClassViewController *classVC = [ClassViewController new];
    UINavigationController *nav_class = [[BaseNavgationController alloc]initWithRootViewController:classVC];
    
    BrandGroupViewController *brandVC = [BrandGroupViewController new];
    UINavigationController *nac_brand = [[BaseNavgationController alloc]initWithRootViewController:brandVC];
    
    IntegralMallViewController *intergralVC = [IntegralMallViewController new];
    UINavigationController *nav_intergral = [[BaseNavgationController alloc]initWithRootViewController:intergralVC];
    
    PersonalCenterViewController *personalVC = [PersonalCenterViewController new];
    UINavigationController *nav_personal = [[BaseNavgationController alloc]initWithRootViewController:personalVC];
    
    [self setViewControllers:@[nav_root,nav_class,nac_brand,nav_intergral,nav_personal]];
    [self customizeTabBarForController];
    self.delegate = self;
    
}

- (void)customizeTabBarForController
{
    UIImage *backgroundImage = [UIImage imageNamed:@"home_tab_bg"];
    NSArray *tabBarItemImages = @[@"home_tab_home",@"home_tab_saunter",@"home_tab_branc",@"home_tab_point",@"home_tab_personal"];
    NSArray *tabBarItemTitles = @[@"首页",@"分类",@"品牌团",@"积分商城",@"个人中心"];
    NSUInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, -10);
        item.imagePositionAdjustment = UIOffsetMake(0, 5);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_btn",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected_btn",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.text = title;
    childVc.navigationItem.titleView = titleLab;
    // 设置图标
    
    // 2.包装一个导航控制器
    BaseNavgationController *nav = [[BaseNavgationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];

}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    return YES;
}
@end
