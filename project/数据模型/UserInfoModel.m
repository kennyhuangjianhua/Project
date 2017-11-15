//
//  UserInfoModel.m
//  AJBracelet
//
//  Created by zorro on 15/7/6.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "UserInfoModel.h"
#import "UserInfoHelper.h"
#import "YYJSONHelper.h"
#import "RemindModel.h"
#import "CalendarModel.h"
#import "DrinkModel.h"
#import "PhysicalModel.h"
#import "SedentaryModel.h"

@implementation UserInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _birthday = @"2017-01-01";
        
        _interest = @"";
        _manifesto = @"";
        
        _gender = 1;
        _height = 175;
        _weight = 70;
        
        _target_step = 60 * 8;
        _target_sleep = 12000;
        
        _lanuage = 0;
        _isMetricSystem = NO;
        _is24Time = NO;
        
        _target_step = 10000;
        _target_sleep = 480;
        
        _heartMin = 50;
        _heartMax = 100;
        
        _bloxyMin = 50;
        _bloxyMax = 100;
        _physicalTime = 60;
        
        _portrait = @"";
        _lastMacAddress = @"";
        _lastBleUuid = [AJ_LastWareUUID getObjectValue];
        _autoCheckHeart = YES;
        _changeScreen = 0;
        _messageNoticeSwitch = 0;
        _hand = NO;
    }
    
    return self;
}

+ (UserInfoModel *)parseString:(NSString *)string
{
    UserInfoModel *user = [string toModel:[self class]];
    
    return user;
}

- (void)updateDataSafely
{
    NSString *where = [NSString stringWithFormat:@"user_id = '%@'", _user_id];
    UserInfoModel *model = [UserInfoModel searchSingleWithWhere:where orderBy:nil];
    
    if (!model) {
        model = [[UserInfoModel alloc] init];
        model.user_id = _user_id;
        [model saveToDB];
    } else {
        [UserInfoModel updateToDB:self where:nil];
    }
}

+ (UserInfoModel *)getUserInfoFromDB
{
    NSString *where = [NSString stringWithFormat:@"userName = '%@'", AJ_UserName];
    UserInfoModel *model = [UserInfoModel searchSingleWithWhere:where orderBy:nil];
    
    if (!model) {
        model = [[UserInfoModel alloc] init];
        [model saveToDB];
    }
    
    return model;
}

+ (UserInfoModel *)getUserInfoFromDBWithUserID:(NSString *)userID
{
    NSString *where = [NSString stringWithFormat:@"user_id = '%@'", userID];
    UserInfoModel *model = [UserInfoModel searchSingleWithWhere:where orderBy:nil];
    
    if (!model) {
        model = [[UserInfoModel alloc] init];
        model.user_id = userID;
        [model saveToDB];
    }
    
    [model setRemindWithUserID:userID];
    
    return model;
}

- (void)setRemindWithUserID:(NSString *)userID
{
    _alarmArray = [AlarmClockModel getAlarmClockFromDBWithUserID:userID];
    _calendarArray = [CalendarModel getCalendarClockFromDBWithUserID:userID];
    _drinkModel = [DrinkModel getDrinkModelFromDBWithUserID:userID];
    _physicalModel = [PhysicalModel getPhysicalModelFromDBWithUserID:userID];
    _sedentaryModel = [SedentaryModel getSedentaryModelFromDBWithUserID:userID];
}

+ (void)updateUserInfoWithLogin:(UserInfoModel *)user
{
    KK_User = [UserInfoModel getUserInfoFromDBWithUserID:user.user_id];
    KK_User.user_id = user.user_id;
    KK_User.email = user.email;
    KK_User.access_token = user.access_token;
    KK_User.is_first = user.is_first;
    
    [UserInfoModel updateToDB:KK_User where:nil];
}

