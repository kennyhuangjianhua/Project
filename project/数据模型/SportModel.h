//
//  SportModel.h
//  GetFit3.0
//
//  Created by zorro on 2017/7/21.
//  Copyright © 2017年 lxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportModel : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *mac;
@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *duration;
@property (nonatomic, assign) NSInteger step;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) NSInteger calory;
@property (nonatomic, strong) NSString *data;

@property (nonatomic, assign) NSInteger realTime;

@property (nonatomic, strong) NSArray *stepArr;
@property (nonatomic, strong) NSArray *distanceArr;
@property (nonatomic, strong) NSArray *calArr;

@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSArray *monthArr;
@property (nonatomic, strong) NSArray *dateArr;

+ (SportModel *)initWithDate:(NSDate *)date;


@end
