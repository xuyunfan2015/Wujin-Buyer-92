//
//  OrderProuctViewController.m
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "OrderProuctViewController.h"
#import "PayCell.h"
#import "WTURLImageView.h"

@interface OrderProuctViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation OrderProuctViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"订单详情"];
       self.navigationBar.rightButton.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.843 green:0.843 blue:0.871 alpha:1.000];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCell" bundle:nil] forCellReuseIdentifier:@"PayCell"];
    self.tableView.tableFooterView = [UIView new];
    [self initHeaderViewWithTableView:self.tableView];

}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        
        return 0;
    }
    
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        
        return nil;
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH,5)];
    view.backgroundColor = [UIColor colorWithWhite:0.919 alpha:1.000];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 50;
   
    }else if (indexPath.section == 1) {
      
        if (indexPath.row == 0) {
            
            return 50;
        
        }else if (indexPath.row == 1){
            
            return 80;
            
        }else {
            
            return 44;
        }
        
    }else if (indexPath.section == 2) {
        
        return 44;
        
    }else {
        
        return 140;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1 ) {
        
        return 3;
        
    }else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderStateCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        UILabel * orderStateLabel = (UILabel *)[cell viewWithTag:100];
        
        int state = [[self.orderInfo valueForKey:@"ostatus"] intValue];
        
        if (state == 1) { //待发货
            
            orderStateLabel.text = @"待发货";
            
        }else if(state == 2){//已发货
            
            orderStateLabel.text = @"已发货";
            
        }else if(state == 3) {//已完成
            
            orderStateLabel.text = @"已完成";

        }
        return cell;
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            UITableViewCell * orderProductCell = [tableView dequeueReusableCellWithIdentifier:@"OProductCell"];
              orderProductCell.selectionStyle = UITableViewCellSelectionStyleNone;
            WTURLImageView * iView = (WTURLImageView *)[orderProductCell viewWithTag:100];
            NSString * imageURL = [CommentRequest getCompleteImageURLStringWithSubURL:[self.orderInfo valueForKey:@"cmimg"]];
            [iView setURL:imageURL defaultImage:PLACE_HORDER_IMAGE(iView)];
    

            UILabel * productName = (UILabel *)[orderProductCell viewWithTag:101];
            productName.text = [self.orderInfo valueForKey:@"cmname"];
        
            
            UILabel * price = (UILabel *)[orderProductCell viewWithTag:102];
            price.text = [NSString stringWithFormat:@"￥%@",[self.orderInfo valueForKey:@"cmprice"]];
            
            UILabel * countLabel = (UILabel *)[orderProductCell viewWithTag:103];
             countLabel.text = [NSString stringWithFormat:@"x%@",[self.orderInfo valueForKey:@"num"]];
            
            return orderProductCell;
            
        }else if(indexPath.row == 1) {
            
            PayCell * payCell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
            payCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            float totalMonty = [[self.orderInfo valueForKey:@"cmprice"] floatValue] * [[self.orderInfo valueForKey:@"num"] intValue];
            
            payCell.productPrice.text = [NSString stringWithFormat:@"￥%.1f",totalMonty];
            
            payCell.souldPayLabel.text = [NSString stringWithFormat:@"￥%.1f",totalMonty];
            
            return payCell;
            
        }else {
            
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RamekCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel * label = (UILabel *)[cell viewWithTag:100];
            
            if ([AppUtil isNull:[self.orderInfo valueForKey:@"ramerk"]]) {
                
                  label.text = @"备注:";
                
            }else {
                
                label.text = [NSString stringWithFormat:@"备注:%@",[self.orderInfo valueForKey:@"ramerk"]];
            }
            
            return cell;
            
        }
        
    }else if (indexPath.section == 2) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderNo"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * orderNo = (UILabel *)[cell viewWithTag:100];
        
          orderNo.text = [NSString stringWithFormat:@"订单号:%@",[self.orderInfo valueForKey:@"typeNum"]];
        
        return cell;
    
    }else {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GetCell"];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * takeOffName = (UILabel *)[cell viewWithTag:100];
          takeOffName.text = [NSString stringWithFormat:@"%@",[self.orderInfo valueForKey:@"name"]];
        
        UILabel * phone = (UILabel *)[cell viewWithTag:101];
          phone.text = [NSString stringWithFormat:@"%@",[self.orderInfo valueForKey:@"phone"]];
        
        UILabel * address = (UILabel *)[cell viewWithTag:102];
          address.text = [NSString stringWithFormat:@"%@%@",[self.orderInfo valueForKey:@"qid"],[self.orderInfo valueForKey:@"address"]];
        
        UILabel * payWay = (UILabel *)[cell viewWithTag:103];
          payWay.text = @"货到付款";
        
        UILabel * createTime = (UILabel *)[cell viewWithTag:104];
          createTime.text = [NSString stringWithFormat:@"%@",[self.orderInfo valueForKey:@"createtime"]];
        
        return cell;
    }
}


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
