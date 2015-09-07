//
//  BottomView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPCell.h"

@class BottomView;

@protocol BottomViewDelegate <NSObject>

-(void)bottomViewDidCheck:(BottomView *)bottomView;

-(void)bottomViewDidGoCar:(BottomView *)bottomView;

@end

@interface BottomView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,CPCellDelegate>

///送货价格
@property (assign, nonatomic) float sendPrice;

@property (weak, nonatomic) IBOutlet UILabel *totalLabal;

@property (assign, nonatomic) id<BottomViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) IBOutlet UIButton *carButton;


@property (strong, nonatomic) UITableView * tableView;//////表格
@property (strong, nonatomic) UIView * backGroundView;/////

@property (strong, nonatomic)NSArray * carList;
@property (strong, nonatomic)NSString *shopId;
/////数据有无出现
@property (nonatomic, assign)BOOL isShow;

- (void)updateShoppingCar;

- (void)initSubViews;

- (void)updateSubViews;

@end
