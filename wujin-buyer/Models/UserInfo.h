//
//  UserInfo.h
//  wujin-buyer
//
//  Created by wujin on 15/1/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

@protocol UserEnterDelegate;

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (assign, getter=isEntering) BOOL entering;

///值
@property (strong, atomic) NSString *userName;
@property (strong, atomic) NSString *userID;
@property (strong, atomic) NSString *image;
///以下没有用
@property (strong, atomic) NSString *collectProduct;
@property (strong, atomic) NSString *collectShop;
@property (strong, atomic) NSString *token;

@property (weak, nonatomic) id <UserEnterDelegate> userDelegate;

//单例实例化
+ (UserInfo *)sharedUserInfo;

//判断是否登录
+ (BOOL)isEnter;

//退出登录
+ (void)quitEnter;

//登录
- (void)startEnter:(NSDictionary *)login;

//用词典初始化
- (void)userInfoWithDictionary:(NSDictionary *)userInfo;

- (void)save;
- (void)load;
- (void)quit;

@end

@protocol UserEnterDelegate <NSObject>

@optional

- (void)UserWillBeginEnter:(UserInfo *)aInfo;

- (void)UserSuccessEnter:(NSDictionary *)successDic;

- (void)UserFailerEnter:(NSDictionary *)failerDic;

@end