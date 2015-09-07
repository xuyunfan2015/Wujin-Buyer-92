//
//  MemberViewController.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import "MemberViewController.h"
#import "UIImageView+loadURL.h"
#import "UserInfo.h"
#import "CollectViewController.h"
#import "MemberInfoViewController.h"
#import "EnterViewController.h"
#import "OrderViewController.h"

@interface MemberViewController () <QuitEnterDelegate>

@property (weak, nonatomic) IBOutlet UIButton *collectShop;
@property (weak, nonatomic) IBOutlet UIButton *collectProduct;
@property (weak, nonatomic) IBOutlet UIButton *historyIndent;
@property (weak, nonatomic) IBOutlet UIButton *waitPay;
@property (weak, nonatomic) IBOutlet UIButton *waitShipments;
@property (weak, nonatomic) IBOutlet UIButton *waitAccept;
@property (weak, nonatomic) IBOutlet UIButton *VIP;

@property (weak, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UIButton *Member;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *shopCount;
@property (weak, nonatomic) IBOutlet UILabel *treasureCount;

//待宰的线条
@property (weak, nonatomic) IBOutlet UIImageView *Line;
@property (weak, nonatomic) IBOutlet UIImageView *Line1;
@property (weak, nonatomic) IBOutlet UIImageView *Line2;
@property (weak, nonatomic) IBOutlet UIImageView *Line3;
@property (weak, nonatomic) IBOutlet UIImageView *Line4;
@property (weak, nonatomic) IBOutlet UIImageView *Line5;

- (IBAction)pushProductList:(UIButton *)sender;

@end

@implementation MemberViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"MemberViewController"];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self layoutNavigationBarWithString:@"会员中心"];
     self.navigationBar.leftButton.hidden = YES;
    self.navigationBar.rightButton.hidden = YES;
    
    [self initUnreadView];
    
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    self.Line.transform  = CGAffineTransformMakeScale(1, 0.5f);
    self.Line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.Line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.Line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.Line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.Line5.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    //scrollerView限制
    self.viewWidth.constant = K_UIMAINSCREEN_WIDTH;
    self.viewHeight.constant = 410.f;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"MemberViewController"];
    
    [self loadUserInfo];
}

- (void)loadUserInfo {
    
    UserInfo *_user = [UserInfo sharedUserInfo];
    
    self.userName.text = _user.userName;
    self.shopCount.text = _user.collectShop;
    self.treasureCount.text = _user.collectProduct;
    
    if (0 != _user.image.length) {
        
        NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", hostUrl, _user.image]];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:_url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (nil == connectionError && nil != data) {
                
                UIImage *image = [UIImage imageWithData:data];
                
                [self performSelectorOnMainThread:@selector(loadImage:) withObject:image waitUntilDone:YES];
            }
        }];
    }
}

- (void)loadImage:(UIImage *)image {
    
    [self.Member setBackgroundImage:image forState:UIControlStateNormal];
    
    self.Member.layer.cornerRadius = 50;//按钮的半径
    self.Member.layer.masksToBounds = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([@"ToUserInfo" isEqualToString:segue.identifier]) {
 
        MemberInfoViewController *_member = segue.destinationViewController;
            
        _member.portrait = [self.Member backgroundImageForState:UIControlStateNormal];
        _member.quitDelegate = self;
    }
}

- (IBAction)enterUserInfo:(UIButton *)sender {

    [self performSegueWithIdentifier:@"ToUserInfo" sender:sender];
}

- (IBAction)pushProductList:(UIButton *)sender {
    
    NSLog(@"tag :%d,",sender.tag);
    
    OrderViewController * orderVC = [self storyBoardControllerID:@"Main" WithControllerID:@"OrderViewController"];
    orderVC.hidesBottomBarWhenPushed = YES;
    orderVC.isFrom = YES;
    orderVC.type = sender.tag - 100;
    [self.navigationController pushViewController:orderVC animated:YES];

}

#pragma -mark QuitEnterDelegate
- (void)quitEnter {
    
//    UINavigationController *enterNav = [self storyBoardControllerID:@"Main" WithControllerID:@"EnterNavigation"];
//    
//    [self.view.window.rootViewController presentViewController:enterNav animated:YES completion:^{
        self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
//    }];
}
@end
