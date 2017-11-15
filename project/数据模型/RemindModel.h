//
//  RemindModel.h
//  AJBracelet
//
//  Created by zorro on 15/7/2.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *wareUUID;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger interval;       // 久坐提醒时间间隔.
@property (nonatomic, assign) NSInteger startHour1;
@property (nonatomic, assign) NSInteger startMin1;
@property (nonatomic, assign) NSInteger endHour1;
@property (nonatomic, assign) NSInteger endMin1;

@property (nonatomic, assign) NSInteger startHour2;
@property (nonatomic, assign) NSInteger startMin2;
@property (nonatomic, assign) NSInteger endHour2;
@property (nonatomic, assign) NSInteger endMin2;

@property (nonatomic, assign) NSInteger startHour3;
@property (nonatomic, assign) NSInteger startMin3;
@property (nonatomic, assign) NSInteger endHour3;
@property (nonatomic, assign) NSInteger endMin3;

@property (nonatomic, strong) NSArray *weekArray;       // 选中的星期.
@property (nonatomic, assign) UInt8 repeat;

@property (nonatomic, assign) BOOL isChanged;           // 用户是否进行了新的设置.

@property (nonatomic, assign) NSInteger orderIndex;

@property (nonatomic, strong) NSString *showStartTimeString;
@property (nonatomic, strong) NSString *showEndTimeString;

@property (nonatomic, strong) NSString *showTime1;
@property (nonatomic, strong) NSString *showTime2;
@property (nonatomic, strong) NSString *showTime3;

// 根据设备uuid获取久坐提醒设置.
+ (RemindModel *)simpleInitWithUserID:(NSString *)userID;
+ (RemindModel *)getRemindModelFromDBWithUserID:(NSString *)userID;

@end
