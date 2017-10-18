//
//  LLFMDBVc1.m
//  project
//
//  Created by 黄建华 on 2017/9/25.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "LLFMDBVc1.h"
#import "FSCalendar.h"
// 亮黑色
#define BBIGLIGHTCOLOR [UIColor colorFromHex:0x111311]
// 亮金色
#define BFONTLIGHTCOLOR [UIColor colorFromHex:0xbe9f61]
@interface LLFMDBVc1 ()

@end

@implementation LLFMDBVc1

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _listArray = [NSMutableArray array];
    
    _tabelView = [[UITableView alloc] init];
    _tabelView.frame = CGRectMake(0, 74+40, HHHWIDTH, HHHHEIGHT - 74 -40);
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];

    _textfield = [[UITextField alloc] init];
    _textfield.frame = CGRectMake(5, 69, HHHWIDTH - 195, 40);
    _textfield.placeholder = @"输入!!!";
    _textfield.delegate = self;
    _textfield.backgroundColor = [UIColor yellowColor];
    _textfield.textColor = [UIColor blackColor];
    [self.view addSubview:_textfield];
    
    UIButton *dateChooseButton = [[UIButton alloc] init];
    dateChooseButton.frame = CGRectMake(HHHWIDTH - 100 - 80, 64 +5, 70, 40);
    [dateChooseButton setTitle:@"日期" forState:UIControlStateNormal];
    dateChooseButton.backgroundColor = [UIColor blueColor];
    [dateChooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateChooseButton addTarget:self action:@selector(crectCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateChooseButton];

    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *saveButton = [[UIButton alloc] init];
    saveButton.frame = CGRectMake(HHHWIDTH - 100, 64 +5, 90, 40);
    saveButton.backgroundColor = [UIColor blueColor];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    [self loadUiWith:[NSDate date]];
    
    self.title = [[NSDate date]dateToDayString];
    
}

- (void)loadUiWith:(NSDate*)date
{
    _currentDate = date;
    EveryDayModel *model = [HelpModelObject getModelFromDBWithDate:date];
    NSMutableArray *array = model.array1.mutableCopy;
    _listArray = [NSMutableArray arrayWithArray:array];
    _listArray = [HHHPublicClass ReverseorderWithArray:_listArray];
    [_tabelView reloadData];
}
#pragma mark - 创建日历
- (void)crectCalendar
{
    _datesWithEvent = [NSMutableArray array];
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"yyyy/MM/dd";
    
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"yyyy-MM-dd";
    
    _calendarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HHHWIDTH, HHHHEIGHT)];
    _calendarView.backgroundColor = [UIColor clearColor];
    _calendarView.alpha = 0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_calendarView];

    UILabel *label = [[UILabel alloc]initWithFrame:_calendarView.frame];
    label.text = @"";
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.4;
    label.userInteractionEnabled = YES;
    [_calendarView addSubview:label];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCalendar)];
    [label addGestureRecognizer:tap];
//
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,64,HHHWIDTH ,300)];
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.backgroundColor = BBIGLIGHTCOLOR;
    _calendar.currentPage = [[NSDate date]dateAfterDay:0];
     _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    _calendar.appearance.todayColor = [UIColor blueColor];//今天日期圆圈颜色
    _calendar.appearance.selectionColor = [UIColor blueColor];//今日字体选中颜色
    _calendar.appearance.titleDefaultColor = [UIColor whiteColor];//今日日期圆圈内字体颜色
    [_calendarView addSubview:_calendar];
    [UIView animateWithDuration:0.3 animations:^{
        _calendarView.alpha = 1;
    }];
    //选择月份的
    UIButton *monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    monthBtn.frame = CGRectMake(0, 0, HHHWIDTH, 40);
    [monthBtn setTitleNormal:@""];
    [monthBtn addTouchUpTarget:self action:@selector(showChooseMonthView)];
    
    [_calendar addSubview:monthBtn];
}

- (void)chooseMonth
{
    [self hiddenChooseMonth];
    _calendar.currentPage = [self.dateFormatter2 dateFromString:[NSString stringWithFormat:@"%ld-%.2ld-1",year,month]];
}

- (void)hiddenChooseMonth
{
    [UIView animateWithDuration:0.3 animations:^{
        _chooseMonthView.alpha  = 0;
    }completion:^(BOOL finished) {
        [_chooseMonthView removeFromSuperview];
        _calendar.alpha = 1;
    }];
}

- (void)hiddenCalendar
{
    [UIView animateWithDuration:0.3 animations:^{
        _calendarView.alpha  = 0;
    }completion:^(BOOL finished) {
        [_calendarView removeFromSuperview];
    }];
}

