//
//  CategoryHeaderView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryHeaderView;

@protocol CategoryHeaderViewDelegate <NSObject>

- (void)categoryHeaderView:(CategoryHeaderView *)categoryView didSelectedAtIndex:(int)index;

@end

@interface CategoryHeaderView : UIView

@property (nonatomic,assign)int selectedIndex;

@property (weak, nonatomic) IBOutlet UIView *selectedView;

@property (strong, nonatomic) NSArray * categorys;

@property (assign, nonatomic) id<CategoryHeaderViewDelegate> delegate;

- (void)setScrollAtIndex:(int)index;

- (void)layoutWithCategorys:(NSArray *)categorys;

@end
