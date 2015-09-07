//
//  UserInfo.m
//  wujin-buyer
//
//  Created by wujin on 15/1/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

@class UserInfo;
#import "AppDelegate.h"

static UserInfo *_user;

#import "UserInfo.h"
#import "AFHTTPRequestOperation.h"
#import "EaseMob.h"
#import "NSString+base64.h"
#import "NSString+MD5.h"
#import <Security/Security.h>
#import "WJKeychain.h"
#import "UMessage.h"
#import "NSUserDefaults+Additions.h"

@implementation UserInfo


+ (UserInfo *)sharedUserInfo {
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        _user = [[UserInfo alloc] init];
    });
    
    return _user;
}

- (void)save {
    
    [[NSUserDefaults standardUserDefaults]setCurrentMemberID:self.userID];
    [[NSUserDefaults standardUserDefaults ]setCurrentMemberNick:self.userName];
    [[NSUserDefaults standardUserDefaults]setCurrentMemberAvatar:self.image];
}

- (void)load {
    
    self.userName = [[NSUserDefaults standardUserDefaults]currentMemberNick];
    self.userID = [[NSUserDefaults standardUserDefaults]currentMemberID];
    self.image = [[NSUserDefaults standardUserDefaults] currentMemberAvatar];
}

- (void)quit {
    
    [[NSUserDefaults standardUserDefaults]clearCurrentMemberID];
    [[NSUserDefaults standardUserDefaults] clearCurrentMemberNick];
    [[NSUserDefaults standardUserDefaults]clearCurrentAvatar];
    
}

- (void)userInfoWithDictionary:(NSDictionary *)userInfo {
    
    @synchronized(self) {

        self.userName = userInfo[@"unickname"];
        self.userID = userInfo[@"uid"];
        self.image = userInfo[@"uimg"];
        
        [self save];
    }
    
    if ([self.userDelegate respondsToSelector:@selector(UserSuccessEnter:)]) {
        
        [self.userDelegate UserSuccessEnter:userInfo];
    }
}

+ (BOOL)isEnter {
    
    return 0 != _user.userID.length;
}

+ (void)quitEnter {
    
    if (nil != _user.userName) {
        
//        [UMessage removeAlias:_user.userID type:@"buyer" response:^(id responseObject, NSError *error) {
//            
//        }];
        
        [_user setEntering:NO];
        
        //不设为空，怕词典异常
        _user.userID = @"";
        _user.userName = @"";
        _user.image = @"";
        [_user quit];
        
        //////将消息设置为0/////
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appdelegate.unRead = 0;
        
        //////退出环信///////////////
        [[EaseMob sharedInstance].chatManager asyncLogoff];
         [WJKeychain delete:KEY_USERNAME_PASSWORD];
    }
}

//开始登陆
- (void)startEnter:(NSDictionary *)login {
    
    if ([CommentRequest networkStatus] && ![[EaseMob sharedInstance].chatManager isLoggedIn]) {
    
        [self loginServer:login];
  
    } else {
        
        if ([self.userDelegate respondsToSelector:@selector(UserFailerEnter:)]) {
            
            [self.userDelegate UserFailerEnter:@{@"errMsg":ERROR_NETWORK}];
        }
    }
}

//环信登录
- (void)loginEaseMob:(NSDictionary *)dic withUserInfo:(NSDictionary *)successDic {

    NSString *userName = dic[@"mobile"];
    NSString *passWord = dic[@"pwd"];
    
    if (nil != userName && nil != passWord) {
        
         [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userName password:passWord completion:^(NSDictionary *loginInfo, EMError *error) {
          
             if (nil == error) {
              
              [self setEntering:NO];
              
              [self userInfoWithDictionary:successDic];
                 
                 /////////环信登陆成功////////
                 AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 [appDelegate aboutChat];
                 ////////////////

          } else {
                
               [self setEntering:NO];
    
               if ([self.userDelegate respondsToSelector:@selector(UserFailerEnter:)]) {
                    
                    [self.userDelegate UserFailerEnter:@{@"errMsg":ERROR_SERVER}];
               }
          }
        
         } onQueue:nil];

    }
}

//服务器登录
- (void)loginServer:(NSDictionary *)dic {
        
   // if (![UserInfo isEnter] && nil != dic) {
        
        [self setEntering:YES];
        
        if ([self.userDelegate respondsToSelector:@selector(UserWillBeginEnter:)]) {
            
            [self.userDelegate UserWillBeginEnter:self];
        }
        
        [commentNetwordRequest POST:LOGIN_URL withParams:dic success:^(NSDictionary *successDic) {
            
            
            [self setEntering:NO];
            
            [self userInfoWithDictionary:[successDic valueForKey:@"users"]];
        
        } failer:^(NSDictionary *failerDic) {
            
            [self setEntering:NO];
            if ([self.userDelegate respondsToSelector:@selector(UserFailerEnter:)]) {
                
                [self.userDelegate UserFailerEnter:failerDic];
            }
        }];
  //  }
}
@end