+ (void)updateUserInfo:(UserInfoModel *)user
{
    KK_User.email = user.email;
    KK_User.nickname = user.nickname;
    KK_User.address = user.address;
    KK_User.sign = user.sign;
    KK_User.birthday = user.birthday;
    KK_User.job = user.job;
    KK_User.height = user.height;
    KK_User.weight = user.weight;
    KK_User.gender = user.gender;
    KK_User.portrait = user.portrait;
    KK_User.wallpaper = user.wallpaper;
    KK_User.target_step = user.target_step;
    KK_User.target_sleep = user.target_sleep;
    KK_User.max_step = user.max_step;
    KK_User.max_reach_times = user.max_reach_times;
    [UserInfoModel updateToDB:KK_User where:nil];
}

// 闹钟逻辑部分
- (BOOL)addAlarmClockType:(NSString *)string
{
    NSArray *typeArray = KK_UserHelper.alarmTypeArray;
    if ([typeArray containsObject:string]) {
        return NO;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:typeArray];
    [array addObject:string];
    
    KK_UserHelper.alarmTypeArray = array;
    
    return YES;
}

- (NSInteger)clockOpenNumber
{
    NSInteger number = 0;
    for (int i = 0; i < _alarmArray.count; i++) {
        AlarmClockModel *clock = _alarmArray[i];
        if (clock.isOpen) {
            number++;
        }
    }
    
    return number;
}

- (NSInteger)clockShowNumber
{
    NSInteger number = 0;
    for (int i = 0; i < _alarmArray.count; i++) {
        AlarmClockModel *clock = _alarmArray[i];
        if (clock.showHeight > 10) {
            number++;
        }
    }
    
    return number;
}

// 待添加闹钟
- (AlarmClockModel *)toAddAlarmClock
{
    AlarmClockModel *clock = nil;
    for (int i = 0; i < _alarmArray.count; i++) {
        AlarmClockModel *tmpClock = _alarmArray[i];
        if (tmpClock.showHeight < 10) {
            clock = tmpClock;
        }
    }
    
    return clock;
}

// 日常逻辑部分
- (NSInteger)calendarOpenNumber
{
    NSInteger number = 0;
    for (int i = 0; i < _calendarArray.count; i++) {
        CalendarModel *calendar = _calendarArray[i];
        if (calendar.isOpen) {
            number++;
        }
    }
    
    return number;
}

- (NSInteger)calendarShowNumber
{
    NSInteger number = 0;
    for (int i = 0; i < _calendarArray.count; i++) {
        CalendarModel *calendar = _calendarArray[i];
        if (calendar.showHeight > 10) {
            number++;
        }
    }
    
    return number;
}

// 待添加日程
- (CalendarModel *)toAddCalendar
{
    CalendarModel *calendar = nil;
    for (int i = 0; i < _calendarArray.count; i++) {
        CalendarModel *tmpCalendar = _calendarArray[i];
        if (tmpCalendar.showHeight < 10) {
            calendar = tmpCalendar;
        }
    }
    
    return calendar;
}

// 显示公制 1为公制 0 为英制
- (NSString *)showMetricSystem
{
    if (_isMetricSystem) {
        return @"1";
    } else {
        return @"0";
    }
}

// 1 24小时制度 0为12小时制度
- (NSString *)showAllDays
{
    if (_is24Time) {
        return @"1";
    } else {
        return @"0";
    }
}

// 计算年龄
- (NSString *)age
{
    NSDate *date = [NSDate dateByString:_birthday];
    NSDate *today = [NSDate date];
    NSInteger isFull = 0;
    if (today.month * 100 + today.day > date.month * 100 + date.day) {
        isFull = 1;
    }
    
    return StrByInt(today.year - date.year + isFull);
}

// 0中文 1英文
- (NSString *)showLanuage
{
    int type = 0;
    
    if (_lanuage == 0) {
        type = 0;
    } else {
        type = 1;
    }

    return [NSString stringWithFormat:@"%d",type];
}

