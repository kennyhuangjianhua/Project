//
//  EWMViewController.h
//  project
//
//  Created by 黄建华 on 2017/10/18.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EWMViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession *session;   // 输入输出的中间桥梁
@property (nonatomic, strong) UIButton *flashLightButton; // 打开或则关闭设备闪关灯按钮

@end
