//
//  BLTModel.h
//  ProductionTest
//
//  Created by zorro on 15-1-16.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define DEVICEX9 @"X9"
#define DEVICEI6 @"i6"
#define DEVICEIONE @"SOne"

typedef enum {
    BLTModelDisConnect = 0,             // 未连接
    BLTModelDidConnect = 1,             // 已连接
    BLTModelConnecting,                 // 连接中
    BLTModelRepeatConnecting,           // 重连中
    BLTModelConnectFindDevice,          // 寻找设备
    BLTModelConnectAlarming,            // 连接报警, 设备寻找手机
    BLTModelDistanceAlarming,           // 距离报警
    BLTModelDisConnectAlarming,         // 丢失报警
    BLTModelConnectFail                 // 连接失败
} BLTModelConnectState;

typedef enum {
    BLTModelAlertTypeBuzzing = 0,       // 蜂鸣
    BLTModelAlertTypeLEDLight = 1,      // LED灯
    BLTModelAlertTypeALL,               // 蜂鸣和灯
} BLTModelAlertType;

typedef enum {
    BLTModelLostDistancenNear = 0,          // 近
    BLTModelLostDistanceMiddle = 1,         // 中
    BLTModelLostDistanceFar = 2,            // 远
} BLTModelLostDistance;

typedef enum {
    BLTModelAlarmTypeFindMe = 0,            // 寻找
    BLTModelAlarmTypeAntiLost = 1,          // 防丢
} BLTModelAlarmType;

typedef enum {
    BLTModelDeviceX9 = 0,                   // X9
    BLTModelDeviceI6 = 1,                   // I6
    BLTModelDeviceSOne = 2,                 // ione
} BLTModelDeviceType;

@interface BLTModel : NSObject

// 蓝牙硬件所涉及的数据
@property (nonatomic, strong) NSString *bltName;                    // 设备名字
@property (nonatomic, strong) NSString *bltNickName;              // 设备昵称
@property (nonatomic, strong) NSString *bltUUID;                      // 设备UUID

@property (nonatomic, strong) NSString *bltRSSI;                    // RSSI
@property (nonatomic, assign) NSInteger bltVersion;                 // 固件版本
@property (nonatomic, assign) NSInteger bltOnlineVersion;           // 固件在线版本

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, assign) BOOL isConnected;                     // 是否连接中
@property (nonatomic, assign) NSInteger deviceID;                   // 设备ID，硬件版本
@property (nonatomic, assign) NSInteger runMode;                    // 运行模式 0为运动 1为睡眠
@property (nonatomic, assign) NSInteger batteryStatus;              // 电池状态 0为正常 1为正在充电 2为低电量.
@property (nonatomic, assign) NSInteger batteryQuantity;            // 电池电量

@property (nonatomic, assign) BLTModelDeviceType devceType;            // 设备类型

@property (nonatomic, assign) BOOL isDialingRemind;                 // 是否允许来电提醒
@property (nonatomic, assign) NSInteger delayDialing;               // 延迟多少秒来电提醒
@property (nonatomic, strong) NSString *macAddress;                 // 手环的MAC地址

@property (nonatomic, assign) BOOL isInitiative;                    // 是否主动断开的.
@property (nonatomic, assign) BOOL isBinding;                       // 是否绑定了
@property (nonatomic, assign) BOOL isRepeatConnect;                 // 是否重链接
@property (nonatomic, assign) BOOL isUpdateMode;                    // 是否是升级模式
@property (nonatomic, strong) NSArray *alarmArray;                  // 闹钟
@property (nonatomic, strong) NSArray *remindArray;                 // 久坐提醒.
@property (nonatomic, strong) NSDate *date;                         // 第一次连接设备的日期

+ (instancetype)initWithUUID:(NSString *)uuid;
// 从数据库获取模型.
+ (BLTModel *)getModelFromDBWtihUUID:(NSString *)uuid;
// 根据当前信号获取对应的图片名字.
- (NSString *)imageForsignalStrength;
// 添加闹钟.
- (BOOL)addAlarmClock:(CGFloat)height;

@end
