/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@protocol ChatListCellDelegate <NSObject>

- (void)chatCellDidClickAvatarWithIndexRow:(NSInteger)index;

@end

@interface ChatListCell : UITableViewCell<WTURLImageViewDelegate>
@property (nonatomic,assign)NSInteger indexRow;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detailMsg;
@property (nonatomic, strong) NSString *time;
@property (nonatomic) NSInteger unreadCount;
@property (nonatomic,strong) WTURLImageView * avatarView;

@property (nonatomic, assign)id<ChatListCellDelegate> delegate;

+(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