- (void)showChooseMonthView
{
    _calendar.alpha = 0;
    NSInteger nowYear = [NSDate date].year;
    _monthArray1 = [NSMutableArray array];
    _monthArray2 = [NSMutableArray array];
    for (NSInteger i = nowYear-5; i<=nowYear; i++)
    {
        [_monthArray1 addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    for (NSInteger i = 1; i<=12; i++)
    {
        [_monthArray2 addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    _chooseMonthView = [[UIView alloc]initWithFrame:_calendar.frame];
    _chooseMonthView.backgroundColor = [UIColor whiteColor];
    [_calendarView addSubview:_chooseMonthView];
    
    _chooseMonthPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, HHHWIDTH, 200)];
    year = [_monthArray1[0] integerValue];
    month =1;
    _chooseMonthPick.delegate = self;
    _chooseMonthPick.dataSource = self;
    [_chooseMonthView addSubview:_chooseMonthPick];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.frame = CGRectMake(HHHWIDTH/2, 200, HHHWIDTH/2, 100);
    [confirm setTitleNormal:@"确定"];
    confirm.backgroundColor = [UIColor blueColor];
    [confirm addTouchUpTarget:self action:@selector(chooseMonth)];
    [_chooseMonthView addSubview:confirm];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 200, HHHWIDTH/2, 100);
    [cancel setTitleNormal:@"取消"];
    cancel.backgroundColor = [UIColor redColor];
    [cancel addTouchUpTarget:self action:@selector(hiddenChooseMonth)];
    [_chooseMonthView addSubview:cancel];
}

#pragma mark - <FSCalendarDelegete>
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    //日历选择日期距离今天多少天
    NSInteger nowcount = [[NSDate date] dateByDistanceDaysWithDate:date];
    NSLog(@"选择了日期 date %@ --->%ld 日期>>>%@",[self.dateFormatter1 stringFromDate:date],nowcount,date);

    self.title = date.dateToDayString;
   [self loadUiWith:date];
    
    if (nowcount>0)
    {
        return NO;
    }
    else
    {
        [self hiddenCalendar];
        return YES;
    }
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return 1;
    }
    
    return 0;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    
    if ([_datesWithEvent containsObject:dateString]) {
        return [UIColor colorWithRed:18/255.0f green:122/255.0f blue:212/255.0f alpha:1];
    }
    return nil;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"当前查看月%s %@", __FUNCTION__, [self.dateFormatter1 stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.bounds = bounds;
    calendar.y = 64;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _monthArray1.count;
        
    }else{
        return _monthArray2.count;
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return  [_monthArray1 objectAtIndex:row];
        
    }else{
        return  [_monthArray2 objectAtIndex:row];
        
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        year = [[_monthArray1 objectAtIndex:row] integerValue];
    }else if (component == 1){
        month = [[_monthArray2 objectAtIndex:row] integerValue];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont boldSystemFontOfSize:27.0f];
        pickerLabel.textColor = [UIColor colorFromHex:0x03A9F4];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    //在该代理方法里添加以下两行代码删掉上下的黑线
    [[pickerView.subviews objectAtIndex:1] setHidden:YES];
    [[pickerView.subviews objectAtIndex:2] setHidden:YES];
    
    return pickerLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)savebuttonClick
{
    if (_textfield.text.length > 0)
    {
        NSLog(@"text>>>>>>>>%@",_textfield.text);

        EveryDayModel *model = [HelpModelObject getModelFromDBWithDate:_currentDate];
        NSMutableArray *array = [NSMutableArray arrayWithArray:model.array1];
        
        NSString *save = [NSString stringWithFormat:@"%@ %@",_textfield.text,[[NSDate date]dateToTimeString]];
        [array addObject:save];
        model .array1 = array;
        [model updateToDB];
        
        _listArray = [NSMutableArray arrayWithArray:array];
        _listArray = [HHHPublicClass ReverseorderWithArray:_listArray];
        [_tabelView reloadData];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@">>>>>>%@",textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
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
    
    NSString *s = _listArray[indexPath.row];
    NSArray *array = [s componentsSeparatedByString:@" "];
    cell.textLabel.text = [array firstObject];
    
    UILabel *label = (UILabel *)[cell viewWithTag:indexPath.row+100];
    label.font = HHHFONT(14.0);
    label.textAlignment = NSTextAlignmentRight;
    label.frame = HHHFRAME(HHHWIDTH - 100, 10, 90, 20);
    label.text = [array lastObject];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
//         删除数据源的数据,self.cellData是你自己的数据
        [_listArray removeObjectAtIndex:indexPath.row];
//         删除列表中数据
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        EveryDayModel *model = [HelpModelObject getModelFromDBWithDate:_currentDate];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_listArray];
        model .array1 = array;
        [model updateToDB];
    }
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
