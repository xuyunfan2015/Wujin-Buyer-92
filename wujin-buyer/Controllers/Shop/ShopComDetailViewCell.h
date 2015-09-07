//
//  ShopComDetailViewCell.h
//  wujin-buyer
//
//  Created by Alan on 15/8/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopComDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UITextView *comment;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *data;
- (void)loadHomePageDetailWithDetailList:(NSDictionary *)comments;
@end
