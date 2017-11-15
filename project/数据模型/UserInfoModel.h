//
//  UserInfoModel.h
//  AJBracelet
//
//  Created by zorro on 15/7/6.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AlarmClockModel;
@class CalendarModel;
@class DrinkModel;
@class PhysicalModel;
@class SedentaryModel;

@interface UserInfoModel : NSObject

// 所有的东西在set前都必须转成公制.
// 添加了2个,其它有些就暂未存储,如地区,签名等

// Getfit3.0
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *nickname;       // 昵称
@property (nonatomic, assign) NSInteger gender;            // 1为男 2为女
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sign;           // 签名
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, assign) NSInteger healthTime;

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) NSInteger is_first;

@property (nonatomic, assign) BOOL isMetricSystem;      // 是否是公制 公制为NO
@property (nonatomic, assign) BOOL is24Time;            // 是否24小时制 24小时为NO

@property (nonatomic, strong) NSDictionary *stepDic;
@property (nonatomic, strong) NSDictionary *sleepDic;

@property (nonatomic, assign) NSInteger lanuage;        // 语言 0中文 1英文 其他
@property (nonatomic, strong) NSString *portrait;         // 头像
@property (nonatomic, strong) UIImage *headImage;       // 头像 目前为本地的
@property (nonatomic, strong) NSString *userName;       // 用户名
@property (nonatomic, strong) NSString *password;       // 密码
@property (nonatomic, strong) NSString *wallpaper;         // 背景图

// @property (nonatomic, strong) NSString *birthDay;       // 生日   格式为1990-05-01

// @property (nonatomic, assign) NSInteger genderSex;      // 性别 1为女 0为男 get用下面的show方法
// @property (nonatomic, assign) NSInteger height;         // 身高 get的话用下面的show方法
// @property (nonatomic, assign) NSInteger weight;         // 体重 get的话用下面的show方法
@property (nonatomic, assign) CGFloat step;             // 步距

@property (nonatomic, strong) NSString *interest;       // 兴趣
@property (nonatomic, strong) NSString *manifesto;      // 宣言
@property (nonatomic, assign) CGFloat targetCalories;    // 目标卡路里
@property (nonatomic, assign) CGFloat targetDistance;    // 目标距离

@property (nonatomic, strong) NSString *showGenderSex;   // 性别显示
@property (nonatomic, strong) NSString *showAge;         // 年龄显示
@property (nonatomic, strong) NSString *showHeight;      // 显示身高
@property (nonatomic, strong) NSString *showWeight;      // 显示体重

@property (nonatomic, strong) NSString *showMetricSystem; // 显示公制 1为公制 0 为英制
@property (nonatomic, strong) NSString *showAllDays;      // 1 24小时制度 0为12小时制度
@property (nonatomic, strong) NSString *showLanuage;      // 0中文 1英文

@property (nonatomic, strong) NSArray *alarmArray;                  // 闹钟
@property (nonatomic, strong) NSArray *calendarArray;               // 日常提醒.
@property (nonatomic, strong) DrinkModel *drinkModel;               // 喝水提醒.
@property (nonatomic, strong) PhysicalModel *physicalModel;         // 体检提醒.
@property (nonatomic, strong) SedentaryModel *sedentaryModel;       // 久坐提醒.

// 闹钟使用到的参数
@property (nonatomic, assign) NSInteger clockOpenNumber;         // 开启的个数
@property (nonatomic, assign) NSInteger clockShowNumber;         // 显示的个数

// 日程使用到的参数
@property (nonatomic, assign) NSInteger calendarOpenNumber;         // 开启的个数
@property (nonatomic, assign) NSInteger calendarShowNumber;         // 显示的个数

// 健康设置的参数
@property (nonatomic, assign) NSInteger target_step;            // 目标步数
@property (nonatomic, assign) NSInteger target_sleep;           // 目标睡眠
@property (nonatomic, assign) NSInteger max_step;               // 最大步数
@property (nonatomic, assign) NSInteger max_reach_times;        // 最大步数连续达标天数

@property (nonatomic, strong) NSArray *targetStepsArray;     // 周目标步数
@property (nonatomic, strong) NSArray *targetSleepArray;     // 周目标睡眠

// 心率范围
@property (nonatomic, assign) NSInteger heartMin;           // 下限
@property (nonatomic, assign) NSInteger heartMax;           // 上限
// 血氧范围
@property (nonatomic, assign) NSInteger bloxyMin;           // 下限
@property (nonatomic, assign) NSInteger bloxyMax;           // 上限

@property (nonatomic, assign) NSInteger physicalTime;       // 体检时间

@property (nonatomic, strong) NSString *lastMacAddress;
@property (nonatomic, strong) NSString *lastBleUuid;

// 提醒设置
@property (nonatomic, assign) NSInteger phoneNotice;
@property (nonatomic, assign) NSInteger smsNotice;
@property (nonatomic, assign) UInt8 messageNotice; //废弃字段
@property (nonatomic, assign) NSInteger lowElecNotice;
@property (nonatomic, assign) NSInteger liftNotice;
@property (nonatomic, assign) NSInteger lostNotice;
@property (nonatomic, assign) NSInteger autoCheckHeart;
@property (nonatomic, assign) NSInteger changeScreen;
@property (nonatomic, assign) NSInteger messageNoticeSwitch;
@property (nonatomic, assign) BOOL hand;



//是否更新最佳战绩数据
@property (nonatomic,assign)BOOL bigerThanTarget;
+ (UserInfoModel *)parseString:(NSString *)string;
// 从数据库获取用户信息
+ (UserInfoModel *)getUserInfoFromDBWithUserID:(NSString *)userID;
- (BOOL)addAlarmClockType:(NSString *)string;
- (void)updateDataSafely;
+ (void)updateUserInfo:(UserInfoModel *)user;
+ (void)updateUserInfoWithLogin:(UserInfoModel *)user;
- (AlarmClockModel *)toAddAlarmClock;
- (CalendarModel *)toAddCalendar;

- (void)sendSettingToDevice:(BOOL)isPop;
// 用户信息上传到服务器 不含照片的上传获取
- (void)uploadToServer;

@end
