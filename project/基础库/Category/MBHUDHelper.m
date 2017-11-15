//
//  MBHUDHelper.m
//  AJBracelet
//
//  Created by zorro on 15/5/27.
//  Copyright (c) 2015年 zorro. All rights reserved.
//

#import "MBHUDHelper.h"

@implementation MBHUDHelper

static MBProgressHUD *HUD = nil;

+ (void)hiddenMBProgressHUD
{
    [HUD hide:YES];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelText = message;
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    HUD.dimBackground = YES;
    return HUD;
}
+ (MBProgressHUD *)MBProgressHUD
{
    return HUD;
}

+ (MBProgressHUD *)showMBProgressHUDTitle:(NSString *)aTitle
                                      msg:(NSString *)aMsg
                                    image:(UIImage *)aImg
                                    dimBG:(BOOL)dimBG
                                    delay:(float)d
{
    UIViewController *vc = [self topMostController];
    
    if (vc == nil)
    {
        return nil;
    }
    
    if (nil == HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:vc.view];
    }
    
    [vc.view addSubview:HUD];
    
    
    if (aTitle || aMsg)
    {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = aTitle;
        HUD.detailsLabelText = aMsg;
    }
    
    if (aImg)
    {
        UIImageView *img = [[UIImageView alloc] initWithImage:aImg];
        HUD.customView = img;
        HUD.mode = MBProgressHUDModeCustomView;
    }
    
    HUD.removeFromSuperViewOnHide = YES;
    HUD.dimBackground = NO;
    HUD.userInteractionEnabled = !dimBG;
    [HUD show:YES];
    
    if (d > 0)
    {
        [HUD hide:YES afterDelay:d];
    }
    
    return HUD;
}

+ (MBProgressHUD *)showMBProgressHUDModeIndeterminateTitle:(NSString *)aTitle
                                                       msg:(NSString *)aMsg
                                                     dimBG:(BOOL)dimBG
{
    UIViewController *vc = [self topMostController];
    
    if (vc == nil)
    {
        return nil;
    }
    
    if (nil == HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:vc.view];
    }
    
    [vc.view addSubview:HUD];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = aTitle;
    HUD.detailsLabelText = aMsg;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.dimBackground = dimBG;
    [HUD show:YES];
    
    return HUD;
}

+ (MBProgressHUD *)showMBProgressHUDTitle:(NSString *)aTitle
                                      msg:(NSString *)aMsg
                                    dimBG:(BOOL)dimBG
                             executeBlock:(void(^)(MBProgressHUD *hud))blockE
                              finishBlock:(void(^)(void))blockF
{
    UIViewController *vc = [self topMostController];
    
    if (vc == nil)
    {
        return nil;
    }
    
    if (nil == HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:vc.view];
    }
    
    [vc.view addSubview:HUD];
    
    HUD.labelText = aTitle;
    HUD.detailsLabelText = aMsg;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.dimBackground = dimBG;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        blockE(HUD);
    } completionBlock:^{
        //[hud hide:YES];
        blockF();
    }];
    
    return HUD;
}

@end
