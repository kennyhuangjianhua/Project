//
//  CustomTabBar.m
//  GetFit3.0
//
//  Created by 秀才 on 2016/11/26.
//  Copyright © 2016年 lxc. All rights reserved.
//

#import "CustomTabBar.h"
#import "SNNavigationViewController.h"
#import "SNHomePageViewController.h"
#import "SNTrackViewController.h"
#import "SNEquipmentViewController.h"
#import "SNSettingViewController.h"

@interface CustomTabBar ()
{
    UIView *_tabBarView;
}
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *selectImageArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation CustomTabBar

- (void)viewDidLoad
{
    [super viewDidLoad];
    //  隐藏UITabBarButton
    self.tabBar.hidden = YES;
    
    _normalImageArray = [NSArray arrayWithObjects:@"icon_home_unselect",@"icon_body_check_unselect",@"icon_manager_unselect",@"icon_my_unselect", nil];
    
    _selectImageArray = [NSArray arrayWithObjects:@"icon_home_selected",@"icon_body_check_selected",@"icon_manager_select",@"icon_my_selected", nil];
    
    _titleArray = [NSArray arrayWithObjects:HHH_Text(@"主页"),HHH_Text(@"跑道"),HHH_Text(@"设备"),HHH_Text(@"设置"), nil];
    
    SNHomePageViewController *Vc1 = [[SNHomePageViewController alloc]init];
    SNNavigationViewController *nav1 = [[SNNavigationViewController alloc]initWithRootViewController:Vc1];
    
    SNTrackViewController *Vc2 = [[SNTrackViewController alloc]init];
    SNNavigationViewController *nav2 = [[SNNavigationViewController alloc]initWithRootViewController:Vc2];
    
    SNEquipmentViewController *Vc3 = [[SNEquipmentViewController alloc] init];
    SNNavigationViewController *nav3 = [[SNNavigationViewController alloc]initWithRootViewController:Vc3];
    
    SNSettingViewController *Vc4 = [[SNSettingViewController alloc]init];
    SNNavigationViewController *nav4 = [[SNNavigationViewController alloc]initWithRootViewController:Vc4];
    
    NSArray *vcs =@[nav2,nav1,nav4,nav3];
    [self setViewControllers:vcs animated:YES];
    
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, HHHHEIGHT - 49, HHHWIDTH, 49)];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, HHHWIDTH, 0.5)];
    label.backgroundColor = BLINECOLOR;
    [_tabBarView addSubview:label];
    _tabBarView.backgroundColor = BBIGLIGHTCOLOR;
    
    for (int i = 0; i < 4; i ++)
    {
        UIButton *tarBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tarBarButton.frame = CGRectMake(HHHWIDTH/4 *i, 1, HHHWIDTH/4, 49);
        tarBarButton.tag = i;
         [tarBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         [_tabBarView addSubview:tarBarButton];

        UIImageView *imageV =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageV.tag = i + 1000;
        imageV.center = CGPointMake(tarBarButton.x + HHHWIDTH/4 /2, 49/2 - 6);
        imageV.image = [UIImage image:_normalImageArray[i]];
        [_tabBarView addSubview:imageV];
        imageV.alpha = 1 - i *0.20;
      
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,HHHWIDTH/4, 20)];
        titleLabel.alpha = 1 - i *0.20;
        titleLabel.tag = i + 100;
        titleLabel.font = [UIFont systemFontOfSize:10.0f];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.center = CGPointMake(tarBarButton.center.x ,tarBarButton.center.y + 14);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = _titleArray[i];
        titleLabel.textColor = [UIColor whiteColor];
        [_tabBarView addSubview:titleLabel];
        
        if (i == 0)
        {
        titleLabel.textColor = BFONTLIGHTCOLOR;
        imageV.image = [UIImage image:_selectImageArray[i]];
        }
    }
    _lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(0, 0, HHHWIDTH/4, 2);
    _lineView.backgroundColor = [UIColor grayColor];
    [_tabBarView addSubview:_lineView];

}

- (void)dealloc
{
    
}

- (void)tabBarButtonClick:(UIButton *)sender
{
    NSLog(@"sender tag>>>>>%d",sender.tag);
    self.selectedIndex = sender.tag;
    
    [UIView animateWithDuration:0.3 animations:^{
    _lineView.frame = CGRectMake(HHHWIDTH/4*sender.tag, 0, HHHWIDTH/4, 2);
    }];
    
    for (UILabel *view in _tabBarView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            if (view.tag == sender.tag + 100)
            {
             view.textColor = BFONTLIGHTCOLOR;
            }
            else
            {
              view.textColor = [UIColor whiteColor];
            }
        }
    }
    
    for (UIImageView *view in _tabBarView.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]])
        {
            if (view.tag == sender.tag + 1000)
            {
                view.image = [UIImage image:_selectImageArray[view.tag - 1000]];
            }
            else
            {
                view.image = [UIImage image:_normalImageArray[view.tag - 1000]];
            }
              [view setTintColor:BFONTLIGHTCOLOR];
        }
    }
}

-(void)showTheTabBarView
{
    [UIView animateWithDuration:0.3 animations:^{
        _tabBarView.frame = CGRectMake(0, HHHHEIGHT - 49, HHHWIDTH, 49);
    }];
//    _tabBarView.hidden = NO;
}

-(void)hiddenTheTabBarView
{
    [UIView animateWithDuration:0.3 animations:^{
        _tabBarView.frame=CGRectMake(0, HHHHEIGHT, HHHWIDTH, 49);
    }];
//    _tabBarView.hidden = YES;

}

@end
