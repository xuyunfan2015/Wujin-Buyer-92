//
//  CommentResponse.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//
typedef void(^block)(NSDictionary *);

#import <Foundation/Foundation.h>

@interface CommentResponse : NSObject

{
    block _complete;
}

+ (void)parseServerData:(NSData *) JSONData
                success:(void(^)(NSDictionary *successDic)) success
                   fail:(void(^)(NSDictionary *failDic)) fail;
@end
