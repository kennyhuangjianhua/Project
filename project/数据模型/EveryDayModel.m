//
//  EveryDayModel.m
//  project
//
//  Created by 黄建华 on 2017/9/26.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "EveryDayModel.h"
#define HHHEveryDayModel @"HHHEveryDayModel"
@implementation EveryDayModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    
    return self;
}

+ (EveryDayModel *)simpleInitWithDate:(NSDate *)date
{
    EveryDayModel *model = [[EveryDayModel alloc] init];
    
    model.dateString = [[date dateToString] componentsSeparatedByString:@" "][0];
    model.step = @"0";
    
    return model;
}

// 表名
+ (NSString *)getTableName
{
    return @"EveryDayModelTable";
}

//// 复合主键
//+ (NSArray *)getPrimaryKeyUnionArray
//{
//    return @[@"userName", @"dateString", @"wareUUID"];
//}

// 主键
+ (NSString *)getPrimaryKey
{
    return @"dateString";
}

@end
