//
//  NicknameViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/3/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "NicknameViewController.h"

#import "NSString+CleanStringEmpty.h"

#define kMaxLength 20

@interface NicknameViewController ()

{
    commentNetwordRequest *_commentNetword;
}

@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UIButton *changeNickname;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;

@end

@implementation NicknameViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"NicknameViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"修改昵称"];
    
    self.navigationBar.rightView.hidden = YES;
    
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    self.nickname.placeholder = self.defaultName.text;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"NicknameViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self.nickname];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.nickname];
}

- (void)textDidChange {
    
//    NSString *toBeString = self.nickname.text;
//    
//    NSString *lang = [[self.nickname textInputMode] primaryLanguage];
//    
//    if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
//        
//        UITextRange *selectedRange = [self.nickname markedTextRange];
//        
//        UITextPosition *position = [self.nickname positionFromPosition:selectedRange.start offset:0];
//        
//        if (!position){//非高亮
//            
//            const char *cString = [toBeString cStringUsingEncoding:NSUTF8StringEncoding];
//            
//            if (strlen(cString) > kMaxLength) {
//                
//                self.nickname.text = [self.nickname.text substringToIndex:kMaxLength/2];
//            }
//        }
//        
//    } else {//中文输入法以外
//        
//        const char *cString = [toBeString cStringUsingEncoding:NSUTF8StringEncoding];
//        
//        if (strlen(cString) > kMaxLength) {
//            
//            self.nickname.text = [[NSString alloc] initWithBytes:cString length:(strlen(cString) - 4) encoding:NSUTF8StringEncoding];
//        }
//    }
    if (0 != [self.nickname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length) {
        
        self.changeNickname.enabled = YES;
    } else {
        
        self.changeNickname.enabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeNickName:(id)sender {
    
    self.nickname.text = [self.nickname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
    NSString *userID = [[UserInfo sharedUserInfo] userID];

    
    [self showCustomIndicatorWithMessage:@"修改中..."];
    
    _commentNetword = [commentNetwordRequest POST:BUYER_EDITNAME_URL withParams:@{@"buyerID":userID,  @"uname":self.nickname.text} success:^(NSDictionary *successDic) {
        
        [self showAlertViewWithMessage:@"修改成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
        
        [[UserInfo sharedUserInfo] setUserName:self.nickname.text];
        
        [[UserInfo sharedUserInfo]save];
        
        self.defaultName.text = self.nickname.text;
        
        [self.navigationController popViewControllerAnimated:YES];
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];
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