- (NSString *)showGenderSex
{
    return  (_gender == 1) ? HHH_Text(@" Female ") : HHH_Text(@"  Male ");
}

- (NSString *)showAge
{
    return [NSString stringWithFormat:@"%d", _gender];
}

- (NSString *)showHeight
{
    if ([SAVEENTERUSERKEY getBOOLValue])
    {
        return [NSString stringWithFormat:@"%d", _height];
    } else {
        if (_gender) {
            return @"160";
        } else {
            return @"170";
        }
    }
}

- (NSString *)showWeight
{
    if ([SAVEENTERUSERKEY getBOOLValue]) {
        return [NSString stringWithFormat:@"%d", _weight];
    } else {
        if (_gender) {
            return @"50";
        } else {
            return @"70";
        }
    }
}

- (UIImage *)headImage
{
    return KK_UserHelper.localHeadImage;
}

- (NSString *)portrait
{
    return _portrait ? _portrait : @"";
}

- (NSString *)email
{
    return _email ? _email : @"";
}

// 将设置发送给设备
- (void)sendSettingToDevice:(BOOL)isPop
{
   
}

-(NSString*)currentlanguage
{
    NSString *languageValue = @"0";
    
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    NSLog(@"系统语言>>>%@",languageName);
    
    if ([languageName isEqualToString:@"zh-Hans-CN"])
    {
        languageValue = @"0";
    }
    else if ([languageName isEqualToString:@"en-CN"])
    {
        languageValue = @"1";
    }
    
    return languageValue;
}


- (void)uploadToServer
{
   
}

- (NSInteger)targetSteps
{
    NSInteger steps = 0;
    for (int i = 0; i < self.targetStepsArray.count; i++) {
        NSString *number = self.targetStepsArray[i];
        steps += number.integerValue;
    }
    
    return steps;
}

- (NSInteger)targetSleep
{
    NSInteger sleep = 0;
    for (int i = 0; i < self.targetSleepArray.count; i++) {
        NSString *sting = self.targetSleepArray[i];
        NSArray *array = [sting componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
        NSInteger number = StrToInt(array[0]) * 60 + StrToInt(array[1]) + StrToInt(array[2]) * 60 + StrToInt(array[3]);
        sleep += number;
    }
    
    return sleep;
}

- (NSArray *)targetStepsArray
{
    if (_targetStepsArray.count != 7) {
        _targetStepsArray = @[@"6000", @"6000", @"6000",
                              @"6000", @"6000", @"6000", @"6000"];
    }
    
    return _targetStepsArray;
}

- (NSArray *)targetSleepArray
{
    if (_targetSleepArray.count != 7) {
        _targetSleepArray = @[@"12:00-12:00", @"12:00-12:00", @"12:00-12:00",
                              @"12:00-12:00", @"12:00-12:00", @"12:00-12:00", @"12:00-12:00"];
    }
    
    return _targetSleepArray;
}

// 表名
+ (NSString *)getTableName
{
    return @"UserInfoModel";
}

// 主键
+ (NSString *)getPrimaryKey
{
    return @"user_id";
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

+ (void)initialize
{
    //remove unwant property
    //比如 getTableMapping 返回nil 的时候   会取全部属性  这时候 就可以 用这个方法  移除掉 不要的属性
    
    [super initialize];
    [self bindYYJSONKey:@"id" toProperty:@"user_id"];

    [self removePropertyWithColumnName:@"avatar"];
    [self removePropertyWithColumnName:@"headImage"];
    [self removePropertyWithColumnName:@"interest"];
    [self removePropertyWithColumnName:@"manifesto"];
    [self removePropertyWithColumnName:@"headImage"];

    [self removePropertyWithColumnName:@"showGenderSex"];
    [self removePropertyWithColumnName:@"showHeight"];
    [self removePropertyWithColumnName:@"showWeight"];
}

@end
