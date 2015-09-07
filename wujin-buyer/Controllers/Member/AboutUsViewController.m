//
//  AboutUsViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/3/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AboutUsViewController.h"

#import "UMSocial.h"

@interface AboutUsViewController () <UIActionSheetDelegate, UMSocialUIDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lines;

@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCon;
@end

@implementation AboutUsViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"AboutUsViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"AboutUsViewController"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"关于我们"];
    self.navigationBar.rightView.hidden = YES;
    
    self.heightCon.constant = 490;
    self.widthCon.constant = K_UIMAINSCREEN_WIDTH;
    
    for (UIImageView *line in _lines) {
        
        line.transform = CGAffineTransformMakeScale(1.f, 0.5f);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark buttonAction
- (IBAction)callTelephone:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.telephone.text, nil];
    
    [actionSheet showInView:self.view];
    
}

#pragma -mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (0 == buttonIndex) {
        
        NSString *phoneStr = [[NSString alloc] initWithFormat:@"telprompt://%@", self.telephone.text];
        NSURL *telephoneURL = [NSURL URLWithString:phoneStr];
        
        [[UIApplication sharedApplication] openURL:telephoneURL];
    }
}

- (IBAction)sharedOurApp:(UIButton *)sender {
    
    NSString *str = @"https://itunes.apple.com/us/app/lin-qi-wang-mai-jia-ban/id966051183?l=zh&ls=1&mt=8";
//   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:U_MENG_API_KEY
                                      shareText:str
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSms,UMShareToWechatSession,nil]
                                       delegate:self];
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
