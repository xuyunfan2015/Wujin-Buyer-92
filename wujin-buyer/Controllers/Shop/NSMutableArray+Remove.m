//
//  NSMutableArray+Remove.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/22.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "NSMutableArray+Remove.h"

@implementation NSMutableArray (Remove)

- (void)removeObjectWithPrefix:(NSString *)prefix {
    
    NSMutableArray * tempArray = [[NSMutableArray alloc] initWithArray:self];
    
    for (NSString * content in tempArray) {
        
        if ([content hasPrefix:prefix]) {
            
            [self removeObject:content ];
        }
    }
}

- (NSInteger)numberOfObjectWithPrefix:(NSString *)prefix {
    
    int total = 0;
    
    for (NSString * content in self) {
        
        if([content hasPrefix:prefix]){
            
            total ++;
        }

    }
    
    return total;
}

- (NSInteger)numberOfObjectAtIndex:(NSString *)object {
   
    for (int index = 0; index < [self count];index ++) {
        
        if ([self[index]intValue] == [object intValue]) {
            
            return index;
        }
        
    }
    return -1;
}

@end
