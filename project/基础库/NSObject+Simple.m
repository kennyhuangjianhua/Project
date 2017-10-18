//
//  NSObject+Simple.m
//  AJBracelet
//
//  Created by zorro on 15/5/27.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "NSObject+Simple.h"
#import <objc/runtime.h>

bool FisEqual(double num1, double num2)
{
    if (fabs(num1 - num2) > 0.000000001) {
        return NO;
    }
    
    return YES;
}

// 改变一个byte里面某个bit的值.
UInt8 bitInsertInt(UInt8 val, int position, bool value)
{
    if (value) {
        UInt8 tmp = (value << position);
        val = val | tmp;
    } else {
        UInt8 tmp = ~(!value << position);
        val = val & tmp;
    }
    
    return val;
}

// 从某个int里面取出position位置bit的值.
bool intConvertBit(int val, int position)
{
    val = val >> position;
    return val % 2;
}

@implementation NSObject (Simple)

@dynamic attributeList;

- (NSArray *)attributeList
{
    NSUInteger propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], (unsigned int *)&propertyCount);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < propertyCount; i++)
    {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        // const char *attr = property_getAttributes(properties[i]);
        // NSLogD(@"%@, %s", propertyName, attr);
        [array addObject:propertyName];
    }
    
    free( properties );
    return array;
}

+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

+ (BOOL)isHasAMPMTimeSystem
{
    // 获取系统是24小时制或者12小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = (containsA.location != NSNotFound);
    
    // hasAMPM == TURE为12小时制，否则为24小时制
    
    return hasAMPM;
}

+ (UIViewController *)topMostController
{
    //Getting rootViewController
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //Getting topMost ViewController
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    //Returning topMost ViewController
    return topController;
}

- (void)delayPerformBlock:(NSObjectSimpleBlock)block WithTime:(CGFloat)time
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
        
        if (block)
        {
            block(nil);
        }
        
    });
}

// 对完整的文件路径进行判断,isDirectory 如果是文件夹返回YES, 如果不是返回NO.
- (BOOL)completePathDetermineIsThere:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:path];
    
    return existed;
}

// 获取当前系统语言
- (NSString *)getCurrentLanguage
{
   return  (NSString *)[[NSLocale preferredLanguages] objectAtIndex:0];
}


+ (NSString *)KKLocalizedString:(NSString *)translation_key
{
    NSString *KK_Language = [self getCurrentLanguage];
    NSString *s = NSLocalizedString(translation_key, nil);
    // NSString * s = NSLocalizedStringFromTable(@"trainTitle",@"文件名",@"");
    NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    
    if ([KK_Language isEqualToString:@"zh-Hans-CN"] ||
        [KK_Language isEqualToString:@"zh-Hans"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    } else if ([KK_Language isEqualToString:@"zh-Hant-CN"] ||
               [KK_Language isEqualToString:@"zh-HK"] ||
               [KK_Language isEqualToString:@"zh-Hant"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"zh-Hant" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"ja"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"ja" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"de"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"de" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"fr"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"ko"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"ko" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"ru"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"ru" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"pt"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"pt-PT" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"es"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"es" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"it"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"it" ofType:@"lproj"];
    } else if ([KK_Language hasPrefix:@"uk"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"uk" ofType:@"lproj"];
    }
    else if ([KK_Language hasPrefix:@"pl"]) {
        
        path = [[NSBundle mainBundle] pathForResource:@"pl" ofType:@"lproj"];
    }
    
    NSBundle *languageBundle = [NSBundle bundleWithPath:path];
    s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    
    return s;
}

- (BOOL)testTimeIsOver:(NSString *)dateString
{
    NSDate *date = [NSDate dateByStringFormat:dateString];
    NSInteger dateTime = [[NSDate date] dateByDistanceDaysWithDate:date];
    
    if (dateTime <= 0)
    {
        // SHOWMBProgressHUD(@"测试时间已经结束", @"如有疑问请联系开发者", nil, NO, 3600 * 24);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试时间已经结束" message:@"如有疑问请联系供应商" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
