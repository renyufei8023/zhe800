//
//  RootViewController.m
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "RootViewController.h"
#import "BannerView.h"

@interface RootViewController ()<BannerViewDelegate>

@end
@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *imageArray = @[@"http://7xk68o.com1.z0.glb.clouddn.com/1.jpg",
                            @"http://7xk68o.com1.z0.glb.clouddn.com/2.jpg",
                            @"http://7xk68o.com1.z0.glb.clouddn.com/3.jpg",
                            @"http://7xk68o.com1.z0.glb.clouddn.com/4.jpg",
                            @"http://7xk68o.com1.z0.glb.clouddn.com/5.jpg",
                            
                            ];
    BannerView *bannerView = [[BannerView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    bannerView.currentPageIndicatorTintColor = [UIColor redColor];
    bannerView.pageIndicatorTintColor = [UIColor blackColor];
    bannerView.pageControlAlignment = PageControlAlignmentCenter;
    [bannerView initWithBanner:imageArray];
}

- (void)bannerView:(BannerView *)bannerView didSelectAtIndex:(NSUInteger)index
{
    NSLog(@"选中了第%@个",@(index));
}
@end
