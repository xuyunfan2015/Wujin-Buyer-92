//
//  commentNetwordRequest.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/30.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "commentNetwordRequest.h"

@implementation commentNetwordRequest 

+ (commentNetwordRequest *)GET:(NSString *)subULR withParams:(NSDictionary *)params
                 success:(void(^)(NSDictionary *successDic)) successBlock
                  failer:(void(^)(NSDictionary *failerDic)) failerBlock {
    
    commentNetwordRequest *netword = [[commentNetwordRequest alloc] init];
    
    NSURLRequest *urlRequest = [CommentRequest createGetURLWithSubURL:subULR params:[NSMutableDictionary dictionaryWithDictionary:params]];
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:netword];
    
    //NSLog(@"url---%@", urlRequest);
    
    netword->success = successBlock;
    netword->failer = failerBlock;
    netword.urlConnection = urlConnection;
    
    if ([netword judgeNetword])
        [urlConnection start];
    
    return netword;
}

+ (commentNetwordRequest *)POST:(NSString *)subURL withParams:(NSDictionary *)params
                       success:(void(^)(NSDictionary *successDic)) successBlock
                        failer:(void(^)(NSDictionary *failerDic)) failerBlock {
    
    commentNetwordRequest *netword = [[commentNetwordRequest alloc] init];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:subURL postValueParams:[NSMutableDictionary dictionaryWithDictionary:params]];
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:netword];
     
    
    netword->success = successBlock;
    netword->failer = failerBlock;
    netword.urlConnection = urlConnection;
    
    if ([netword judgeNetword])
        [urlConnection start];
    
    return netword;
}


- (void)cancelGET {
    
    [self.urlConnection cancel];
}

- (BOOL)judgeNetword {
    
    if ([CommentRequest networkStatus]) {
        
        self->NONETWORD = NO;
        
        return YES;
    } else {
        self->failer(@{@"errMsg":ERROR_NETWORK});
        self->NONETWORD = YES;
        
        return NO;
    }
}

#pragma -mark NSURLConnection代理
//连接失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if (!self->NONETWORD) {
         failer(@{@"errMsg":ERROR_SERVER});
    }
    
    _progress = 0;
    
    NSLog(@"error--%@", error.localizedDescription);
}

//跟服务器对接上了
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    _progress = 0;
    
    length = (NSInteger)(response.expectedContentLength);
    
    didData = [NSMutableData data];
}

//接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [didData appendData:data];
    
    _progress = didData.length * 1.0f/ length;
}

//完成接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (nil != didData) {
        
        [CommentResponse parseServerData:didData success:^(NSDictionary *successDic) {
            
            self->success(successDic);
        } fail:^(NSDictionary *failDic) {
            
            self->failer(failDic);
        }];
    } else {
        
        self->failer(@{@"errMsg":ERROR_DATA});
    }
}

- (void)dealloc {
    
    if (self.urlConnection) {
        
        [self cancelGET];
    }
}
@end
