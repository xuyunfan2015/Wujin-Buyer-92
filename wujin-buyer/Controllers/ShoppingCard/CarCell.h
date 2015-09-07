//
//  CarCell.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectButton.h"
#import "WTURLImageView.h"

@class CarCell;

typedef struct POSITION {
    int  marketIndex;
    int shopIndex;
    int  productIndex;
    int detailIndex;
}Position;

@protocol CarCellDelegate <NSObject>

- (void)carCell:(CarCell *)carCell didUpdateCurrentNumberAtPosition:(Position)position;

- (void)carCell:(CarCell *)carCell didShowSelectCategoryAtPosition:(Position)position;

- (void)carCell:(CarCell *)carCell didResetNumber:(Position)position;

@end

@interface CarCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (assign,nonatomic) id<CarCellDelegate> delegate;

///将产品信息传入
@property (nonatomic,strong) NSDictionary * productInfo;
///选中按钮
@property (weak, nonatomic) IBOutlet SelectButton *selectButton;
//商品图片
@property (weak, nonatomic) IBOutlet WTURLImageView *cardImage;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLael;
//类别
@property (weak, nonatomic) IBOutlet UIButton *categoryLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//数量
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

/////操作条/////////////////////////
@property (weak, nonatomic) IBOutlet UIView *operationBar;
////修改数量
@property (weak, nonatomic) IBOutlet UITextField *numberField;
//减号俺就
@property (weak, nonatomic) IBOutlet UIButton *subButton;
//加号按钮
@property (weak, nonatomic) IBOutlet UIButton *addButton;
//更新类别按钮
@property (weak, nonatomic) IBOutlet UIButton *selectCategoryButton;
@property (weak, nonatomic) IBOutlet UIButton *sButton;

- (void)setIsSelected:(BOOL)selected;

@property (weak, nonatomic) IBOutlet UIImageView *line;




@end
