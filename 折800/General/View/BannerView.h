//
//  BannerView.h
//  折800
//
//  Created by renyufei on 15/9/1.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PageControlAlignment) {
    PageControlAlignmentLeft      = 0,    // Visually left aligned

    PageControlAlignmentCenter    = 1,    // Visually centered
    PageControlAlignmentRight     = 2,    // Visually right aligned
};
@class BannerView;
@protocol BannerViewDelegate <NSObject>

@optional
- (void)bannerView:(BannerView *)bannerView didSelectAtIndex:(NSUInteger)index;

@end
@interface BannerView : UIView
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, assign) PageControlAlignment pageControlAlignment;
- (void)initWithBanner:(NSArray *)imageArray;

@property (nonatomic, weak) id<BannerViewDelegate>delegate;
@end
