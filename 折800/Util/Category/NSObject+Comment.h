//
//  NSObject+Comment.h
//  折800
//
//  Created by renyufei on 15/8/31.
//  Copyright © 2015年 任玉飞. All rights reserved.
//

#define OMDateFormat @"yyyy-MM-dd'T'HH:mm:ss.SSS"
#define OMTimeZone @"UTC"

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Comment)

// Universal Method
-(NSDictionary *)propertyDictionary;
-(NSString *)nameOfClass;

// id -> Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict;
+(NSMutableArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *)obj;

//Object -> Data
-(NSDictionary *)objectDictionary;
-(NSData *)JSONData;
-(NSString *)JSONString;

// XML-SOAP
-(NSData *)XMLData;
-(NSString *)XMLString;
-(NSData *)SOAPData;
-(NSString *)SOAPString;
+(id)objectOfClass:(NSString *)object fromXML:(NSString *)xml;


// For mapping an array to properties
-(NSMutableDictionary *)getpropertyArrayMap;


// Copying an NSObject to new memory ref
// (basically initWithObject)
//-(id)initWithObject:(NSObject *)oldObject error:(NSError **)error;

// Base64 Encode/Decode
+(NSString *)encodeBase64WithData:(NSData *)objData;
+(NSData *)base64DataFromString:(NSString *)string;

#pragma mark NetError
-(id)handleResponse:(id)responseJSON;

@end

@interface SOAPObject : NSObject
@property (nonatomic, retain) id Header;
@property (nonatomic, retain) id Body;
@end
