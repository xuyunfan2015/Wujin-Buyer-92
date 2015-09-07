//
//  CheckOrderViewController.m
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "CheckOrderViewController.h"
#import "PayCell.h"
#import "PayWayCell.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface CheckOrderViewController ()<PayWayCellDelegate>

@end

@implementation CheckOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"结算"];
       self.navigationBar.rightButton.hidden = YES;
     
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCell" bundle:nil] forCellReuseIdentifier:@"PayCell"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH,5)];
    view.backgroundColor = [UIColor colorWithWhite:0.919 alpha:1.000];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 80;
        
    }
    return 44;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 ) {
        
        return 1;
        
    }else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PayCell * payCell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
        payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        payCell.productPrice.text = [NSString stringWithFormat:@"￥%.1f",self.totalMoney];
        
        payCell.souldPayLabel.text = [NSString stringWithFormat:@"￥%.1f",self.totalMoney];
        
        return payCell;
        
    }else  {
        
      PayWayCell* payCell = [tableView dequeueReusableCellWithIdentifier:@"PayWayCell"];
        
        payCell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        payCell.delegate = self;
        
        payCell.index = indexPath.row;
        
       if (indexPath.row == 0) {
           
            payCell.payName.text = @"支付宝支付";
           [payCell.selectedButton setBackgroundImage:TTImage(@"check") forState:UIControlStateNormal];
        
        }else if(indexPath.row == 1) {
            
//            payCell.payName.text = @"支付宝支付";
//              [payCell.selectedButton setBackgroundImage:TTImage(@"uncheck") forState:UIControlStateNormal];
        
        }else if(indexPath.row == 2) {
            
//            payCell.payName.text = @"微信支付";
//              [payCell.selectedButton setBackgroundImage:TTImage(@"uncheck") forState:UIControlStateNormal];
        }
        
        return payCell;
    }
}

#pragma mark - Actions

- (IBAction)confirmAction:(id)sender {
    
    
    NSString *partner = @"2088021447802893";
    NSString *seller = @"huaxiaowenhua@qq.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJ60EqiSOHDYUqCJBh05600dlFT+RDDX9EbPEtyzYF0rXUX/poVF8oRnyFO3AfCLXvexX3LjKPSeGvIT+AV3G1av/foUrBJBBQmp+qrVh/xIgytvIzF5gNQSYBroACMWQaDysQrAfSXqxpmUEBunjoADNGUGWRVSkZarNuL9m3jxAgMBAAECgYEAl4m2b0P/pLDKZQOx1OJjLeVap7WKg2ERnTNI/XhCQXSQwbAU3xklMwyuGlGbBobuDXFOhLMnfjwh2pj6sK1Eaga7fDWN8owoKCimV+yl1+xo8riFYz5v67qJinF4eAzqjCdGTfRQ2ccepyd4/zmHEgKTlmtkHaHVVNOSgd/1UQkCQQDRM3fUWmC0q3TE2mLAUfvcPr9pv5/GWZfvtZIfgHrYdFmpxOIxKC4m8dtMOHdH9CA/Dqb8V9PeJZc1WVomwQ6XAkEAwjS0Xl7Eg2E69R6T0U+sfCLptCSxa9xOLry+Mq2dw1ezp0PL9sunCQ4tpo/zTQ/XiF1f2sC8826Y1SDwOPKttwJBAKnPekwv1GGy7wS/M/tiUOt1L5CaEApEPVVBcEwL0SuUPhfVDbnTIKtSFK0pBIGuguJMdXVNoVen8bZHQitE+B8CQASEHT2kjoVPmYNhtqZDaAtq9GxP/iA3+0ly8ilTiDumqnLVTMTsb3HydnVNG6dLGwP8x+HaYYp3o+4w2eU5H3kCQEvPXgBJBsy8zPG2IE5XQi4qp6dDQKPrWOgX/UGk7ClJPgi27MNwgRqMb2n4iXlrlNedC+7N+GPji3ePNcTMuCw=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = self.productName; //商品标题
    order.productDescription = self.productdetail; //商品描述
    
    order.amount = [NSString stringWithFormat:@"%.2f",self.totalMoney]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
        }];
         [self showAlertViewWithMessage:@"订单已完成" andImage:nil];
    }

   
    
    [self performSelector:@selector(popToPre) withObject:nil afterDelay:2.0];
    
 //   [self performSelectorOnMainThread:@selector(popToPre) withObject:nil waitUntilDone:YES];
}
#pragma mark - 支付宝
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#pragma mark -

- (void)navigationViewLeftButton:(UIButton *)sender {
    
    [self popToPre];
}

- (void)popToPre{
    
    NSArray * array = self.navigationController.viewControllers;
    
    NSMutableArray * viewC = [[NSMutableArray alloc] initWithArray:array];
    
    ////////////////////
    [viewC removeLastObject];
    [viewC removeLastObject];
   [viewC removeLastObject];
    
    self.navigationController.viewControllers = viewC;
    
}
#pragma mark - 

- (void)paywayCell:(PayWayCell *)paywayCell didSelectedAtIndex:(int)index {
    
    if (index == 1) {
        
        [self showAlertViewWithMessage:@"暂不支持支付宝支付" andImage:nil];
    }else if(index == 2) {
        
         [self showAlertViewWithMessage:@"暂不支持微信支付" andImage:nil];


    }
    
}

#pragma mark - Memory Manage

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
