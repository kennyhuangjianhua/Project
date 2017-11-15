//
//  UserInfoHelper.h
//  AJBracelet
//
//  Created by zorro on 15/7/6.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "AlarmClockModel.h"

#define AJ_HeadImage @"headImage.jpg"
#define KK_UserHelper ([UserInfoHelper sharedInstance])
#define KK_User ([UserInfoHelper sharedInstance].userModel)

@interface UserInfoHelper : NSObject

// 当前用户信息
@property (nonatomic, strong) UserInfoModel *userModel;

@property (nonatomic, assign) NSInteger alarmCount;              // 闹钟计数序号 0~9
@property (nonatomic, strong) NSMutableArray *array;             // 闹钟模型数组
@property (nonatomic, strong) NSMutableArray *sendAlaryArray;    //发送给手环的闹钟数据
@property (nonatomic, assign) NSInteger sendAlarmCountSuccecful; //闹钟设置成功

@property (nonatomic, assign) NSInteger scheduleCount;           //日程计数序号 0~4
@property (nonatomic, strong) NSMutableArray *scheduleArray;     //日程模型数组
@property (nonatomic, strong) NSMutableArray *sendScheduleArray; // 发送给手环的日程数组
@property (nonatomic, assign) NSInteger sendScheduleSucceful;    // 日程设置成功

@property(nonatomic, strong) NSString *UnitConversion;//单位换算 0:公制 1:英制
@property(nonatomic, strong) NSString *TimeFormat;//时间换算     0:24   1:12

@property(nonatomic, assign) NSInteger heartCheckIndex;         // 心率检测次数

@property (nonatomic, strong) NSArray *alarmTypeArray;
@property (nonatomic, strong) UIImage *localHeadImage;

@property (nonatomic, strong) NSString* showcurrentlanguage;

@property (nonatomic, assign) UInt8 MessageNotice;

AS_SINGLETON(UserInfoHelper)

// 移除用户头像
- (void)removeUserHeadImage;
// 缓存用户头像到本地.
- (void)saveHeadImageToFileCacheWithPicker:(UIImagePickerController *)picker
                                  withInfo:(NSDictionary *)info;

// 拍照模式
- (void)sendPhotoControl:(BOOL)type;

// 设置闹钟
- (void)startSetAlarmClock;
// 设置日程
- (void)startSetCalendar;

- (void)startDrinkWater;

- (void)startsedentary;

- (void)startphysical;

- (void)startUpdateUserInfo;

@end
