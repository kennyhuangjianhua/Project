//
//  ShareData.h
//  MultiMedia
//
//  Created by zorro on 15/3/13.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#define KK_PadDevice ([ShareData sharedInstance].isPad)
#define KK_IpFourDevice ([ShareData sharedInstance].isIp4s)
#define KK_IpFiveDevice ([ShareData sharedInstance].isIp5)
#define KK_IpSixDevice ([ShareData sharedInstance].isIp6)
#define KK_IpSixPDevice ([ShareData sharedInstance].isIp6P)

#define BL_CountScale (10000)
#define KK_ShareData ([ShareData sharedInstance])
#define kK_App ((AppDelegate *)[UIApplication sharedApplication].delegate)

typedef enum {
    ShareDataImageSourceDisConnect = 0,             // 未连接
    ShareDataImageSourceDidConnect = 1,             // 非未连接
    ShareDataImageSourceAdd,                        // 添加
} ShareDataImageType;

typedef enum {
    ServerDataTypeDetail = 0,
    ServerDataTypeDay = 1,
    ServerDataTypeWeek = 2,
    ServerDataTypeMonth = 3,
    ServerDataTypeYear = 4,

} ServerDataType;

typedef enum
{
    EXLSend = 0,
    EXLReceive = 1,
    
} EXLType;

#import <Foundation/Foundation.h>


@interface ShareData : NSObject

@property (nonatomic, assign) BOOL isPad;
@property (nonatomic, assign) BOOL isIp4s;
@property (nonatomic, assign) BOOL isIp5;
@property (nonatomic, assign) BOOL isIp6;
@property (nonatomic, assign) BOOL isIp6P;

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *recordPath;

@property (nonatomic, strong) NSString *language;


- (void)checkDeviceModel;

+ (BOOL)isPad;
+ (BOOL)isIpFour;
+ (BOOL)isIpFive;
+ (BOOL)isIpSix;
+ (BOOL)isIpSixP;

AS_SINGLETON(ShareData)

- (NSString *)getCurrentRecordFilePath:(NSString *)name;

// 对完整的文件路径进行判断,isDirectory 如果是文件夹返回YES, 如果不是返回NO.
- (BOOL)completePathDetermineIsThere:(NSString *)path;

// 删除文件夹和文件都可以用这个方法
- (void)removeFileName:(NSString *)file withFolderPath:(NSString *)path;
- (UIImage *)getImageFromFileCache:(NSString *)imageName;
- (UIImage *)getImageFromFileCache:(NSString *)imageName withType:(ShareDataImageType)type;

- (UIImage *)imageScale:(UIImage *)image
               withSize:(CGSize)size
              withScale:(CGFloat)scale;


@end
