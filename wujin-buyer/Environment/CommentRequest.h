//
//  CommentRequest.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentRequest : NSObject
/**
 获取完整的图片url
 */
+ (NSString *)getCompleteImageURLStringWithSubURL:(NSString *)imageURL;
/***
 创建get请求
 */
+ (NSURLRequest *)createGetURLWithSubURL:(NSString *)subURL params:(NSMutableDictionary *)params;

/***
 参数的值放在body内
 */
+ (NSURLRequest *)createPostURLWithSubURL:(NSString *)subURL bodyParams:(NSMutableDictionary *)params;
/*
 参数的值采用postvalue的方式
 **/

+ (NSURLRequest *)createPostURLWithSubURL:(NSString *)subURL postValueParams:(NSMutableDictionary *)params;
/*
 判断网络状态
 */
+ (BOOL)networkStatus;

@end
