//
//  ConfirmOrderViewController.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved. 
//

#import "ConfirmOrderViewController.h"
#import "ChatViewController.h"
#import "MemberViewController.h"
#import "OrderAddrCell.h"
#import "OrderCarCell.h"
#import "AddCell.h"
#import "OrderCarCell.h"
#import "AppUtil.h"
#import "AddressInfo.h"
#import "commentNetwordRequest.h"
#import "CheckOrderViewController.h"
#import "SonghuoTableViewCell.h"
@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,OrderCarCellDelegate,UITextViewDelegate>
{
    AddressInfo * addressInfo;
    UITableViewCell * fillCell;
}
@property (weak, nonatomic) IBOutlet UIImageView *downLine;
@property (nonatomic,strong)NSArray *mapss;
@property (nonatomic,strong) UISwitch *isStyle;

@end

@implementation ConfirmOrderViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ConfirmOrderViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ConfirmOrderViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    [self layoutNavigationBarWithString:@"确认订单"];
     self.navigationBar.rightButton.hidden = YES;
    
    //////地址//////////////
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIView * view = [UIView new];
    self.tableView.tableFooterView = view;
    ////////////////////////////////////////////////////////////////////////
    [self caculatePrice];
   
}

-(void)viewWillAppear:(BOOL)animated {
    
    addressInfo = nil;
    [self getAddress];
}

- (IBAction)changetotlemoney:(UISwitch *)sender {
    [self caculatePrice];
}
#pragma mark - Actions

- (IBAction)sureAction:(id)sender {
    
    [self confirmOrder];
}

- (void)caculatePrice {
    
    self.freightLabel.text = @"￥0.0";
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[self caculateTotalMoney]];
}

- (float)caculateTotalMoney {
    
    if (!_shopArrays || [_shopArrays count] == 0) {
        
        return 0;
        
    }else {
        
        float totalMoney = 0.0;
        
        for (NSDictionary * dic in _shopArrays) {
            
            totalMoney = totalMoney + [[dic valueForKey:@"num"] intValue] * [[dic valueForKey:@"cmprice"] floatValue];
        }
        if (self.isStyle.isOn) {
            totalMoney+=5;
        }
        
        return totalMoney;
        
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSrouce

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
            
        return 1;
        
    }else if(section == 1){
        
        return 1;
    
    }else if(section==2){
        return 1;
    }else{
            
        return [self.shopArrays count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.section == 0) {/////地址
            
            if (addressInfo) {//有收货地址

                OrderAddrCell * orderAddr = [tableView dequeueReusableCellWithIdentifier:@"OrderAddrCell"];
                
                orderAddr.backgroundColor = [UIColor clearColor];
                
                orderAddr.selectionStyle = UITableViewCellSelectionStyleNone;
                
                orderAddr.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",addressInfo.address,addressInfo.detailAddress];
                
                orderAddr.telLabel.text = addressInfo.telephone;
                
                orderAddr.nameLabel.text = addressInfo.name;
                
                return orderAddr;
                
            }else {
                
                UITableViewCell * addAdrr = [tableView dequeueReusableCellWithIdentifier:@"AddAddrCell"];
                return addAdrr;
            }
         
        }else if(indexPath.section == 1){
            
            if (fillCell) {
                
                return fillCell;
            }
            
            fillCell = [tableView dequeueReusableCellWithIdentifier:@"fillCell"];
            
            if (!fillCell) {
                
               fillCell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fillCell"];
               
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
                label.font = [UIFont systemFontOfSize:15];
                label.text = @"备注";
                [fillCell.contentView addSubview:label];
                
                UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 10, K_UIMAINSCREEN_WIDTH - 60 - 10, 100 - 20)];
                [AppUtil setBorderWithColorWithView:textView color:[UIColor colorWithWhite:0.901 alpha:1.000] width:1];
                textView.delegate = self;
                textView.tag = 9000;
                [fillCell.contentView addSubview:textView];
            }
            return fillCell;
            
        }else  if(indexPath.section==2){
           
            SonghuoTableViewCell * orderAddr = [tableView dequeueReusableCellWithIdentifier:@"SonghuoTableViewCell"];
            self.isStyle=orderAddr.songhuosty;
            
            orderAddr.backgroundColor = [UIColor clearColor];
            
            orderAddr.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            return orderAddr;

        
        }
    
    else{
        
            NSDictionary * shopDic = _shopArrays[indexPath.row];
                
            OrderCarCell  * orderShopCell = [tableView dequeueReusableCellWithIdentifier:@"OrderCarCell"];
            orderShopCell.index = indexPath.row;
            
            NSString * completeImg = [CommentRequest getCompleteImageURLStringWithSubURL:[shopDic valueForKey:@"cmimg"]];
            [orderShopCell.productIcon setURL:completeImg defaultImage:PLACE_HORDER_IMAGE(orderShopCell.productIcon)];
            
            orderShopCell.delegate = self;
            
            orderShopCell.productName.text =  [shopDic valueForKey:@"cmname"];
            
            orderShopCell.productNumbers.text = [NSString stringWithFormat:@"数量:%@",[shopDic valueForKey:@"num"]];
            
           orderShopCell.mNumberLabel.text = [NSString stringWithFormat:@"%@",[shopDic valueForKey:@"num"]];
                        
             orderShopCell.productPrice.text = [NSString stringWithFormat:@"价格:￥%@",[shopDic valueForKey:@"cmprice"]];
            
             orderShopCell.createLabel.text = [NSString stringWithFormat:@"创建时间:%@",[shopDic valueForKey:@"createtime"]];
            
            orderShopCell.shopName.text = [NSString stringWithFormat:@"店铺名:%@",[shopDic valueForKey:@"sname"]];
            
            orderShopCell.shopAddress.text = [NSString stringWithFormat:@"店铺地址:%@",[shopDic valueForKey:@"saddress"]];
            orderShopCell.selectionStyle = UITableViewCellSelectionStyleNone;

            return orderShopCell;
            
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        [self selectAddressInfo];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 90;
   
    }else if (indexPath.section == 1){
        
        return 100;
        
    }else  if(indexPath.section==2){
        return 40;
    }
    
    else{
        
        return 130;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

#pragma mark - AddCellDelegate

- (void)showHintWithMsg:(NSString *)msg {
    
    [self showAlertViewWithMessage:msg andImage:nil];
}

#pragma mark - 确认订单

- (void)confirmOrder {
   
    if ([CommentRequest networkStatus]) {
        
        if (!addressInfo) {
            
             [self showAlertViewWithMessage:@"请选择收货地址" andImage:nil];
            
            return;
        }
        
        if (![self isEnterServer]) {
            
            return;
        }
        
        for (NSDictionary * dic in self.shopArrays) {
            
            NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
            [params setValue:@(self.shopArrays.count) forKey:@"typeNum"];
            [params setValue:[[UserInfo sharedUserInfo]userID] forKey:@"uid"];
            [params setValue:[dic valueForKey:@"orderid"] forKey:@"orderid"];
            
            UITextView * textView = (UITextView *)[fillCell viewWithTag:9000];
            [params setValue:textView.text forKey:@"ramerk"];
            
            [commentNetwordRequest POST:BUY_URL withParams:params success:^(NSDictionary *successDic) {
                
                NSLog(@"购买成功");
                
            } failer:^(NSDictionary *failerDic) {
                
                [self showAlertViewWithMessage:@"失败" andImage:nil];
                
            }];
        
        }
        
        CheckOrderViewController * checkOrderVC = [self storyBoardControllerID:@"Other" WithControllerID:@"CheckOrderViewController"];
        checkOrderVC.totalMoney = [self caculateTotalMoney];
        checkOrderVC.productName=self.shopid;
        checkOrderVC.productdetail=self.mapss;
        [self.navigationController pushViewController:checkOrderVC animated:YES];
   }
}

#pragma mark - 获取默认地址

- (void)getAddress {

    [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
    
     NSMutableDictionary *  params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[UserInfo sharedUserInfo] userID], @"uid", nil];
    
      [commentNetwordRequest POST:ADDRESS_GET_URL withParams:params success:^(NSDictionary *successDic) {
          
          [self hideCustomIndicator];
          
          [self loadAddressInfo:successDic[@"mapss"]];
          self.mapss=successDic[@"mapss"];
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        
        }];
}

