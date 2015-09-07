//
//  ForgetPasswordViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()
{
    NSTimer *_timer;
    UILabel *_timerLab;
    
    commentNetwordRequest *_networdRequest;
}

@property (weak, nonatomic) IBOutlet UIButton *sendAuth;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *authCode;

- (IBAction)sendAuthCode:(UIButton *)sender;
- (IBAction)commitToServer:(UIButton *)sender;

//线条
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;

@end

@implementation ForgetPasswordViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ForgetPasswordViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ForgetPasswordViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:@"找回密码"];
    self.navigationBar.rightButton.hidden = YES;
    
    _timerLab = [[UILabel alloc] init];
    
    _timerLab.font = [UIFont systemFontOfSize:10.f];
    _timerLab.layer.cornerRadius = 5.f;
    _timerLab.layer.masksToBounds = YES;
    _timerLab.backgroundColor = LIGHT_BLACK_COLOR;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 按钮actions

- (IBAction)sendAuthCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if ([self canSendToServer]) {
        
//        NSURLRequest *_urlRequest = [CommentRequest createGetURLWithSubURL:SEND_AUTH_URL params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNum.text, @"phone", nil]];
//
//        [NSURLConnection sendAsynchronousRequest:_urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            
//            if (nil == connectionError) {
//                
//                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
//                    
//                    self.sendAuth.enabled = NO;
//                    [self.sendAuth setTitle:@"60" forState:UIControlStateNormal];
//                    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
//                } fail:^(NSDictionary *failDic) {
//                    
//                    [self showALertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
//                }];
//            } else {
//                
//                [self showALertViewWithMessage:ERROR_SERVER andImage:nil];
//            }
//        }];
        
        [self showCustomIndicatorWithMessage:@"发送验证码中..."];
        
        NSMutableDictionary *_mutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.phoneNum.text cleanStringEmpty], @"phone", nil];
        
        _networdRequest = [commentNetwordRequest GET:SEND_AUTH_URL withParams:_mutDic success:^(NSDictionary *successDic) {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            
            _timerLab.frame = self.sendAuth.frame;
            [self.view addSubview:_timerLab];
            _timerLab.text = @"60s后可重新发送";
            _timerLab.textAlignment = NSTextAlignmentCenter;
            _timerLab.textColor = [UIColor lightGrayColor];
            self.sendAuth.userInteractionEnabled = NO;
            
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
        
        self.sendAuth.userInteractionEnabled = YES;
        
        [_timer invalidate];
        
        _timer = nil;
    } else {
        
        _timerLab.text = [[NSString alloc] initWithFormat:@"%@s后可重新发送", @(count)];
    }
}

- (IBAction)commitToServer:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
//    if ([self canSendToServer]) {
//        
//        [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
//        
//        NSURLRequest *_urlRequest = [CommentRequest createGetURLWithSubURL:FIND_URL params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNum.text, @"login_name", self.authCode.text, @"authCode", nil]];
//        
//        [NSURLConnection sendAsynchronousRequest:_urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            
//            if (nil == connectionError) {
//                
//                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
//                    
//                    [self showALertViewWithMessage:@"我们会把新密码发到你的手机" andImage:[UIImage imageNamed:@"rightAlertImage"]];
//                    [self.navigationController popViewControllerAnimated:YES];
//                } fail:^(NSDictionary *failDic) {
//                    
//                    [self showALertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
//                }];
//            } else {
//                
//                [self showALertViewWithMessage:ERROR_SERVER andImage:nil];
//            }
//        }];
//    }
    
    [self showCustomIndicatorWithMessage:@"发送中..."];
    
    if ([self canSendToServer]) {
    
        NSMutableDictionary *_mutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self.phoneNum.text cleanStringEmpty], @"login_name", [self.authCode.text cleanStringEmpty], @"authCode", nil];
        
         _networdRequest =  [commentNetwordRequest GET:FIND_URL withParams:_mutDic success:^(NSDictionary *successDic) {
            
            [self showAlertViewWithMessage:@"我们会把新密码发到你的手机" andImage:[UIImage imageNamed:@"rightAlertImage"]];
            [self popToPre];
            
         } failer:^(NSDictionary *failerDic) {
                
            [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        }];
    }
}

- (BOOL)canSendToServer {
    
    if (0 == self.phoneNum.text.length) {
        
        [self showAlertViewWithMessage:ERROR_PHONE andImage:nil];
        return NO;
    } else {
            
        return YES;
    }
}

- (void)popToPre {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (nil != _networdRequest) {
        
        [_networdRequest cancelGET];
    }
    
    if (_timer) {
        [_timer invalidate];
        
        _timer = nil;
    }
}
@end
