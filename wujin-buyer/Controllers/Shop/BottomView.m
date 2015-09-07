//
//  BottomView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BottomView.h"
#import "AppUtil.h"
#import "CPCell.h"
#import "UIView+KGViewExtend.h"

@implementation BottomView

- (void)initSubViews {
    
    //////////背景//////////////
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT - 35)];
    _backGroundView.backgroundColor = [UIColor blackColor];
    _backGroundView.alpha = 0.5;
    [self insertSubview:_backGroundView belowSubview:self.carButton];
    [_backGroundView setHidden:YES];
    
    UITapGestureRecognizer * tapGescure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
    tapGescure.numberOfTapsRequired = 1;
    [_backGroundView addGestureRecognizer:tapGescure];
    
    //////////表格//////////
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, K_UIMAINSCREEN_WIDTH, 50)];
    _tableView.bounces = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"CPCell" bundle:nil] forCellReuseIdentifier:@"CPCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self insertSubview:_tableView aboveSubview:_backGroundView];
    [_tableView setHidden:YES];
    
    ///更新views
    [self updateSubViews];

}

- (void)updateSubViews {
    
    float totalMoney = [self caculateTotalMoney];
    
    self.totalLabal.text = [NSString stringWithFormat:@"总价:￥%.1f",totalMoney];
    
    if (totalMoney < self.sendPrice) {
        
        self.checkButton.enabled = NO;
        self.checkButton.backgroundColor = [UIColor lightGrayColor];
        
        NSString * money = [[NSString alloc] initWithFormat:@"还差%.1f元",self.sendPrice - totalMoney];
        
        [self.checkButton setTitle:money forState:UIControlStateNormal];
        
    }else {
        
        self.checkButton.enabled = YES;
        self.checkButton.backgroundColor = [UIColor redColor];
        [self.checkButton setTitle:@"去结算" forState:UIControlStateNormal];
    }
    
    if (self.isShow) {
        
        int maxHeight = K_UIMAINSCREEN_HEIGHT - 100 - 35;
        int tableHeight = 50;
        if ([_carList count] > 0) {
            
            tableHeight = 40 * (int)[_carList count];
        }
        if (tableHeight > maxHeight) {
            
            tableHeight = maxHeight;
        }
        _tableView.height = tableHeight;
        _tableView.top = K_UIMAINSCREEN_HEIGHT - 35 - tableHeight;
    }

}

- (IBAction)jsButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomViewDidCheck:)]) {
        
        [self.delegate bottomViewDidCheck:self];
    }
}

- (IBAction)carAction:(id)sender {
    
    [self closeAction];
}

- (void)closeAction {
    
    self.isShow = !self.isShow;
    
    if (self.isShow) {
        
        self.top = 0;
        self.height = K_UIMAINSCREEN_HEIGHT;
        
        [_backGroundView setHidden:NO];
        [_tableView setHidden:NO];
        
        int maxHeight = K_UIMAINSCREEN_HEIGHT - 100 - 35;
        
        int tableHeight = 50;
        
        if ([_carList count] > 0) {
            
            tableHeight = 40 * (int)[_carList count];
        }
        
        if (tableHeight > maxHeight) {
            
            tableHeight = maxHeight;
        }
        
        _tableView.height = tableHeight;
        
        _tableView.top = K_UIMAINSCREEN_HEIGHT - 35 - tableHeight;
        
    }else {
        
        self.height = 50;
        self.top = K_UIMAINSCREEN_HEIGHT - 50;
        
        [_backGroundView setHidden:YES];
        [_tableView setHidden:YES];
    }

}

#pragma mark - 刷新购物车

- (void)updateShoppingCar {
    
    [self getCarInfomations];
}

#pragma mark - 获取购物车信息

- (void)getCarInfomations {

    NSString * userID = [[UserInfo sharedUserInfo] userID];
    
    if ([AppUtil isNull:userID]) {
        
        return;
    }
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userID,@"uid",self.shopId,@"shopid", nil];
        
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:CAR_LIST postValueParams:params];
    
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                 
                    _carList = [successDic valueForKey:@"coms"];
                    
                    [self.tableView reloadData];
                    
                    [self updateSubViews];
                
                } fail:^(NSDictionary *failDic) {
                    
                }];
            }
        }];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!_carList || [_carList count] == 0) {
        
        return 1;
    }
    return [_carList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_carList || [_carList count] == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 50)];
            label.text = @"购物车啥也没有";
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor grayColor];
            [cell.contentView addSubview:label];
        }
        
        return cell;
        
    }else {
        
        CPCell * cpCell = [tableView dequeueReusableCellWithIdentifier:@"CPCell"];
        
        cpCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cpCell.delegate = self;
        
        NSDictionary * dic = _carList[indexPath.row];
        
        cpCell.carInfo = dic;
        
        cpCell.productName.text = [dic valueForKey:@"cmname"];
        cpCell.numberField.text = [dic valueForKey:@"num"];
        cpCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[dic valueForKey:@"cmprice"]];
        
        return cpCell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_carList || [_carList count] == 0) {
     
        return 50;
    }
    
    return 40;
}

#pragma mark - CPCellDelegate

- (void)cpCell:(CPCell *)cell subWithCarInfo:(NSDictionary *)carInfo {
    
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [carInfo valueForKey:@"cmid"];
    NSString * sid = [carInfo valueForKey:@"sid"];
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sid,@"shopid",cmid,@"cmid",uid,@"uid",@"1",@"num", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:CAR_SUB postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self updateShoppingCar];
                
            } fail:^(NSDictionary *failDic) {
                
            }];
            
        } else {
            
        }
    }];

}

- (void)cpCell:(CPCell *)cell addWithCarInfo:(NSDictionary *)carInfo {
    
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [carInfo valueForKey:@"cmid"];
    NSString * sid = [carInfo valueForKey:@"sid"];
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sid,@"shopid",cmid,@"cmid",uid,@"uid",@"1",@"num", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ADD_TO_CAR postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self updateShoppingCar];
                
            } fail:^(NSDictionary *failDic) {
                
            }];
            
        } else {
            
        }
    }];

}


#pragma mark -

- (float)caculateTotalMoney {
    
    if (!_carList || [_carList count] == 0) {
        
        return 0;
    
    }else {
        
        float totalMoney = 0.0;
        
        for (NSDictionary * dic in _carList) {
            
            totalMoney = totalMoney + [[dic valueForKey:@"num"] intValue] * [[dic valueForKey:@"cmprice"] floatValue];
            
        }
        
        return totalMoney;
        
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
