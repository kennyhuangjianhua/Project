//
//  AppDelegate.m
//  project
//
//  Created by 黄建华 on 2017/9/23.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SNNavigationViewController.h"
#import "CustomTabBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //检查设备模型
    [[ShareData sharedInstance]checkDeviceModel];
    
    [self createVideoFloders];
    
    // 状态栏设置为白色文字
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self enterMainVc];

    return YES;
}

- (void)enterMainVc
{
    CustomTabBar *guide = [[CustomTabBar alloc]init];
    SNNavigationViewController *customVC = [[SNNavigationViewController alloc] initWithRootViewController:guide];
    
    [self loadTextFontColor];
    
    self.window.rootViewController = customVC;
}

- (void)loadTextFontColor
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *str = [userD objectForKey:@"themeColor"];
    NSInteger i = 0;
    if (!str)
    {
        i = 0xbe9f61;
    }
    else
    {
        if ([str isEqualToString:@"默认"])
        {
            i = 0xbe9f61;
        }else if ([str isEqualToString:@"暗红"])
        {
            i = 0xc50b30;
        }else if ([str isEqualToString:@"浅蓝"])
        {
            i = 0x84b4e4;
        }else if ([str isEqualToString:@"深蓝"])
        {
            i = 0x0195d3 ;
        }else if ([str isEqualToString:@"蓝黑"])
        {
            i = 0xbe9f61;
        }else if ([str isEqualToString:@"鲜黄"])
        {
            i = 0xfecf29;
        }else if ([str isEqualToString:@"橙黄"])
        {
            i = 0xf66d1f;
        }else if ([str isEqualToString:@"紫色"])
        {
            i = 0x3e2581;
        }else if ([str isEqualToString:@"粉红"])
        {
            i = 0xff0066;
        }else if ([str isEqualToString:@"蓝色"])
        {
            i = 0x0000fe;
        }
    }
    [userD setInteger:i forKey:@"themeHex"];
    [userD synchronize];
}

- (void)enterLoginVc
{
    
}

- (void)createVideoFloders
{    // 通知不用上传备份
    [XYSandbox createDirectoryAtPath:[[XYSandbox docPath] stringByAppendingPathComponent:@"/db/"]];
    [XYSandbox createDirectoryAtPath:[[XYSandbox docPath] stringByAppendingPathComponent:@"/dbimg/"]];
    [[[XYSandbox docPath] stringByAppendingPathComponent:@"/db/"] addSkipBackupAttributeToItem];
    [[[XYSandbox docPath] stringByAppendingPathComponent:@"/dbimg/"] addSkipBackupAttributeToItem];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
