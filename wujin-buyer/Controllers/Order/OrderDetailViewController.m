//
//  OrderDetailViewController.m
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderProuctViewController.h"
#import "OrderDetailCell.h"
#import "UIView+KGViewExtend.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic)NSMutableArray * orderDetalArray;

//////////////////////////
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"订单详情"];
       self.navigationBar.rightButton.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.843 green:0.843 blue:0.871 alpha:1.000];
    
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self getOrderListDetail];
    
    int state = [[self.orderInfo valueForKey:@"ostatus"] intValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (state == 2) { //已发货发货
        
        }else{
            
            self.totalLabel.right = 310;
            [self.confirmButton setHidden:YES];
        }
    });
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.orderDetalArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell"];
    
    NSDictionary * orderInfo = _orderDetalArray[indexPath.row];
    
    NSString * imageURL = [CommentRequest getCompleteImageURLStringWithSubURL:[orderInfo valueForKey:@"cmimg"]];
    [cell.headerView setURL:imageURL defaultImage:PLACE_HORDER_IMAGE(cell.headerView)];
    
    cell.createLabel.text = [orderInfo valueForKey:@"createtime"];
    
    cell.productName.text = [orderInfo valueForKey:@"cmname"];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"价格:￥%@",[orderInfo valueForKey:@"cmprice"]];
    
    cell.numPrice.text = [NSString stringWithFormat:@"数量:%@",[orderInfo valueForKey:@"num"]];
    
    int state = [[orderInfo valueForKey:@"ostatus"] intValue];
    
    if (state == 1) { //待发货
        
        cell.orderState.text = @"待发货";
        
    }else if(state == 2){//已发货
        
        cell.orderState.text = @"已发货";
        
    }else if(state == 3) {//已完成
        
        cell.orderState.text = @"已完成";
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderProuctViewController * orderProductVC = [self storyBoardControllerID:@"Other" WithControllerID:@"OrderProuctViewController"];
    
    NSDictionary * dic = _orderDetalArray[indexPath.row];
    
    orderProductVC.orderInfo = dic;
    
    [self.navigationController pushViewController:orderProductVC animated:YES];
    
}


#pragma mark -

- (void)getOrderListDetail {
        
        NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[UserInfo sharedUserInfo]userID],@"uid",[self.orderInfo valueForKey:@"typeNum"],@"typeNum",nil];
        
        NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ORDER_DETAIL postValueParams:params];
        
        [self showCustomIndicatorWithMessage:@"正在加载..."];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [self hideCustomIndicator];
            [self updateFinish];
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                    
                    if (!_orderDetalArray) {
                        
                        _orderDetalArray = [[NSMutableArray alloc] initWithCapacity:0];
                    }
                    
                    [_orderDetalArray removeAllObjects];
                    
                    [_orderDetalArray addObjectsFromArray:[successDic valueForKey:@"shops"]];
                    
                    [self caculateMoney];
                    
                    [self.tableView reloadData];
                    
                } fail:^(NSDictionary *failDic) {
                    
                    [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
                }];
            } else {
                
            }
        }];
}

#pragma mark - Actions

- (IBAction)shouhuoAction:(id)sender {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self.orderInfo valueForKey:@"typeNum"],@"typeNum",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOUHUO_ACTION postValueParams:params];
    
    [self showCustomIndicatorWithMessage:@"正在确认..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self showAlertViewWithMessage:@"确认成功" andImage:nil];
                
                [self performSelector:@selector(confirm) withObject:nil afterDelay:1.5];
                
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];
}

- (void)confirm {
    
    PopAnimation;
}


#pragma mark -

-(void)caculateMoney{
    
    float totalMoney = 0.0;
    
    for (NSDictionary * dic in _orderDetalArray) {
        
        totalMoney = totalMoney + [[dic valueForKey:@"num"] intValue] * [[dic valueForKey:@"cmprice"] floatValue];
        
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"总价:￥%.1f",totalMoney];
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
