//
//  AppDelegate.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfo.h"
#import "WJKeychain.h"
#import "EaseMob.h"
#import "UMessage.h"

#import "UMSocial.h"
#import "MobClick.h"
#import "UserInfo.h"
#import "AppUtil.h"
#import "CustomAlertView.h"
#import <AlipaySDK/AlipaySDK.h>
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initChatList];
    
    [[UserInfo sharedUserInfo]load];
    
   // [self easeMobSetting:application andDictionary:launchOptions];///环信
    
    [self BMKSetting:application andDictionary:launchOptions];
    
    [self UMSetting:application andDictionary:launchOptions];
    
    [self registerRemoteNotification];
    
    [self registerStatistics];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginFromOtherDevice) name:K_OFFLNE_NOTIICATION object:nil];
    
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self aboutChat];
    
    return YES;
}

- (void)registerUserDefaults {
    
    NSUserDefaults *_user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *_dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"FirstEnter", nil];
    
    [_user registerDefaults:_dic];
    
    [_user synchronize];
}

- (void)registerStatistics {

    [MobClick startWithAppkey:U_MENG_API_KEY reportPolicy:BATCH   channelId:@"App Store"];
}

- (void)initChatList {
    
    _chatListVC = [[ChatListViewController alloc] init];
    _chatListVC.hidesBottomBarWhenPushed = YES;
}

//友盟推送
- (void)UMSetting:(UIApplication *)application andDictionary:(NSDictionary *)launchOptions {
    
    [UMessage startWithAppkey:U_MENG_API_KEY launchOptions:launchOptions];
    
    [UMessage setLogEnabled:NO];
    
    [UMSocialData setAppKey:U_MENG_API_KEY];
}

//百度地图
- (void)BMKSetting:(UIApplication *)application andDictionary:(NSDictionary *)launchOptions {
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDU_API_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

//环信
- (void)easeMobSetting:(UIApplication *)application andDictionary:(NSDictionary *)launchOptions {
    
    
#pragma -mark  SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
        NSString *apnsCertName = nil;
    #if DEBUG
        apnsCertName = @"tfBuyer-apns-dev";
    #else
        apnsCertName = @"tfBuyer-apns-pro";
    #endif
        [[EaseMob sharedInstance] registerSDKWithAppKey:@"963258#xmb" apnsCertName:apnsCertName];
    
    #if DEBUG
        [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
    #endif
        [[[EaseMob sharedInstance] chatManager] setIsAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#pragma -mark 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    [self easeEnter];
}

//注册远程通知
- (void)registerRemoteNotification {
#if !TARGET_IPHONE_SIMULATOR
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
       
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }else {
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    }
  
#endif
    
}

//调用SDK消息推送的一些方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    [UMessage registerDeviceToken:deviceToken];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
    
    //友盟
    if (UIApplicationStateActive != [UIApplication sharedApplication].applicationState) {

        [UMessage didReceiveRemoteNotification:userInfo];
   
    } else {

        [[[UIAlertView alloc] initWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //NSLog(@"error--%@", error);
    
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[EaseMob sharedInstance] applicationWillResignActive:application];
    
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    
    [BMKMapView didForeGround];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

//登录
- (void)easeEnter {
    
    if ([[UserInfo sharedUserInfo] userID]) {
        
        if ([CommentRequest networkStatus]) {
            
            NSMutableDictionary *userNamePasswordPairs = [WJKeychain load:KEY_USERNAME_PASSWORD];
            NSString *name = [userNamePasswordPairs objectForKey:KEY_USERNAME];
            NSString *password = [userNamePasswordPairs objectForKey:KEY_PASSWORD];
            
            NSDictionary *_login = [NSDictionary dictionaryWithObjectsAndKeys:name, @"mobile", password, @"pwd", nil];
            
            [[UserInfo sharedUserInfo] startEnter:_login];
        }
   }
}

//app回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return  YES;
}

#pragma mark - 环信相关

- (void)aboutChat {

    if ([[EaseMob sharedInstance].chatManager isLoggedIn]) {
        
        ////////聊天相关/////////
        [self didUnreadMessagesCountChanged];
        
#pragma mark - 把self注册为SDK的delegate
        [self registerNotifications];
        
        [self setupUnreadMessageCount];
        
    }
}
//////////////////////////////////////////////////////
////////////////////////聊天模块///////////////////////////////

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications {
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
   
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    
    self.unRead = unreadCount;
}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [_chatListVC refreshDataSource];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    [self setupUnreadMessageCount];
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbing) {
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                //        NSInteger minute= [components minute];
                
                NSUInteger startH = options.noDisturbingStartH;
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24;
                }
                
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0);
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversation.chatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }
#endif
    }
}

- (void)playSoundAndVibration{
    
    //如果距离上次响铃和震动时间太短, 则跳过响铃
    //NSLog(@"%@, %@", [NSDate date], self.lastPlaySoundDate);
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.soundName = @"default";
    
    /*UILocalNotification *notification=[[UILocalNotification alloc] init];
     
     if (notification != nil) {
     
     NSDate *now=[NSDate new];
     
     notification.fireDate=[now dateByAddingTimeInterval:15];
     
     notification.timeZone=[NSTimeZone defaultTimeZone];
     
     notification.alertBody=@"定时推送通知！";
     
     notification.soundName = @"default";
     
     [notification setApplicationIconBadgeNumber:22];
     
     [[UIApplication sharedApplication] scheduleLocalNotification:notification];
     
     }*/
    
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversation.chatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }
    
