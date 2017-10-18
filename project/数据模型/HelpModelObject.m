//
//  HelpModelObject.m
//  project
//
//  Created by 黄建华 on 2017/9/26.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "HelpModelObject.h"

@implementation HelpModelObject

DEF_SINGLETON(HelpModelObject)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
   
    }
    
    return self;
}

// 取出今天的数据模型
+ (EveryDayModel *)getModelFromDBWithToday
{
    EveryDayModel *model = [HelpModelObject getModelFromDBWithDate:[NSDate date]];
    
    if (model)
    {
        return model;
    }
    else
    {
        model = [[EveryDayModel alloc] init];
        
        return model;
    }
}

// 根据日期取出模型。
+ (EveryDayModel *)getModelFromDBWithDate:(NSDate *)date
{
    NSString *dateString = [date dateToString];
    NSString *where = [NSString stringWithFormat:@"dateString = '%@'",
                       [dateString componentsSeparatedByString:@" "][0]];
    EveryDayModel *model = [EveryDayModel searchSingleWithWhere:where orderBy:nil];
    
    if (!model)
    {
        // 没有就进行完全创建.
        model = [HelpModelObject pedometerSaveEmptyModelToDBWithDate:date isSaveAllDay:NO];
    }
    
    return model;
}

// 保存空模型到数据库.
+ (EveryDayModel *)pedometerSaveEmptyModelToDBWithDate:(NSDate *)date isSaveAllDay:(BOOL)save
{
    EveryDayModel *model = [EveryDayModel simpleInitWithDate:date];
    
    [HelpModelObject creatEmptyDataArrayWithModel:model];
    
    if (![date compareWithDate:[NSDate date]] &&
        [date timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970])
    {
        // NSLog(@"model.isSaveAllDay = ..%@", date);
        if (save)
        {
            model.isSaveAllDay = YES;
        }
    }
    
    [model saveToDB];
    
    return model;
}

// 为模型创建空值的对象
+ (void)creatEmptyDataArrayWithModel:(EveryDayModel *)model
{
   
}



@end