//加载信息
- (void)loadAddressInfo:(NSArray *)addressArray {
    
    for (NSDictionary *dic in addressArray) {
        
        AddressInfo * address = [AddressInfo addressInfoAtOrderWithDictionary:dic];
       
        if ([address.isDefault intValue] == 1) {
            
            addressInfo = address;
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
            return;
        }
    }
}

#pragma mark - OrderCarDelegate


- (void)orderCarCell:(OrderCarCell *)orderCarCell subAtIndex:(int)index {
    
    NSDictionary  * carInfo = self.shopArrays[index];
    
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [carInfo valueForKey:@"cmid"];
    NSString * sid = [carInfo valueForKey:@"sid"];
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sid,@"shopid",cmid,@"cmid",uid,@"uid",@"1",@"num", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:CAR_SUB postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self getCarInfomations];
                
            } fail:^(NSDictionary *failDic) {
                
            }];
            
        } else {
            
        }
    }];
    
}

- (void)orderCarCell:(OrderCarCell *)orderCarCell addAtIndex:(int)index {
    
    NSDictionary * carInfo = self.shopArrays[index];
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [carInfo valueForKey:@"cmid"];
    NSString * sid = [carInfo valueForKey:@"sid"];
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sid,@"shopid",cmid,@"cmid",uid,@"uid",@"1",@"num", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ADD_TO_CAR postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self getCarInfomations];
                
            } fail:^(NSDictionary *failDic) {
                
            }];
            
        } else {
            
        }
    }];
    
}


#pragma mark - 获取购物车信息

- (void)getCarInfomations {
    
    NSString * userID = [[UserInfo sharedUserInfo] userID];
    
    if ([AppUtil isNull:userID]) {
        
        return;
    }
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userID,@"uid",self.shopid,@"shopid", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:CAR_LIST postValueParams:params];
    
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [_shopArrays removeAllObjects];
                
                [_shopArrays addObjectsFromArray: [successDic valueForKey:@"coms"]];;
                
                [self.tableView reloadData];
                
                [self caculatePrice];
                
            } fail:^(NSDictionary *failDic) {
                
            }];
        }
    }];
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
