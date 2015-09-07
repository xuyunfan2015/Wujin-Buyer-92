//
//  RegisterViewController.m
//  wujin-buyer
//
//  Created by wujin on 15/1/4.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserInfo.h"
#import "WJKeychain.h"
#import "NSString+CleanStringEmpty.h"

@interface RegisterViewController () <UITextFieldDelegate>
{
    NSMutableArray *_textFields;
    NSString *_subURL;
    NSMutableDictionary *_params;
    
    //计时器
    NSTimer *_timer;
    UILabel *_timerLab;
    
    commentNetwordRequest *_networdRequest;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UITextField *authCode;
@property (weak, nonatomic) IBOutlet UIButton *commitParams;
@property (weak, nonatomic) IBOutlet UIButton *sendAuth;
@property (weak, nonatomic) IBOutlet UIButton *select;

- (IBAction)sendAuthCode:(UIButton *)sender;
- (IBAction)registerAcc:(UIButton *)sender;

//线条
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;
@property (weak, nonatomic) IBOutlet UIImageView *line5;
@property (weak, nonatomic) IBOutlet UIImageView *line6;
@property (weak, nonatomic) IBOutlet UIImageView *line7;
@property (weak, nonatomic) IBOutlet UIImageView *line8;

@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    keyboardView = self.myView;
    
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line5.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line6.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line7.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line8.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    _textFields = [NSMutableArray arrayWithObjects:self.phoneNum, self.password, self.passwordAgain, self.authCode, nil];
    
    _timerLab = [[UILabel alloc] init];
    
    _timerLab.font = [UIFont systemFontOfSize:10.f];
    _timerLab.layer.cornerRadius = 5.f;
    _timerLab.layer.masksToBounds = YES;
    _timerLab.backgroundColor = LIGHT_BLACK_COLOR;
    
    [self loadStatus];
    // Do any additional setup after loading the view.
}

- (void)loadStatus {
    
    _subURL = REG_URL;
    
    [self layoutNavigationBarWithString:@"注册"];
    self.navigationBar.rightButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"RegisterViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma -mark 按键行为
- (IBAction)sendAuthCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (0 != self.phoneNum.text.length) {
        
        [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
        
        NSMutableDictionary *_mutDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNum.text, @"mobile", nil];
        
        _networdRequest = [commentNetwordRequest POST:AUTH_CODE withParams:_mutDic success:^(NSDictionary *successDic) {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            
            _timerLab.frame = self.sendAuth.frame;
            [self.myView addSubview:_timerLab];
            _timerLab.text = @"60秒后重新发送";
            _timerLab.textAlignment = NSTextAlignmentCenter;
            _timerLab.textColor = [UIColor lightGrayColor];
            self.sendAuth.userInteractionEnabled = NO;
            
            [self showAlertViewWithMessage:@"发送验证码成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        }];

    } else {
        
        [self showAlertViewWithMessage:ERROR_PHONE andImage:nil];
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
        
        _timerLab.text = [[NSString alloc] initWithFormat:@"%@秒后重新发送", @(count)];
    }
}

//注册账号按钮
- (IBAction)registerAcc:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self canSendToServer]) {
        [self showCustomIndicatorWithMessage:UPLOAD_MESSAGE]; //菊花显示出来啦。
       

//            _params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[UserInfo sharedUserInfo] userID], @"buyer_id", self.phoneNum.text, @"login_name", self.password.text, @"new_passwd", self.authCode.text, @"authCode", nil];
   
        _params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.phoneNum.text,@"mobile",self.password.text,@"pwd",self.passwordAgain.text,@"pwd1", self.authCode.text, @"sours", nil];
        
        [self sendToServer:_params];
    }
}

//判断是否可以连接服务器
- (BOOL)canSendToServer {
    
    NSString *message;
    
    if (0 == self.phoneNum.text.length) {
        
        message = @"手机号码不能为空";
    } else if (![self.password.text isEqualToString:self.passwordAgain.text]) {
        
        message = @"两次密码输入不一致";
    } else if (0 == self.password.text.length || 0 == self.passwordAgain.text.length) {
        
        message = @"密码不能为空";
    } else if (0 == self.authCode.text.length) {
        
        message = @"验证码不能为空";
    } else //if ([self isALterPassword]) {
//        
//        NSDictionary *enterInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"enterInfo"];
//    
//        if ([enterInfo[@"login_pass"] isEqualToString: self.password.text]) {
//            
//            message = @"不能跟原密码相同";
//        }
//    }
    
    if (nil != message) {
        
        [self showAlertViewWithMessage:message andImage:nil];
        return NO;
    }
    
    return YES;
}

//发送请求到服务器
- (void)sendToServer:(NSMutableDictionary *)params {
    
    if ([self canSendToServer]) {
        
        _networdRequest = [commentNetwordRequest POST:REGISTER_URL withParams:_params success:^(NSDictionary *successDic) {
            
            [self showAlertViewWithMessage:@"注册成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
            
            [self popToPre];
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
        }];
    }

}

#pragma -mark textfield代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSUInteger index = [_textFields indexOfObject:textField];
    if (3 != index) {
        
        [_textFields[++index] becomeFirstResponder];
    } else {
        
        [self performSelector:@selector(registerAcc:) withObject:nil];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textFrame = textField.frame;
    
    if (first) {
        //
        first = NO;
    } else {
        //
        
        [self keyboardWillShow:myNotification];
    }
}

- (void)popToPre {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//注册键盘弹出事件
- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"RegisterViewController"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    if (nil != _networdRequest) {
        
        [_networdRequest cancelGET];
    }
    
    if (_timer) {
        [_timer invalidate]; _timer = nil;
    }
}

- (IBAction)LinQiServiceContract:(UIButton *)sender {
    
    [self.navigationController pushViewController:[self storyBoardControllerID:@"Main" WithControllerID:@"LinQiServiceContract"] animated:YES];
}

- (IBAction)acceptService:(UIButton *)sender {
    
    if (1 == sender.tag) {
        
        sender.tag = 2;
        [sender setImage:[UIImage imageNamed:@"register_confirm_user_agreement_che1"] forState:UIControlStateNormal];
    } else {
        
        sender.tag = 1;
        [sender setImage:[UIImage imageNamed:@"register_confirm_user_agreement_che"] forState:UIControlStateNormal];
    }
    
    [self textDidChange];
}

- (void)textDidChange {
    
    if ([self judgeTextIsEmpty]) {
        
        self.commitParams.enabled = NO;
    } else {
        
        self.commitParams.enabled = YES;
    }
}

- (BOOL)judgeTextIsEmpty {
    
    return 0 == [self.phoneNum.text cleanStringEmpty].length || 6 > [self.password.text cleanStringEmpty].length || 6 > [self.passwordAgain.text cleanStringEmpty].length || 0 == [self.authCode.text cleanStringEmpty].length || 2 == self.select.tag;
}

@end
