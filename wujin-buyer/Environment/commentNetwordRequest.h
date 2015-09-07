//
//  commentNetwordRequest.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/30.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^goodBlock)(NSDictionary *aDict);

@interface commentNetwordRequest : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

{
    @private
    goodBlock success;
    goodBlock failer;
    
    NSMutableData *didData;
    
    NSInteger length;
    
    BOOL NONETWORD;
}

@property (assign, readonly) CGFloat progress;

//用于get请求 ，base64加密
@property (strong, nonatomic) NSURLConnection *urlConnection;

/**
 取消异步线程
 */
- (void)cancelGET;

/**
 异步get
 */
+ (commentNetwordRequest *)GET:(NSString *)subULR withParams:(NSDictionary *)params
                 success:(void(^)(NSDictionary *successDic)) successBlock
                  failer:(void(^)(NSDictionary *failerDic)) failerBlock;


/**
 异步get
 */
+ (commentNetwordRequest *)POST:(NSString *)subULR withParams:(NSDictionary *)params
                       success:(void(^)(NSDictionary *successDic)) successBlock
                        failer:(void(^)(NSDictionary *failerDic)) failerBlock;


@end
