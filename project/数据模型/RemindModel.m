//
//  RemindModel.m
//  AJBracelet
//
//  Created by zorro on 15/7/2.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _isOpen = NO;
        _interval = 45;
        
        _weekArray = @[@"1", @"2", @"3", @"4", @"5"];
    }
    
    return self;
}

+ (RemindModel *)getDrinkModelFromDBWithUserID:(NSString *)userID
{
    NSString *where = [NSString stringWithFormat:@"userId = '%@'", userID];
    RemindModel *model = [RemindModel searchSingleWithWhere:where orderBy:nil];
    if (!model) {
        model = [RemindModel simpleInitWithUserID:userID];
        [model saveToDB];
    }
    
    return model;
}

+ (RemindModel *)simpleInitWithUserID:(NSString *)userID
{
    RemindModel *model = [[RemindModel alloc] init];
    model.userId = userID;
    
    return model;
}

// 数据库存储.
- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    self.isChanged = YES;
}

- (void)setInterval:(NSInteger)interval
{
    _interval = interval;
    self.isChanged = YES;
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

- (void)setIsChanged:(BOOL)isChanged
{
    _isChanged = isChanged;
}

// 表名
+ (NSString *)getTableName
{
    return @"RemindModel";
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
