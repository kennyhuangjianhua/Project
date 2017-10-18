//
//  BLTModel.m
//  ProductionTest
//
//  Created by zorro on 15-1-16.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "BLTModel.h"

@implementation BLTModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _bltName = @"";
        _bltUUID = @"";
        _bltVersion = 0;
        _bltOnlineVersion = 0;
        _bltRSSI = @"";
        
        _isDialingRemind = YES;
        _delayDialing = 8; // 默认8秒.
        _macAddress = @"";
    }
    return self;
}

+ (void)initialize
{
    [self removePropertyWithColumnName:@"peripheral"];
    [self removePropertyWithColumnName:@"alarmArray"];
    [self removePropertyWithColumnName:@"remindArray"];
    [self removePropertyWithColumnName:@"bltRSSI"];
    [self removePropertyWithColumnName:@"bltVersion"];
    [self removePropertyWithColumnName:@"bltOnlineVersion"];
    [self removePropertyWithColumnName:@"bltElec"];
    [self removePropertyWithColumnName:@"isConnected"];
    [self removePropertyWithColumnName:@"isRepeatConnect"];
    [self removePropertyWithColumnName:@"isInitiative"];
}

+ (instancetype)initWithUUID:(NSString *)uuid
{
    BLTModel *model = [[BLTModel alloc] init];
    
    model.bltUUID = uuid;
    model.date = [NSDate date];
    return model;
}

+ (BLTModel *)getModelFromDBWtihUUID:(NSString *)uuid
{
    // 避免数据库的循环使用.
    [ShareData sharedInstance].isAllowBLTSave = NO;

    NSString *where = [NSString stringWithFormat:@"bltUUID = '%@'", uuid];
    BLTModel *model = [BLTModel searchSingleWithWhere:where orderBy:nil];

    if (!model) {
        model = [BLTModel initWithUUID:uuid];
        [model saveToDB];
    }
        
    [ShareData sharedInstance].isAllowBLTSave = YES;

    return model;
}

// 主建
+ (NSString *)getPrimaryKey
{
    return @"bltUUID";
}

// 表名
+ (NSString *)getTableName
{
    return @"BLTModel";
}

// 表版本
+ (int)getTableVersion
{
    return 1;
}

- (NSString *)imageForsignalStrength
{
    NSInteger rssi = [_bltRSSI integerValue];
    if (rssi <= 0 && rssi > -20) {
        return  @"signal_full.png";
    } else if (rssi <= -20 && rssi > -40) {
        return @"signal_level4.png";
    } else if (rssi <= -40 && rssi > -60) {
        return @"signal_level3.png";
    } else if (rssi <= -60 && rssi > -90) {
        return @"signal_level2.png";
    } else {
        return @"signal_level1.png";
    }
}

// 更新当前模型到数据库.
- (void)updateCurrentModelToDB
{
    if ([ShareData sharedInstance].isAllowBLTSave) {
        [BLTModel updateToDB:self where:nil];
    }
}

- (BOOL)isConnected
{
    if (_peripheral.state == CBPeripheralStateConnected) {
        return YES;
    }
    
    return NO;
}

- (void)setIsBinding:(BOOL)isBinding
{
    _isBinding = isBinding;
    
    [self updateCurrentModelToDB];
}

- (void)setIsDialingRemind:(BOOL)isDialingRemind
{
    _isDialingRemind = isDialingRemind;
    [self updateCurrentModelToDB];
}

- (void)setDelayDialing:(NSInteger)delayDialing
{
    _delayDialing = delayDialing;
    [self updateCurrentModelToDB];
}

- (NSString *)macAddress
{
    return _macAddress ? _macAddress : @"";
}

- (BLTModelDeviceType)devceType
{
    if ([_bltName isEqualToString:DEVICEX9])
    {
        return BLTModelDeviceX9;
    }
    else if ([_bltName isEqualToString:DEVICEI6])
    {
        return BLTModelDeviceI6;
    }
    else if ([_bltName isEqualToString:DEVICEIONE])
    {
        return BLTModelDeviceSOne;
    }
    
    return BLTModelDeviceX9;
}

@end
