//
//  NSObject+Simple.h
//  AJBracelet
//
//  Created by zorro on 15/5/27.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NSObjectSimpleBlock)(id object);

CGFloat stepConvertDistance(NSInteger step);
CGFloat stepConvertCal(NSInteger step);

bool FisEqual(double num1, double num2);

// 改变一个byte里面某个bit的值.
UInt8 bitInsertInt(UInt8 val, int position, bool value);
// 从某个int里面取出position位置bit的值.
bool intConvertBit(int val, int position);

@interface NSObject (Simple)

// 属性列表.
@property (nonatomic, readonly) NSArray *attributeList;

// 获取系统时制信息.
+ (BOOL)isHasAMPMTimeSystem;

// 获取根视图.
+ (UIViewController *)topMostController;

// 获取字符串的宽度
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;
// 获取字符串的高度
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

// 延迟调用.
- (void)delayPerformBlock:(NSObjectSimpleBlock)block WithTime:(CGFloat)time;

// 判断文件是否存在.
- (BOOL)completePathDetermineIsThere:(NSString *)path;

- (BOOL)testTimeIsOver:(NSString *)dateString;

+ (NSString *)KKLocalizedString:(NSString *)translation_key;

// 获取当前系统语言
- (NSString *)getCurrentLanguage;

@end
