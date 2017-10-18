//
//  EveryDayModel.h
//  project
//
//  Created by 黄建华 on 2017/9/26.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryDayModel : NSObject

@property (nonatomic, assign) NSString *step;       // 当前步数
@property (nonatomic, strong) NSString *dateString; // 日期 2017-09-26
@property (nonatomic, assign) BOOL isSaveAllDay;    // 是否保存了全天的数据
+ (EveryDayModel *)simpleInitWithDate:(NSDate *)date;

@property (nonatomic, strong) NSArray *array1;       // 数组1 事件+时间
@property (nonatomic, strong) NSArray *array2;
@property (nonatomic, strong) NSArray *array3;

@end
