//
//  HHHPublicClass.m
//  project
//
//  Created by 黄建华 on 2017/9/27.
//  Copyright © 2017年 黄建华. All rights reserved.
//

#import "HHHPublicClass.h"

@implementation HHHPublicClass

//数组反序
+ (NSMutableArray *)ReverseorderWithArray:(NSArray *)array
{
    return  (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
}

@end
