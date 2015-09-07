//
//  CommentRequest.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CommentRequest.h"
#import "NSString+base64.h"
#import "JSONKit.h"
#import "Reachability.h"

@implementation CommentRequest

+ (NSString *)getCompleteImageURLStringWithSubURL:(NSString *)imageURL {
    
    return [CommentRequest getCompleteURL:imageURL];
}

+ (NSString *)getCompleteURL:(NSString *)subURL {
    
    return [NSString stringWithFormat:@"%@%@",hostUrl,subURL];
}

+ (NSString *)params:(NSDictionary *)params {
    
    NSArray * allKeys = [params allKeys];
    
    NSMutableString * paramsString = [[NSMutableString alloc] initWithCapacity:0];
    
    BOOL first = YES;
    
    for (NSString * key in allKeys) {
        
        NSString * value = [params valueForKey:key];
        
        if (first) {
        
            [paramsString appendFormat:@"%@=%@",key,value];
        
            first = NO;
        }else {
            
              [paramsString appendFormat:@"&%@=%@",key,value];
        }
        
    }
    
    return [paramsString base64Encrypt];
}


+ (NSURLRequest *)createGetURLWithSubURL:(NSString *)subURL params:(NSMutableDictionary *)params {
    
    NSString * urlString = [NSString stringWithFormat:@"%@?uri=%@",[CommentRequest getCompleteURL:subURL],[CommentRequest params:params]];
    
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    
     NSLog(@"Request-GET:%@",[urlRequest.URL absoluteString]);
    
    return urlRequest;
}
/***
 参数的值放在body内
 */
+ (NSURLRequest *)createPostURLWithSubURL:(NSString *)subURL bodyParams:(NSMutableDictionary *)params {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self getCompleteURL:subURL]]];
    [request setTimeoutInterval:15.f];
    [request setHTTPMethod:@"POST"];
  
    NSString * paramsString = [CommentRequest commonParamsWithData:params];
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[paramsString length]];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: [paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSLog(@"%@", paramsString);
    
    return request;
}
/*
 参数的值采用postvalue的方式
 **/

+ (NSURLRequest *)createPostURLWithSubURL:(NSString *)subURL postValueParams:(NSMutableDictionary *)params {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self getCompleteURL:subURL]]];
    [request setTimeoutInterval:15.f];
    [request setHTTPMethod:@"POST"];
    
    NSLog(@"Request-POST:%@",[request.URL absoluteString]);
    
    NSMutableString * paramsString = [[NSMutableString alloc] initWithCapacity:0];
    
    NSArray * allKeys = [params allKeys];
    
    BOOL isFirst = YES;
    
    for ( NSString * key in allKeys) {
        
        NSString * value = [params valueForKey:key];
        
        if (isFirst) { //如果是第一个
            
            isFirst = NO;
            
            [paramsString appendFormat:@"%@=%@",key,value];
            
        }else {//否则
        
            [paramsString appendFormat:@"&%@=%@",key,value];
        }
    }
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[paramsString length]];
  //  [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:msgLength forHTTPHeaderField:@"Content-Length"];

    [request setHTTPBody: [paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSLog(@"%@", paramsString);
    
    return request;
}

+ (BOOL)networkStatus {
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    return isExistenceNetwork;
}

+ (NSString *)commonParamsWithData:(NSMutableDictionary *)paramsDic {
    
    //////
    //可在此处添加参数
    //////
    NSString *paramStr= [paramsDic JSONString];
    
    //  NSLog(@"%@",paramStr);
    return paramStr;
}


@end
