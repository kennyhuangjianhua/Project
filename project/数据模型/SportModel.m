//
//  SportModel.m
//  GetFit3.0
//
//  Created by zorro on 2017/7/21.
//  Copyright © 2017年 lxc. All rights reserved.
//

#import "SportModel.h"


// http://apidoc.sty028.com/#api-sportsleep-uploadGfUserSport
// PHP http://119.23.8.182:8081/doc/
// http://119.23.8.182:8082/appversion/index

@implementation SportModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _user_id = KK_User.user_id;
        _date = [[NSDate date] dateToDayString];
        _duration = @"0";
        _step = 0;
        _distance = 0;
        _calory = 0;
        NSMutableArray *stepArr = [NSMutableArray array];
        NSMutableArray *distanceArr = [NSMutableArray array];
        NSMutableArray *calArr = [NSMutableArray array];
        for (int i = 0; i < 48; i++) {
            [stepArr addObject:StrByInt(0)];
            [distanceArr addObject:StrByInt(0)];
            [calArr addObject:StrByInt(0)];
        }
        _stepArr = [NSArray arrayWithArray:stepArr];
        _distanceArr = [NSArray arrayWithArray:distanceArr];
        _calArr = [NSArray arrayWithArray:calArr];
    }
    
    return self;
}

+ (SportModel *)initWithDate:(NSDate *)date
{
    SportModel *model = [[SportModel alloc] init];
    model.date = [date dateToDayString];
    
    return model;
}

// 表名
+ (NSString *)getTableName
{
    return @"SportModel";
}

// 复合主键
+ (NSArray *)getPrimaryKeyUnionArray
{
    return @[@"user_id", @"date"];
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

+ (void)initialize
{
    [super initialize];
}


@end
