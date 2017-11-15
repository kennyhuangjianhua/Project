//
//  AlarmClockModel.m
//  AJBracelet
//
//  Created by zorro on 15/7/2.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "AlarmClockModel.h"
#import "UserInfoHelper.h"

@implementation AlarmClockModel

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
    _repeat = 0;
    _hour = 8;
    _minutes = 0;
    _seconds = 0;
    _alarmType = 0;
    _weekArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
}

+ (NSArray *)getAlarmClockFromDBWithUserID:(NSString *)userID
{
    NSString *where = [NSString stringWithFormat:@"userId = '%@'", userID];
    NSArray *array = [AlarmClockModel searchWithWhere:where orderBy:nil offset:0 count:-1];
    
    if (!array || array.count == 0) {
        NSMutableArray *alarmArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 10; i++) {
            AlarmClockModel *model = [AlarmClockModel simpleInitWith:i withUserID:userID];
            
            [model saveToDB];
            [alarmArray addObject:model];
        }
        
        array = alarmArray;
    }
    
    return array;
}

+ (AlarmClockModel *)simpleInitWith:(NSInteger)index withUserID:(NSString *)uuid
{
    AlarmClockModel *model = [[AlarmClockModel alloc] init];
    
    model.orderIndex = index;
    // model.wareUUID = uuid;
    model.userId = uuid;

    return model;
}

- (NSArray *)sortByNumberWithArray:(NSArray *)array withSEC:(BOOL)sec
{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:array];
    [muArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
         NSString *string1 = (NSString *)obj1;
         NSString *string2 = (NSString *)obj2;
         
         if (([string1 integerValue] > [string2 integerValue]) == sec) {
             return NSOrderedAscending;
         } else {
             return NSOrderedDescending;
         }
     }];
    
    return muArray;
}

- (NSString *)showStringForWeekDay
{
    NSArray *weekArray = [self sortByNumberWithArray:_weekArray withSEC:NO];
    NSDictionary *dict = @{@"7" : HHH_Text(@"  SUN "), @"1" : HHH_Text(@" MON  "), @"2" : HHH_Text(@" TUE  "),
                           @"3" : HHH_Text(@" WED  "), @"4" : HHH_Text(@" THU  "),
                           @"5" : HHH_Text(@"  FRI "), @"6" : HHH_Text(@" SAT  ")};
    
    NSString *weekString = @""; //weekArray.count > 0 ? LS_Text(@"sign-week") : @"";
    
    if (weekArray.count == 7) {
        weekString = HHH_Text(@"Every Days");
    } else {
        for (int i = 0; i < weekArray.count; i++) {
            NSString *day = weekArray[i];
            NSString *string = [dict objectForKey:day];
            
            if (i != _weekArray.count - 1) {
                weekString = [NSString stringWithFormat:@"%@%@ ", weekString, string];
            } else {
                weekString = [NSString stringWithFormat:@"%@%@", weekString, string];
            }
        }
    }
    
    return weekString;
}

- (void)convertToBLTNeed
{
    UInt8 val = 0;
    
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    // NSArray *array = @[@"7", @"2", @"3", @"4", @"5", @"6", @"1"];

    for (int i = 0; i < array.count; i++) {
        NSString *str = array[0];
        if ([_weekArray containsObject:str]) {
            val = val | (1 << i);
        } else {
            val = val | (0 << i);
        }
    }
    
    _repeat = val;
}

- (UInt8)repeat
{
    UInt8 val = 0;
    NSArray *array = @[@"7", @"1", @"2", @"3", @"4", @"5", @"6"];
    
    for (int i = 0; i < array.count; i++)
    {
        NSString *str = array[0];
        if ([_weekArray containsObject:str])
        {
            val = val | (1 << i);
        } else {
            val = val | (0 << i);
        }
    }
    
    _repeat = val | (_isOpen << 0);
    
    return _repeat;
}

// 将设置发送给设备
- (void)sendSettingToDevice:(BOOL)isPop
{

}

- (UIImage *)showIconImage
{
    if (_alarmType == 0) {
        return UIImageNamedNoCache(@"device_alarm_sport_5@2x.png");
    } else if (_alarmType == 1) {
        return UIImageNamedNoCache(@"device_alarm_pill_5@2x.png");
    } else if (_alarmType == 2) {
        return UIImageNamedNoCache(@"device_alarm_wakeup_5@2x.png");
    } else if (_alarmType == 3) {
        return UIImageNamedNoCache(@"device_alarm_sleep_5@2x.png");
    } else if (_alarmType == 4) {
        return UIImageNamedNoCache(@"device_alarm_dating_5@2x.png");
    } else if (_alarmType == 5) {
        return UIImageNamedNoCache(@"device_alarm_together_5@2x.png");
    } else if (_alarmType == 6) {
        return UIImageNamedNoCache(@"device_alarm_meeting_5@2x.png");
    } else {
        return UIImageNamedNoCache(@"device_alarm_customize_5@2x.png");
    }
}

// 数据库存储
- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    self.isChanged = YES;
}

- (void)setWeekArray:(NSArray *)weekArray
{
    _weekArray = weekArray;
    self.isChanged = YES;
}

- (void)setAlarmType:(NSInteger )alarmType
{
    _alarmType = alarmType;
    self.isChanged = YES;
}

/*
- (void)setRepeat:(UInt8)repeat
{
    _repeat = repeat;
    self.isChanged = YES;
}
 */

- (void)setHour:(NSInteger)hour
{
    _hour = hour;
    self.isChanged = YES;
}

- (void)setMinutes:(NSInteger)minutes
{
    _minutes = minutes;
    self.isChanged = YES;
}

- (void)setShowHeight:(CGFloat)showHeight
{
    _showHeight = showHeight;
    
    if (_showHeight < 20.0)
    {
        [self resetParameters];
    }
    
    self.isChanged = YES;
}

- (void)setNoteString:(NSString *)noteString
{
    _noteString = noteString;
    self.isChanged = YES;
}

- (void)setIsChanged:(BOOL)isChanged
{
    _isChanged = isChanged;
    
    /*
    if ([ShareData sharedInstance].isAllowBLTSave)
    {
        NSString *where = [NSString stringWithFormat:@"wareUUID = '%@' AND orderIndex = %ld", _wareUUID, (long)_orderIndex];
        [AlarmClockModel updateToDB:self where:where];
    } */
}

- (NSString *)showTimeString
{
    if ([AlarmClockModel isHasAMPMTimeSystem])
    {
        if (_hour <= 12)
        {
            return [NSString stringWithFormat:@"%@ %02ld:%02ld", (@"AM"), (long)_hour, (long)_minutes];
        }
        else
        {
            return [NSString stringWithFormat:@"%@ %02d:%02ld", (@"PM"), _hour - 12, (long)_minutes];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)_hour, (long)_minutes];
    }
}

- (NSArray *)alarmTypeArray
{
    return KK_UserHelper.alarmTypeArray;
}

- (NSString *)showAlarmType
{
    return KK_UserHelper.alarmTypeArray[_alarmType];
}

/*
- (NSString *)noteString
{
    return [NSString stringWithFormat:@"我的%@提醒", _alarmType];
}
 */

// 表名
+ (NSString *)getTableName
{
    return @"AlarmClockModel";
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

+(void)initialize
{
    [self removePropertyWithColumnName:@"alarmTypeArray"];
    [self removePropertyWithColumnName:@"showTimeString"];
    [self removePropertyWithColumnName:@"showAlarmType"];
}

@end
