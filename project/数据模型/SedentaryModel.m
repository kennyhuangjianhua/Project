//
//  SedentaryModel.m
//  GetFit3.0
//
//  Created by zorro on 2017/7/26.
//  Copyright © 2017年 lxc. All rights reserved.
//

#import "SedentaryModel.h"

@implementation SedentaryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _startHour1 = 12;
        _endHour1 = 12;
        
        _startHour2 = 12;
        _endHour2 = 12;
        
        _startHour3 = 12;
        _endHour3 = 12;
        
        _sleepTime = 30;
        _interval = 30;
        
        _weekArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    return self;
}

+ (SedentaryModel *)getSedentaryModelFromDBWithUserID:(NSString *)userID
{
    NSString *where = [NSString stringWithFormat:@"userId = '%@'", userID];
    SedentaryModel *model = [SedentaryModel searchSingleWithWhere:where orderBy:nil];
    if (!model) {
        model = [SedentaryModel simpleInitWithUserID:userID];
        [model saveToDB];
    }
    
    return model;
}

+ (SedentaryModel *)simpleInitWithUserID:(NSString *)userID
{
    SedentaryModel *model = [[SedentaryModel alloc] init];
    model.userId = userID;
    
    return model;
}

- (NSArray *)sortByNumberWithArray:(NSArray *)array withSEC:(BOOL)sec
{
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:array];
    
    [muArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
     {
         NSString *string1 = (NSString *)obj1;
         NSString *string2 = (NSString *)obj2;
         
         if (([string1 integerValue] > [string2 integerValue]) == sec)
         {
             return NSOrderedAscending;
         }
         else
         {
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
    
    if (weekArray.count == 7)
    {
        weekString = HHH_Text(@"Every Days");
    }
    else
    {
        for (int i = 0; i < weekArray.count; i++)
        {
            NSString *day = weekArray[i];
            NSString *string = [dict objectForKey:day];
            
            if (i != _weekArray.count - 1)
            {
                weekString = [NSString stringWithFormat:@"%@%@ ", weekString, string];
            }
            else
            {
                weekString = [NSString stringWithFormat:@"%@%@", weekString, string];
            }
        }
    }
    
    return weekString;
}

- (UInt8)repeat
{
    UInt8 val = 0;
    for (int i = 1; i < 8; i++)
    {
        if ( _weekArray && [_weekArray containsObject:[NSString stringWithFormat:@"%d", i]])
        {
            val = val | (1 << i);
        }
        else
        {
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

- (NSString *)showTime1
{
    return [NSString stringWithFormat:@"%02d:%02d--%02d:%02d", _startHour1, _startMin1, _endHour1, _endMin1];
}

- (NSString *)showTime2
{
    return [NSString stringWithFormat:@"%02d:%02d--%02d:%02d", _startHour2, _startMin2, _endHour2, _endMin2];
}

- (NSString *)showTime3
{
    return [NSString stringWithFormat:@"%02d:%02d--%02d:%02d", _startHour3, _startMin3, _endHour3, _endMin3];
}

- (NSArray *)showPopTime:(NSInteger)index
{
    if (index == 0) {
        return @[StrByInt(_startHour1), StrByInt(_startMin1), StrByInt(_endHour1), StrByInt(_endMin1)];
    } else if (index == 1) {
        return @[StrByInt(_startHour2), StrByInt(_startMin2), StrByInt(_endHour2), StrByInt(_endMin2)];
    } else {
        return @[StrByInt(_startHour3), StrByInt(_startMin3), StrByInt(_endHour3), StrByInt(_endMin3)];
    }
}

- (void)updateTime:(NSArray *)array index:(NSInteger)index
{
    if (index == 0) {
        _startHour1 = ((NSString *)array[0]).integerValue;
        _startMin1 = ((NSString *)array[1]).integerValue;
        _endHour1 = ((NSString *)array[2]).integerValue;
        _endMin1 = ((NSString *)array[3]).integerValue;
    } else if (index == 1) {
        _startHour2 = ((NSString *)array[0]).integerValue;
        _startMin2 = ((NSString *)array[1]).integerValue;
        _endHour2 = ((NSString *)array[2]).integerValue;
        _endMin2 = ((NSString *)array[3]).integerValue;
    } else if (index == 2) {
        _startHour3 = ((NSString *)array[0]).integerValue;
        _startMin3 = ((NSString *)array[1]).integerValue;
        _endHour3 = ((NSString *)array[2]).integerValue;
        _endMin3 = ((NSString *)array[3]).integerValue;
    }
}

// 表名
+ (NSString *)getTableName
{
    return @"SedentaryModel";
}

// 复合主键
+ (NSArray *)getPrimaryKeyUnionArray
{
    return @[@"userId"];
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

@end
