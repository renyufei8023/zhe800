//
//  StartImageManger.h
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright © 2015年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class StartImage;
@class Group;

@interface StartImagesManager : NSObject
+ (instancetype)shareManager;

- (StartImage *)randomImage;
- (StartImage *)curImage;

- (void)refreshImagesPlist;
- (void)startDownloadImages;

@end

@interface StartImage : NSObject
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) Group *group;
@property (strong, nonatomic) NSString *fileName, *descriptionStr, *pathDisk;

+ (StartImage *)defautImage;
- (UIImage *)image;
- (void)startDownloadImage;
@end

@interface Group : NSObject
@property (strong, nonatomic) NSString *name, *author;
@end