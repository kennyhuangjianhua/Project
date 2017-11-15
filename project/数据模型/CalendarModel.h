//
//  CalendarModel.h
//  GetFit3.0
//
//  Created by zorro on 2017/7/24.
//  Copyright © 2017年 lxc. All rights reserved.
//  日程提醒表

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *wareUUID;

@property (nonatomic, strong) NSString *activeType;         //活动标签
@property (nonatomic, assign) BOOL isOpen;                  // 开关 1 开，0 关
@property (nonatomic, assign) NSInteger orderIndex;

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, assign) NSInteger remindType;         // 提醒类型
@property (nonatomic, assign) CGFloat showHeight;           // cell显示的高度. 0 的时候为删除. 其他的为存在.

// 提醒时间.
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minutes;

@property (nonatomic, strong) NSString *showTimeString;     // 显示时间字符串
@property (nonatomic, strong) NSString *showCalendarType;   // 标签显示

+ (NSArray *)getCalendarClockFromDBWithUserID:(NSString *)userID;
+ (CalendarModel *)simpleInitWith:(NSInteger)index withUserID:(NSString *)userID;
// 将设置发送给设备
- (void)sendSettingToDevice:(BOOL)isPop;

@end