#pragma mark - 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //   notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
       
        NSString *hintText = @"你的账号登录失败，正在重试中... \n点击 '登出' 按钮跳转到登录页面 \n点击 '继续等待' 按钮等待重连成功";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"继续等待"
                                                  otherButtonTitles:@"登出",
                                  nil];
        alertView.tag = 99;
        
        [alertView show];
    }
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下线通知"
                                                            message:@"您的账号已在其他设备上登录"
                                                           delegate:self
                                                  cancelButtonTitle:@"退出"
                                                  otherButtonTitles:@"重新登录",
                                  nil];
        alertView.tag = 102;
        
        [alertView show];
        
    } onQueue:nil];
}

- (void)didRemovedFromServer {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下线通知"
                                                            message:@"您的账号已被服务器端移除"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 101;
        
        [alertView show];
        
    } onQueue:nil];
}

- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    [_chatListVC networkChanged:connectionState];
}

#pragma mark -

- (void)willAutoReconnect{
    
    NSLog(@"正在重连中...");
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    
    if (error) {
        
        NSLog(@"重连失败，稍候将继续重连");
        
    }else{
       
        NSLog(@"重连成功！");
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 101) {
     
        [UserInfo quitEnter];///被T
        
        UITabBarController *tabbarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarController"];
        
        self.window.rootViewController = tabbarController;
        
    }else {
        
        if (buttonIndex == 0) {
            
            [UserInfo quitEnter];///被T
            
            UITabBarController *tabbarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarController"];
            self.window.rootViewController = tabbarController;
            
        }
        else {
            
            [self easeEnterForReLogin];
        }
    }
}

//登录
- (void)easeEnterForReLogin {
    
    if ([CommentRequest networkStatus]) {
        
        NSMutableDictionary *userNamePasswordPairs = [WJKeychain load:KEY_USERNAME_PASSWORD];
        NSString *name = [userNamePasswordPairs objectForKey:KEY_USERNAME];
        NSString *password = [userNamePasswordPairs objectForKey:KEY_PASSWORD];
        
        NSDictionary *_login = [NSDictionary dictionaryWithObjectsAndKeys:name, @"mobile", password, @"pwd", nil];
        
        [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
            
            [UserInfo sharedUserInfo].userID = @"";
            [UserInfo sharedUserInfo].userDelegate = self;
            [[UserInfo sharedUserInfo] startEnter:_login];
            
        } onQueue:nil];

    }else {
        
        [self showAlertViewWithMessage:@"无法连接服务器" andImage:nil];
    }
}

/**
 显示一个一秒的警告
 */
- (void)showAlertViewWithMessage:(NSString *)message andImage:(UIImage*)image {
    
    if (nil == image) {
        
        image = [UIImage imageNamed:@"whiteAlertImage"];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", message, @"message", nil];
    
    [self performSelectorOnMainThread:@selector(showCustomAlert:) withObject:dic waitUntilDone:YES];
}

/**
 隐藏菊花
 */
- (void)hideCustomIndicator {
    
    [_customActivityIndicator removeFromSuperview];
    _customActivityIndicator = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)showCustomAlert:(NSDictionary *)dic {
    
    [self hideCustomIndicator];//菊花隐藏起来吧。。。。
    
    CustomAlertView *alert = [CustomAlertView customAlertViewWithMessage:dic[@"message"] andImage:dic[@"image"]];
    
    alert.center = CGPointMake(K_UIMAINSCREEN_WIDTH/2, K_UIMAINSCREEN_HEIGHT/2);
    
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:alert];
    
    [self performSelector:@selector(removeCustomAlert:) withObject:alert afterDelay:1.f];
}

- (void)removeCustomAlert:(CustomAlertView *)alertView {
    
    if (nil != alertView) {
        
        [UIView animateWithDuration:1.5f animations:^{
            
            alertView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [alertView removeFromSuperview];
        }];
    }
}

#pragma mark - UserEnterDelegate

- (void)UserWillBeginEnter:(UserInfo *)aInfo {
    
    [AppUtil showHudInView:self.window.rootViewController.view msg:@"正在登录..." tag:20000];
}

- (void)UserSuccessEnter:(NSDictionary *)successDic {
    
    [AppUtil hideHudInView:self.window.rootViewController.view mtag:20000];
    
    [self showAlertViewWithMessage:@"登录成功" andImage:TTImage(@"rightAlertImage")];
}

- (void)UserFailerEnter:(NSDictionary *)failerDic {
  
    [AppUtil hideHudInView:self.window.rootViewController.view mtag:20000];
    
    [self showAlertViewWithMessage:@"登录失败" andImage:nil];

}

//#pragma mark - UITabbarControllerDelegate
//
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        
//        UINavigationController * nav = (UINavigationController *)viewController;
//        
//        [nav popToRootViewControllerAnimated:NO];
//    }
//    
//    return YES;
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    
//    
//}

#pragma mark - dealloc

- (void)dealloc
{
    [self unregisterNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:K_OFFLNE_NOTIICATION object:nil];
}

@end
