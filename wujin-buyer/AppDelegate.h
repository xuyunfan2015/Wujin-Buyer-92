//
//  AppDelegate.h
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMob.h"
#import "ChatListViewController.h"
#import "CustomActivityIndicator.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate,UserEnterDelegate,UITabBarControllerDelegate>
{
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) CustomActivityIndicator *customActivityIndicator;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ChatListViewController * chatListVC;

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property (assign, nonatomic) NSInteger unRead;

- (void)aboutChat;///关于聊天

@end

