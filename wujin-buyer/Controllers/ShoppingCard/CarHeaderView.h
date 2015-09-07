//
//  CarHeaderView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectButton.h"

@class CarHeaderView;

@protocol CarHeaderViewDelegate <NSObject>

- (void)carHeader:(CarHeaderView *)carHeaderView didCallWithShopInfo:(NSDictionary *)shopInfo;

- (void)carHeader:(CarHeaderView *)carHeaderView didChatWithShopInfo:(NSDictionary *)shopInfo;

- (void)carHeader:(CarHeaderView *)carHeaderView didSelectShopWithShop:(NSDictionary *)shopInfo;

@end

@interface CarHeaderView : UITableViewCell

@property (assign, nonatomic) id<CarHeaderViewDelegate> delegate;

@property (nonatomic,strong) NSDictionary * shopInfo;

@property (strong, nonatomic) IBOutlet SelectButton *selectButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *upLine;

@property (strong, nonatomic) IBOutlet UIButton *telButton;
@property (strong, nonatomic) IBOutlet UIButton *msgButton;

@end
