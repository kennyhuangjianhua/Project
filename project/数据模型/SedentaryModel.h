//
//  SedentaryModel.h
//  GetFit3.0
//
//  Created by zorro on 2017/7/26.
//  Copyright © 2017年 lxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SedentaryModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *wareUUID;

@property (nonatomic, assign) BOOL isOpen;              // 开关 1 开，0 关
@property (nonatomic, assign) UInt8 repeat;             // 开关 1 开，0 关
@property (nonatomic, assign) NSInteger interval;       // 间隔
@property (nonatomic, assign) NSInteger sleepTime;     // 睡眠时间

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

@property (nonatomic, strong) NSString *showTime1;
@property (nonatomic, strong) NSString *showTime2;
@property (nonatomic, strong) NSString *showTime3;

@property (nonatomic, strong) NSArray *weekArray;       // 选中的星期 数字 0 - 6.

+ (SedentaryModel *)simpleInitWithUserID:(NSString *)userID;
+ (SedentaryModel *)getSedentaryModelFromDBWithUserID:(NSString *)userID;
- (NSString *)showStringForWeekDay;
- (void)sendSettingToDevice:(BOOL)isPop;
- (NSArray *)showPopTime:(NSInteger)index;
- (void)updateTime:(NSArray *)array index:(NSInteger)index;

@end
