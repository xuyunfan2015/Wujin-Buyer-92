//
//  ProductView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductView;

@protocol ProductViewDelegate <NSObject>

- (void)productView:(ProductView *)productView didSelectWithProduct:(NSDictionary *)productInfo;

@end

@interface ProductView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)NSString * cateID;
@property (strong, nonatomic)NSString * shopID;

@property (weak, nonatomic) IBOutlet UICollectionView *tableView;

@property (nonatomic, assign) id<ProductViewDelegate> delegate;

@property (strong, nonatomic)NSMutableArray *productArray;

- (void)layoutSubViewWithCategoryID:(NSString *)categoryID shopID:(NSString *)shopID;

@end
