//
//  LLFMDBVc1.h
//  project
//
//  Created by 黄建华 on 2017/9/25.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
@interface LLFMDBVc1 : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UIPickerViewDelegate,UIPickerViewDataSource>
{
    //日历控件
    FSCalendar *_calendar;
    //
    UIView *_calendarView;
    
    //有数据的数组
    NSMutableArray *_datesWithEvent;
    
    NSMutableArray *_monthArray1;
    NSMutableArray *_monthArray2;
    UIView *_chooseMonthView;
    UIPickerView *_chooseMonthPick;
    NSInteger year;
    NSInteger month;
}

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITextField *textfield;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;
@property (nonatomic, strong) NSDate *currentDate;



@end
