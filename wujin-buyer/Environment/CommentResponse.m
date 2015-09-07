//
//  CommentResponse.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CommentResponse.h"

@implementation CommentResponse

+ (void)parseServerData:(NSData *) JSONData
                success:(void(^)(NSDictionary *successDic)) success
                   fail:(void(^)(NSDictionary *failDic)) fail {
    
    if (nil != JSONData) {
        
        NSLog(@"%@", [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding]);
       
        CommentResponse *_com = [[CommentResponse alloc] init];
        
        NSDictionary *responseDic = [self JSONDataParse:JSONData];
        
        if (nil != responseDic) {
            //0 != [responseDic[@"code"] intValue]
            if (0) {
                
                responseDic = [NSDictionary dictionaryWithObjectsAndKeys:ERROR_DATA,@"errMsg", nil];
               
                _com->_complete = fail;
                
            } else {
                
                _com->_complete = success;
            }
     
        } else {
            
            responseDic = [NSDictionary dictionaryWithObjectsAndKeys:ERROR_DATA,@"errMsg", nil];
            
            _com->_complete = fail;
           
        }
        
        [_com performSelectorOnMainThread:@selector(completeOnMain:) withObject:responseDic waitUntilDone:YES];
   
    } else {
        
        fail(@{@"errMsg":ERROR_DATA});
    }
    
}

//再主线程上执行
- (void)completeOnMain:(NSDictionary *)dic {
    
    _complete(dic);
}

+ (id)JSONDataParse:(NSData *)JSONData {
    
    //NSString * error = [[NSString alloc] initWithData:JSONData encoding:4];
    
    //NSLog(@"error-----------------------------%@",error);
    
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
}

@end
