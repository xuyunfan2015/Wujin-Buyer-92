//
//  DetailIndentCell.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailIndentInfo.h"

@protocol DetailIndentCellClickIndent;

@interface DetailIndentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productCategory;
@property (weak, nonatomic) IBOutlet UILabel *productMoney;
@property (weak, nonatomic) IBOutlet UILabel *productNumber;

@property (weak, nonatomic) IBOutlet UIButton *selectProduct;

@property (weak, nonatomic) IBOutlet UILabel *refundState;

@property BOOL isSelectProduct;


@property (weak, nonatomic) id <DetailIndentCellClickIndent> detailIndentDelegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)selectRefundProduct;

- (void)cancelRefundProduct;

- (void)loadDetailIndentCellWithInfo:(DetailIndentInfo *)aInfo;

+ (DetailIndentCell *)detailIndentCell;
@end



@protocol DetailIndentCellClickIndent <NSObject>

- (void)detailIndentCellClickIndent:(NSIndexPath *)indexPath;

@end