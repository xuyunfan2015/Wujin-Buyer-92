//
//  FeedbackViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/3/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController () <UITextViewDelegate>
{
    commentNetwordRequest *_commentNetword;
}

@property (weak, nonatomic) IBOutlet UITextView *suggest;
@property (weak, nonatomic) IBOutlet UIButton *commitSuggest;
@end

@implementation FeedbackViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
    [MobClick beginLogPageView:@"FeedbackViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"FeedbackViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.suggest.layer.cornerRadius = 2.0f;
    
    [self layoutNavigationBarWithString:@"提交建议"];
    self.navigationBar.rightView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    if (_commentNetword) {
        [_commentNetword cancelGET];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitYourSuggest:(UIButton *)sender {
    
    NSString *userID = [[UserInfo sharedUserInfo] userID];
    
    _commentNetword = [commentNetwordRequest POST:COMMIT_SUGGEST_URL withParams:@{ @"uid":userID, @"content":[self.suggest.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]} success:^(NSDictionary *successDic) {
        
        [self showAlertViewWithMessage:@"感谢您的建议" andImage:[UIImage imageNamed:@"rightAlertImage"]];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];
}

- (void)textDidChange {
    
    if (0 != [self.suggest.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]) {
        
        self.commitSuggest.enabled = YES;
    } else {
        
        self.commitSuggest.enabled = NO;
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
