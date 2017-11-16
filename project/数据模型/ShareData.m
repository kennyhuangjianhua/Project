//
//  ShareData.m
//  MultiMedia
//
//  Created by zorro on 15/3/13.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "ShareData.h"
#import "XYSystemInfo.h"
#import "XYSandbox.h"
#import <AVFoundation/AVFoundation.h>

@implementation ShareData

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _isPad = NO;
        _isIp4s = NO;
        _isIp5 = NO;
        _isIp6 = NO;
        _isIp6P = NO;
        
    }
    
    return self;
}

- (void)checkDeviceModel
{
    if ([XYSystemInfo isDevicePad])
    {
        _isPad = YES;
    }
    else if ([XYSystemInfo isPhoneRetina35])
    {
        _isIp4s = YES;
    }
    else if ([XYSystemInfo isPhoneRetina4])
    {
        _isIp5 = YES;
    }
    else if ([XYSystemInfo isPhoneSix])
    {
        _isIp6 = YES;
    }
    else if ([XYSystemInfo isPhoneSixPlus])
    {
        _isIp6P = YES;
    }
    else
    {
        _isIp5 = YES;
    }
}

+ (BOOL)isPad
{
    return [ShareData sharedInstance].isPad;
}

+ (BOOL)isIpFour
{
    return [ShareData sharedInstance].isIp4s;
}

+ (BOOL)isIpFive
{
    return [ShareData sharedInstance].isIp5;
}

+ (BOOL)isIpSix
{
    return [ShareData sharedInstance].isIp6;
}

+ (BOOL)isIpSixP
{
    return [ShareData sharedInstance].isIp6P;
}


DEF_SINGLETON(ShareData)

// 对完整的文件路径进行判断,isDirectory 如果是文件夹返回YES, 如果不是返回NO.
- (BOOL)completePathDetermineIsThere:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:path];
    
    return existed;
}

// 删除文件夹和文件都可以用这个方法
- (void)removeFileName:(NSString *)file withFolderPath:(NSString *)path
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:filePath error:nil];
}


@end
