//
//  ChangePasswordViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/3/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ChangePasswordViewController.h"

#import "WJKeychain.h"

@interface ChangePasswordViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UILabel *errInfo;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;
@property (weak, nonatomic) IBOutlet UIImageView *line5;
@property (weak, nonatomic) IBOutlet UIImageView *line6;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"修改密码"];
    
    self.navigationBar.rightView.hidden = YES;
    
    self.line1.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    self.line5.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    self.line6.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ChangePasswordViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ChangePasswordViewController"];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePassword:(UIButton *)sender {
    
    if ([self.password.text isEqualToString:self.repeatPassword.text]) {
        
        [self showCustomIndicatorWithMessage:@"修改密码中..."];
        
        self.password.text = [self.password.text cleanStringEmpty];
        
        NSMutableDictionary *userNamePasswordPairs = [WJKeychain load:KEY_USERNAME_PASSWORD];
        NSString *name = [userNamePasswordPairs objectForKey:KEY_USERNAME];

        NSDictionary *params = @{@"mobile":name, @"newpwd":(self.password.text),@"newpwd1":self.password.text};
        
        [commentNetwordRequest POST:ALT_URL withParams:params success:^(NSDictionary *successDic) {
            
            [self showAlertViewWithMessage:@"修改密码成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            NSMutableDictionary *chain = [NSMutableDictionary dictionaryWithCapacity:2];
    
            [chain setValue:[[UserInfo sharedUserInfo] userName] forKey:KEY_USERNAME];
            [chain setValue:self.password.text forKey:KEY_PASSWORD];
            
            [WJKeychain save:KEY_USERNAME_PASSWORD data:chain];
            
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
        }];
        
    } else {
        
        self.errInfo.hidden = NO;
        
        [UIView animateWithDuration:1.0f animations:^{
            
            self.errInfo.alpha = 0.1;
        } completion:^(BOOL finished) {
            
            self.errInfo.alpha = 1.0f;
            self.errInfo.hidden = YES;
        }];
    }
}

- (void)textDidChange {
    
    if ([self judgeCanSend]) {
        
        self.changeButton.enabled = YES;
    } else {
        
        self.changeButton.enabled = NO;
    }
}

- (BOOL)judgeCanSend {
    
    return  6 <= self.password.text.length && 6 <= self.repeatPassword.text.length;
}

#pragma -mark UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.oldPassword) {
        
        [self.password becomeFirstResponder];
        return YES;
    } else if (textField == self.password) {
        
        [self.repeatPassword becomeFirstResponder];
        return YES;
    } else {
        
        if ([self judgeCanSend]) {
            
            [textField endEditing:YES];
            [self changePassword:nil];
            return YES;
        } else
            return NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
