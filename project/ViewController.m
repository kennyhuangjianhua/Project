//
//  ViewController.m
//  project
//
//  Created by 黄建华 on 2017/9/23.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
//    UITextField *writeText = [[UITextField alloc] init];
//    writeText.frame = CGRectMake(10, 100, 200, 20);
//    writeText.placeholder = @"请输入内容!!!";
//    writeText.textColor = [UIColor blueColor];
//    writeText.delegate = self;
//    [self.view addSubview:writeText];
    
    _listArray = [[NSArray alloc] initWithObjects:@"数据库-记事本",@"扫码获取",@"音量亮度",@"语音识别", nil];
    
    _tabelView = [[UITableView alloc] init];
    _tabelView.frame = CGRectMake(0, 0, HHHWIDTH, HHHHEIGHT );
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
    
    self.title = @"功能列表";

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
    }

    cell.textLabel.text = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        LLFMDBVc1 *vc = [[LLFMDBVc1 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1)
    {
        EWMViewController *vc = [[EWMViewController alloc] init];
       [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2)
    {
        BrightnessViewController *vc = [[BrightnessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
