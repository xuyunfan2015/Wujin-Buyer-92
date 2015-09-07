//
//  OrderViewController.m
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "AppUtil.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * orderArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"订单"];
    self.navigationBar.rightButton.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.843 green:0.843 blue:0.871 alpha:1.000];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self initHeaderViewWithTableView:self.tableView];
   
    if (!self.isFrom) {
        
        self.navigationBar.leftButton.hidden = YES;
      
        self.bottomContraint.constant = 0;
        [self.view setNeedsDisplay];
        
    }
    
    [self getOrderList];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (!self.isFrom) {
        
        self.navigationBar.leftButton.hidden = YES;
        
        self.bottomContraint.constant = 0;
        [self.view setNeedsDisplay];

    }
}

#pragma mark - 

- (void)updateInfomations {
    
    [self getOrderList];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 38;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.orderArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    NSDictionary * orderInfo = _orderArray[indexPath.row];
    
    if ([AppUtil isNotNull:[orderInfo valueForKey:@"typeNum"]]) {
        
         cell.orderIDLabel.text = [orderInfo valueForKey:@"typeNum"];
        
    }else {
        
        cell.orderIDLabel.text = @"0";
    }
    
    cell.createTimeLabel.text = [orderInfo valueForKey:@"createtime"];
    
    int state = [[orderInfo valueForKey:@"ostatus"] intValue];
    
    if (state == 1) { //待发货
        
        cell.orderStateLabel.text = @"待发货";
        
    }else if(state == 2){//已发货
        
        cell.orderStateLabel.text = @"已发货";
        
    }else if(state == 3) {//已完成
        
        cell.orderStateLabel.text = @"已完成";
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     NSDictionary* orderInfo = _orderArray[indexPath.row];
    
    if ([AppUtil isNotNull:[orderInfo valueForKey:@"typeNum"]]) {
        
        OrderDetailViewController * orderDetailVC = [self storyBoardControllerID:@"Other" WithControllerID:@"OrderDetailViewController"];
        
        orderDetailVC.hidesBottomBarWhenPushed = YES;
        
        orderDetailVC.orderInfo = orderInfo;
        
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }

}

#pragma mark - 

- (void)getOrderList {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[UserInfo sharedUserInfo]userID],@"uid",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ORDER_LIST postValueParams:params];
    
    [self showCustomIndicatorWithMessage:@"正在加载..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        [self updateFinish];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                if (!_orderArray) {
                    
                    _orderArray = [[NSMutableArray alloc] initWithCapacity:0];
                }
                
                [_orderArray removeAllObjects];
                
                if(self.type == 0) {
                    
                     [_orderArray addObjectsFromArray:[successDic valueForKey:@"shops"]];
                }else {
                    
                    for (NSDictionary * dic in [successDic valueForKey:@"shops"]) {
                        
                        
                        int state = [[dic valueForKey:@"ostatus"] intValue];
                        
                        if (state == self.type) {
                            
                            [_orderArray addObject:dic];
                        }
                        
                    }
                }
                
                [self.tableView reloadData];
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];
}

#pragma mark -

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
