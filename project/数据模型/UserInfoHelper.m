//
//  UserInfoHelper.m
//  AJBracelet
//
//  Created by zorro on 15/7/6.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "UserInfoHelper.h"
#import "XYSandbox.h"

@implementation UserInfoHelper

DEF_SINGLETON(UserInfoHelper)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _alarmCount = 0;
        _scheduleCount = 0;
        
        _alarmTypeArray = @[HHH_Text(@" Alarm clock  "), HHH_Text(@" Get up  "),
                            HHH_Text(@" Sleep  "), HHH_Text(@" Date  "),
                            HHH_Text(@" Party  "), HHH_Text(@"  Eat "),
                            HHH_Text(@" Take medicine  "), HHH_Text(@"  Work "),
                            HHH_Text(@"  Physical examination "), HHH_Text(@"  Meeting "),
                            HHH_Text(@" Movement  ")];
   
        NSString *userID = [KK_LastUser getObjectValue];
        if (!userID) {
            userID = @"GetFit3";
        }
        _userModel = [UserInfoModel getUserInfoFromDBWithUserID:userID];
    }
    
    return self;
}

// 拍照模式
- (void)sendPhotoControl:(BOOL)type
{

}

- (void)removeUserHeadImage
{
    NSString *filePath = [self headImagePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:filePath error:nil];
}

// 缓存用户头像到本地.
- (void)saveHeadImageToFileCacheWithPicker:(UIImagePickerController *)picker withInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *scaleImage = [image imageScaleToSize:CGSizeMake(200.0, 200.0)];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    
    NSString *filePath = [self headImagePath];
    NSData *data = UIImageJPEGRepresentation(scaleImage, 1.0);
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

// 获取用户头像.
- (UIImage *)localHeadImage
{
    NSString *filePath = [self headImagePath];
    if ([self completePathDetermineIsThere:filePath]) {
        return [UIImage imageWithPath:filePath];
    } else {
        // 默认头像图片
        return UIImageNamed(@"loginhead");
    }
}

- (NSString *)headImagePath
{
    NSString *filePath = [[XYSandbox libCachePath] stringByAppendingPathComponent:KK_HeadImage];
    
    return filePath;
}

// 设置闹钟
- (void)startSetAlarmClock
{
    _alarmCount = 0;
    [self sendClockSetting];
}

- (void)sendClockSetting
{
   
}

// 设置日程
- (void)startSetCalendar
{
    _scheduleCount = 0;
     [self sendCalendarSetting];
}

- (NSString *)showcurrentlanguage
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

// 设置日程 0~ 5 重复 时间点 标签
// 设置日程提醒
- (void)sendCalendarSetting
{
   
}
// 设置日程
- (void)settingScheduleSuf
{
}

-(NSString*)currentlanguage
{
    NSString *languageValue = @"0";
    
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    NSLog(@"系统语言>>>%@",languageName);
    
    if ([languageName isEqualToString:@"zh-Hans-CN"]) {
        languageValue = @"0";
    } else if ([languageName isEqualToString:@"en-CN"]) {
        languageValue = @"1";
    }
    
    return languageValue;
}

- (void)startDrinkWater
{
   
}

- (void)startsedentary
{
  
}

- (void)startphysical
{
  
}

- (void)startUpdateUserInfo
{
   
}

- (UInt8)MessageNotice
{
    UInt8 messageInfo = 0;
      messageInfo = bitInsertInt(messageInfo, 0, KK_User.phoneNotice);
      messageInfo = bitInsertInt(messageInfo, 1, KK_User.smsNotice);
      messageInfo = bitInsertInt(messageInfo, 0+2, KK_User.messageNotice);
      messageInfo = bitInsertInt(messageInfo, 1+2, KK_User.messageNotice);
      messageInfo = bitInsertInt(messageInfo, 2+2, KK_User.messageNotice);
      messageInfo = bitInsertInt(messageInfo, 3+2, KK_User.messageNotice);
      messageInfo = bitInsertInt(messageInfo, 4+2, KK_User.messageNotice);
      messageInfo = bitInsertInt(messageInfo, 5+2, KK_User.messageNotice);

    return messageInfo;
}

@end
