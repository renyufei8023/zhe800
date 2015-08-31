//
//  EaseStartView.m
//  Coding_iOS
//
//  Created by Ease on 14/12/26.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "EaseStartView.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import "StartImageManger.h"
#import "UIView+RYF.h"

@interface EaseStartView ()
@property (strong, nonatomic) UIImageView *bgImageView, *logoIconView;
@property (strong, nonatomic) UILabel *descriptionStrLabel;
@end

@implementation EaseStartView

+ (instancetype)startView{
    StartImage *st = [[StartImagesManager shareManager] randomImage];
    return [[self alloc] initWithBgImage:st.image descriptionStr:st.descriptionStr];
}

- (instancetype)initWithBgImage:(UIImage *)bgImage descriptionStr:(NSString *)descriptionStr{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        //add custom code
        UIColor *blackColor = [UIColor blackColor];
        self.backgroundColor = blackColor;
        
        _bgImageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.alpha = 0.0;
        [self addSubview:_bgImageView];
        
        [self addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.4].CGColor, (id)[blackColor colorWithAlphaComponent:0.0].CGColor] locations:nil startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 0.4)];

        _logoIconView = [[UIImageView alloc] init];
        _logoIconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoIconView];
        _descriptionStrLabel = [[UILabel alloc] init];
        _descriptionStrLabel.font = [UIFont systemFontOfSize:10];
        _descriptionStrLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _descriptionStrLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionStrLabel.alpha = 0.0;
        [self addSubview:_descriptionStrLabel];
        
        [_descriptionStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[self, _logoIconView]);
            make.height.mas_equalTo(10);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
        }];
        
        [self configWithBgImage:bgImage descriptionStr:descriptionStr];
    }
    return self;
}

- (void)configWithBgImage:(UIImage *)bgImage descriptionStr:(NSString *)descriptionStr{
    bgImage = [bgImage scaleToSize:_bgImageView.frame.size usingMode:NYXResizeModeAspectFill];
    self.bgImageView.image = bgImage;
    self.descriptionStrLabel.text = descriptionStr;
    [self updateConstraintsIfNeeded];
}

- (void)startAnimationWithCompletionBlock:(void(^)(EaseStartView *easeStartView))completionHandler{
    [KeyWindow addSubview:self];
    [KeyWindow bringSubviewToFront:self];
    _bgImageView.alpha = 0.0;
    _descriptionStrLabel.alpha = 0.0;

    @weakify(self);
    [UIView animateWithDuration:2.0 animations:^{
        @strongify(self);
        self.bgImageView.alpha = 1.0;
        self.descriptionStrLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            @strongify(self);
            [self setX:-ScreenWidth];
        } completion:^(BOOL finished) {
            @strongify(self);
            [self removeFromSuperview];
            if (completionHandler) {
                completionHandler(self);
            }
        }];
    }];
}

@end
