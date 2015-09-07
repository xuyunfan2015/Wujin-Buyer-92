//
//  ProductDetailView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTURLImageView.h"

@protocol ProductDetailViewDelegate <NSObject>

- (void)addToCarWithProductInfo:(NSDictionary *)productInfo number:(NSString *)number;

@end

@interface ProductDetailView : UIView<UIGestureRecognizerDelegate>

@property (assign, nonatomic) id<ProductDetailViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet WTURLImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (assign, nonatomic) NSDictionary * productInfo;

- (IBAction)closeAction:(id)sender;

- (void)openWithProductInfo:(NSDictionary *)productInfo inSuperView:(UIView *)superView;
@end
