//
//  ZKKViewController.h
//  VPhone
//
//  Created by zorro on 14-10-22.
//  Copyright (c) 2014年 zorro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKKViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;

- (void)loadTitleView:(NSString *)text;
- (void)loadItemButton;

@end
