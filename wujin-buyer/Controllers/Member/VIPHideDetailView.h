//
//  VIPHideDetailView.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

@class VIPHideDetailView;

@protocol VIPHideDetailClickAtSection <NSObject>

- (void)VIPHideDetailClick:(VIPHideDetailView *)headerView atSection:(NSInteger)section;

@end


#import <UIKit/UIKit.h>

@interface VIPHideDetailView : UIView

{
    UILabel *_shopName;
}

@property (weak, nonatomic) id<VIPHideDetailClickAtSection> VIPHIdeDelegate;

- (void)setShopName:(NSString *)name;

+ (instancetype)VIPHideDetailView;

@end
