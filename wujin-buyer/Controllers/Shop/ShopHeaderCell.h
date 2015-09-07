//
//  ShopHeaderCell.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopHeaderCell;


@protocol ShopHeaderCellDelegate <NSObject>

- (void)shopHeaderViewDidSelectedCate:(ShopHeaderCell *)shopHeaderView;

@end

@interface ShopHeaderCell : UICollectionViewCell

@property(assign, nonatomic)id<ShopHeaderCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *categoryButton;

@property (weak, nonatomic) IBOutlet UILabel *totalCount;


@end
