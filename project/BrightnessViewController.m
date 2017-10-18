//
//  BrightnessViewController.m
//  project
//
//  Created by 黄建华 on 2017/10/18.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "BrightnessViewController.h"

@interface BrightnessViewController ()

@end

@implementation BrightnessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 使用方法一 xib使用 拖一个UIView修改继承类为BrightnessVolumeView就可以了
    
    // 使用方法二 全代码使用
    BrightnessVolumeView *brightView = [[BrightnessVolumeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:brightView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
