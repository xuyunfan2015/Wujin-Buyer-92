//
//  ShopCommentViewCell.h
//  wujin-buyer
//
//  Created by Alan on 15/8/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCommentViewCell : UITableViewCell
@property (nonatomic,strong)NSString *shopID;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
