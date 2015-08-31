//
//  NSURL+Comment.h
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright © 2015年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Comment)

+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
- (NSDictionary *)queryParams;
@end
