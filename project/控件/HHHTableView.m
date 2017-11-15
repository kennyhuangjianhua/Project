//
//  HHHTableView.m
//  project
//
//  Created by 黄建华 on 2017/9/30.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "HHHTableView.h"

@implementation HHHTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self LoadUi];
    }
    
    return self;
}

- (void)LoadUi
{
    _listArray = [NSMutableArray array];
    
    _tabelView = [[UITableView alloc] init];
    _tabelView.frame = CGRectMake(0, 74+40, HHHWIDTH, HHHHEIGHT - 74 -40);
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self addSubview:_tabelView];
}

- (void)updateListArray
{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DetailRemindCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        UILabel *label = [[UILabel alloc] init];
        label.tag = indexPath.row +100;
        [cell.contentView addSubview:label];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
