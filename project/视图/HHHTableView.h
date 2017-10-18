//
//  HHHTableView.h
//  project
//
//  Created by 黄建华 on 2017/9/30.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *listArray;

- (void)updateListArray;

@end
