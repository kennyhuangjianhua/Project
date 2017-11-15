//
//  CalendarModel.m
//  GetFit3.0
//
//  Created by zorro on 2017/7/24.
//  Copyright © 2017年 lxc. All rights reserved.
//

#import "CalendarModel.h"
#import "UserInfoHelper.h"

@implementation CalendarModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self resetParameters];
    }
    
    return self;
}

// 闹钟信息初始化.
- (void)resetParameters
{
    _isOpen = NO;
    
    NSString *dateString = @"";
    NSString *s = [[NSDate date] dateToString];
    NSArray *array = [s componentsSeparatedByString:@" "];
    dateString = [array firstObject];

    _dateString = dateString;
    _hour = 8;
    _minutes = 0;
    _remindType = 0;
}

+ (NSArray *)getCalendarClockFromDBWithUserID:(NSString *)userID
{
    NSString *where = [NSString stringWithFormat:@"userId = '%@'", userID];
    NSArray *array = [CalendarModel searchWithWhere:where orderBy:nil offset:0 count:-1];
    
    if (!array || array.count == 0) {
        NSMutableArray *alarmArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 5; i++) {
            CalendarModel *model = [CalendarModel simpleInitWith:i withUserID:userID];
            [model saveToDB];
            [alarmArray addObject:model];
        }
        
        array = alarmArray;
    }

    return array;
}

+ (CalendarModel *)simpleInitWith:(NSInteger)index withUserID:(NSString *)userID
{
    CalendarModel *model = [[CalendarModel alloc] init];
    
    model.orderIndex = index;
    model.userId = userID;
    
    return model;
}

- (void)setShowHeight:(CGFloat)showHeight
{
    if (showHeight < 10) {
        [self resetParameters];
    }
    
    _showHeight = showHeight;
}

// 将设置发送给设备
- (void)sendSettingToDevice:(BOOL)isPop
{

}

- (NSString *)showTimeString
{
    if ([AlarmClockModel isHasAMPMTimeSystem]) {
        if (_hour <= 12) {
            return [NSString stringWithFormat:@"%@ %02ld:%02ld", (@"AM"), (long)_hour, (long)_minutes];
        } else {
            return [NSString stringWithFormat:@"%@ %02d:%02ld", (@"PM"), _hour - 12, (long)_minutes];
        }
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)_hour, (long)_minutes];
    }
}


- (NSString *)showCalendarType
{
    return KK_UserHelper.alarmTypeArray[_remindType];
}

+(void)initialize
{
    // 不加入会进入死循环
    [self removePropertyWithColumnName:@"showTimeString"];
    [self removePropertyWithColumnName:@"showCalendarType"];
}

// 表名
+ (NSString *)getTableName
{
    return @"CalendarModel";
}

// 复合主键
+ (NSArray *)getPrimaryKeyUnionArray
{
    return @[@"userId", @"orderIndex"];
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

@end
