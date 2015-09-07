//
//  AllCategoryShowView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllCategoryShowView;

@protocol AllCategoryShowViewDelegate <NSObject>

-(void)categoryShowView:(AllCategoryShowView *)allCateShowView didSelectCategoryShowView:(NSDictionary *)categoryDic;

@end


@interface AllCategoryShowView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic)id<AllCategoryShowViewDelegate> delegate;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSArray * allCategoryArray;

- (void)openCategoryInView:(UIView *)superView;

@end
