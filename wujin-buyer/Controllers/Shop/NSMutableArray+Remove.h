//
//  NSMutableArray+Remove.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/22.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Remove)

- (void)removeObjectWithPrefix:(NSString *)prefix;

- (NSInteger)numberOfObjectWithPrefix:(NSString *)prefix;

- (NSInteger)numberOfObjectAtIndex:(NSString *)object;


@end
