//
//  BannerView.m
//  折800
//
//  Created by renyufei on 15/9/1.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//
#define selfWith self.frame.size.width
#define selfHeigh self.frame.size.height
#define selfX self.frame.origin.x
#define selfY self.frame.origin.y
#import "BannerView.h"
#import "UIView+RYF.h"

@interface BannerView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *bannerScrollView;
@property (nonatomic, strong) UIPageControl *pageControls;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentPage;

@end
@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.pageControlAlignment == PageControlAlignmentLeft) {
        _pageControls.frame = CGRectMake(10, selfHeigh - 25, 100, 30);
    }else if (self.pageControlAlignment == PageControlAlignmentCenter){
        CGPoint pagepoint = CGPointMake(selfWith/2, selfHeigh - 25);
        _pageControls.frame = CGRectMake(pagepoint.x - 50, pagepoint.y, 100, 30);
    }else if(self.pageControlAlignment == PageControlAlignmentRight){
        _pageControls.frame = CGRectMake(selfWith - 110, selfHeigh - 25, 100, 30);
    }
    
    [self addSubview:self.pageControls];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    for (UIView *view in self.bannerScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            imageView.frame = CGRectMake(imageView.tag*width, 0, width, height);
        }
    }
    self.bannerScrollView.contentSize = CGSizeMake(width*3, height);
    self.bannerScrollView.contentOffset = CGPointMake(width, 0);
    
    
}


- (UIScrollView *)bannerScrollView
{
    
    if (_bannerScrollView == nil) {
        _bannerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, selfWith, selfHeigh)];
        for (int i = 0; i < 3; i ++) {
            UIImageView *imageView = [UIImageView new];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerClick:)];
            [imageView addGestureRecognizer:gesture];
            [_bannerScrollView addSubview:imageView];
        }
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        _bannerScrollView.directionalLockEnabled = YES;
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.delegate = self;
        _bannerScrollView.backgroundColor = [UIColor lightGrayColor];
        _bannerScrollView.contentOffset = CGPointZero;
        [self addSubview:_bannerScrollView];
        [_bannerScrollView addSubview:self.pageControls];
    }
    return _bannerScrollView;
}

- (void)bannerClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectAtIndex:)]) {
        [self.delegate bannerView:self didSelectAtIndex:self.currentPage];
    }
}

- (UIPageControl *)pageControls
{
    if (_pageControls == nil) {
        _pageControls = [UIPageControl new];
        _pageControls.backgroundColor = [UIColor clearColor];
        _pageControls.numberOfPages = self.imageArray.count;
        
        if (self.currentPageIndicatorTintColor == nil) {
            _pageControls.currentPageIndicatorTintColor = [UIColor whiteColor];
        }else{
            _pageControls.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
        }
        
        if (self.pageIndicatorTintColor == nil) {
            _pageControls.pageIndicatorTintColor = [UIColor lightGrayColor];
        }else{
            _pageControls.pageIndicatorTintColor = self.pageIndicatorTintColor;
        }
    }
    return _pageControls;
}

- (void)initView
{
    self.currentPage = 0;
    [self addTimer];
}

- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
/*定时器方法*/
- (void)changePage
{
    CGPoint offSet = CGPointMake(self.bannerScrollView.contentOffset.x + CGRectGetWidth(self.bannerScrollView.frame), 0);
    [self.bannerScrollView setContentOffset:offSet animated:YES];
}
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

/*初始化数组*/
- (void)initWithBanner:(NSArray *)imageArray
{
    self.imageArray = imageArray;
    self.pageControls.numberOfPages = imageArray.count;
    [self showCurrentImages];
    
}

- (void)showCurrentImages
{
    if (!self.imageArray.count>0) {
        return;
    }
    for (UIView *view in self.bannerScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            NSString *imagePath = [self getImgURLForView:imageView.tag];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:nil];
        }
    }
    [self.bannerScrollView setContentOffset:CGPointMake(self.bannerScrollView.frame.size.width, 0)];
}

- (NSString *)getImgURLForView:(NSInteger)tag
{
    NSInteger index = [self getNextPageIndexWithPageIndex:self.currentPage + (tag - 1)];
    return self.imageArray[index];
}

-(NSInteger)getNextPageIndexWithPageIndex:(NSInteger)currentIndex
{
    NSInteger index;
    if (currentIndex==-1) {
        index = self.imageArray.count-1;
    }else if (currentIndex==self.imageArray.count){
        index = 0;
    }else{
        index = currentIndex;
    }
    return index;
}

#pragma mark -- UIScrollView delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControls.currentPage = [self getNextPageIndexWithPageIndex:self.currentPage];
    
    if (scrollView.contentOffset.x>=2*CGRectGetWidth(scrollView.frame)) {
        self.currentPage = [self getNextPageIndexWithPageIndex:self.currentPage+1];
        [self showCurrentImages];
        
    }
    if (scrollView.contentOffset.x<=0)
    {
        self.currentPage = [self getNextPageIndexWithPageIndex:self.currentPage-1];
        [self showCurrentImages];
    }
    
}

- (void)dealloc
{
    [self removeTimer];
}
@end
