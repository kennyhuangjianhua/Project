//
//  HelpModelObject.h
//  project
//
//  Created by 黄建华 on 2017/9/26.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EveryDayModel.h"
@interface HelpModelObject : NSObject

AS_SINGLETON(HelpModelObject)


+ (EveryDayModel *)getModelFromDBWithToday;

// 根据日期取出模型。
+ (EveryDayModel *)getModelFromDBWithDate:(NSDate *)date;

@end
