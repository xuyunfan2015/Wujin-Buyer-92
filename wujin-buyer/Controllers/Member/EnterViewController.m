//
//  EnterViewController.m
//  wujin-buyer
//
//  Created by wujin on 15/1/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <Security/Security.h>
#import "EnterViewController.h"
#import "NSString+base64.h"
#import "NSString+MD5.h"
#import "UserInfo.h"
#import "MemberViewController.h"
#import "EaseMob.h"
#import "WJKeychain.h"

@interface EnterViewController () <UserEnterDelegate>
{
    NSTimer *_timer;
    UILabel *_timerLab;
    commentNetwordRequest *_networdRequest;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *authCode;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

//线条
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;

@end

@implementation EnterViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"EnterViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"EnterViewController"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:@"登录"];
    
    //先请掉图片
    [self.navigationBar.rightButton setImage:nil forState:UIControlStateNormal];
  //  [self.navigationBar.rightButton setTitle:@"注册" forState:UIControlStateNormal];
    
    self.navigationBar.widthCo.constant = self.navigationBar.widthCo.constant + 5;

    [self.navigationBar.leftButton setImage:nil forState:UIControlStateNormal];
    [self.navigationBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    
    if (self.isFromMember) {
        
        self.navigationBar.leftButton.hidden = YES;
    }
    
     _timerLab = [[UILabel alloc] init];
    _timerLab.font = [UIFont systemFontOfSize:10.f];
    _timerLab.layer.cornerRadius = 5.f;
    _timerLab.layer.masksToBounds = YES;
    _timerLab.backgroundColor = LIGHT_BLACK_COLOR;
}

- (IBAction)sendCode:(id)sender {
    
    [self.view endEditing:YES];
    
    if ([self canSendToServer]) {
        
        [self showCustomIndicatorWithMessage:@"发送验证码中..."];
        
        NSMutableDictionary *_mutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.phoneNum.text cleanStringEmpty], @"mobile", nil];
        
        _networdRequest = [commentNetwordRequest POST:AUTH_CODE withParams:_mutDic success:^(NSDictionary *successDic) {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            
            _timerLab.frame = self.sendButton.frame;
            [self.view addSubview:_timerLab];
            _timerLab.text = @"60s后可重新发送";
            _timerLab.textAlignment = NSTextAlignmentCenter;
            _timerLab.textColor = [UIColor lightGrayColor];
            self.sendButton.userInteractionEnabled = NO;
            
             [self.sendButton setTitle:@"" forState:UIControlStateNormal];
            
            [self showAlertViewWithMessage:@"发送验证码成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
            
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        }];
    }
}

- (void)updateTime {
    
    static NSInteger count = 60;
    
    --count;
    
    if (0 == count) {
        
        count = 60;
        
        [_timerLab removeFromSuperview];
        
        self.sendButton.userInteractionEnabled = YES;
        
        [self.sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
        [_timer invalidate];
        
        _timer = nil;
        
    } else {
        
        _timerLab.text = [[NSString alloc] initWithFormat:@"%@s后可重新发送", @(count)];
    }
}


#pragma -mark Touches代理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma -mark 按键行为
//登录
- (IBAction)easeEnter {
    
    [self.view endEditing:YES];
    
    if ([UserInfo isEnter]) {
        
        [self navigationViewLeftButton:nil];
        
        [self showAlertViewWithMessage:@"登录成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
        
        return;
    }
    
    if ([self canSendToServer]) {
        
        UserInfo *_user = [UserInfo sharedUserInfo];
        
         _user.userDelegate = self;
        
        [_user startEnter: [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.authCode.text cleanStringEmpty], @"sours",
                                                                             [self.phoneNum.text cleanStringEmpty], @"mobile", nil]];
    }
}

#pragma -mark UserEnterDelegate代理方法

- (void)UserWillBeginEnter:(UserInfo *)aInfo {
    
    [self showCustomIndicatorWithMessage:ENTER_MESSAGE];
}

- (void)UserSuccessEnter:(NSDictionary *)successDic {
    
    /**用户信息存储***/
    [[NSUserDefaults standardUserDefaults]setObject:successDic forKey:@"myUserInfo"];
    
    [self showAlertViewWithMessage:@"登录成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    //保存密码
//    NSMutableDictionary *userNamePassPairs = [NSMutableDictionary dictionary];
//    [userNamePassPairs setObject:[self.phoneNum.text cleanStringEmpty] forKey:KEY_USERNAME];
//    [userNamePassPairs setObject:[self.password.text cleanStringEmpty] forKey:KEY_PASSWORD];
//    [WJKeychain save:KEY_USERNAME_PASSWORD data:userNamePassPairs];
}

- (void)UserFailerEnter:(NSDictionary *)failerDic {
    
    [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
}
//判断是否可以连接网络
- (BOOL)canSendToServer {
    return YES;
}

#pragma -mark CustomNavigationViewDelegate

- (void)navigationViewRightButton:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"ToRegister" sender:sender];
}

- (void)navigationViewLeftButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
