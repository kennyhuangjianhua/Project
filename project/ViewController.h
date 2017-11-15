//
//  ViewController.h
//  project
//
//  Created by 黄建华 on 2017/9/23.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSArray *listArray;

@end

