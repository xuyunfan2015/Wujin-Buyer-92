//
//  SelectCateView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"
#import "AddCell.h"

@class SelectCateView;

@protocol SelectCateViewDelegate <NSObject>

//加入购物车
- (void)selectCateView:(SelectCateView *)selectCateView didClickAddToCar:(NSDictionary *)selectCategory buyNum:(int)buyNum;

////立即购买
- (void)selectCateView:(SelectCateView *)selectCateView didClickInstantBuy:(NSDictionary *)selectCategory buyNum:(int)buyNum;

- (void)selectCateView:(SelectCateView *)selectCateView didShowMsg:(NSString *)msg;

@end


@interface SelectCateView : UIView<UITableViewDataSource,UITableViewDelegate>//,AddCellDelegate>
{
    ///////////选中的category
    NSArray * categoryList;///所有类别
    NSDictionary * hasSelectedCategory;//当前选中类别dic
    int selectIndex;//选中类别的索引
    
    int tempIndex;///还未点确定之前的值
    
  //  UITextField * textField;
}

@property (nonatomic,strong) UITextField * textField;

@property (assign, nonatomic) BOOL isClickAddToCar;
/****
 弹出框表格
 ***/
@property (weak, nonatomic) IBOutlet UITableView *selectCateTableView;

//弹出框 图片
@property (weak, nonatomic) IBOutlet WTURLImageView *selectImageView;
//选择的价格
@property (weak, nonatomic) IBOutlet UILabel *selectPrice;
//已选择的名称
@property (weak, nonatomic) IBOutlet UILabel *selectCName;
@property (strong, nonatomic)UIView * showCategorySelectView;//弹出框类别

@property (strong,nonatomic) UIView * blackView;//弹出框大蒙版

//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UIButton *selectAddCarButton;//加入购物车

@property (weak, nonatomic) IBOutlet UIButton *selectBuyButton;//立即购买

@property (assign, nonatomic)id<SelectCateViewDelegate> delegate;

@property (strong, nonatomic) NSString * numbers;

@property (nonatomic,assign) BOOL isFrom;//YES--购物车跳转  NO。商品详情
@property (nonatomic,assign) NSString * detailID;

@property (nonatomic,assign) BOOL hasTbar;

@property (weak, nonatomic) IBOutlet UIImageView *line;

- (void)initReloadCateView;
////重新加载
- (void)reloadCateView;
//设置物品图片
- (void)setCateImageWithURL:(NSString *)url;
///所有类别数据 + 选中第几个 + 图片(商品图片)
- (void)layoutSubviewWithCateData:(NSDictionary *)cateData selectIndex:(int)selectIndex1 productImage:(NSString *)url;
///所有类别数据 + 选中第几个 + 图片(商品图片)
- (void)layoutSubviewWithCateData:(NSDictionary *)cateData selectIndex:(int)selectIndex1 productImage:(NSString *)url numbers:(NSString *)numbers;
//type:1 : 显示确定  0: 显示加入购物车
- (void)openSelectViewInSuperView:(UIView *)superView WithType:(int)type ;

@end
