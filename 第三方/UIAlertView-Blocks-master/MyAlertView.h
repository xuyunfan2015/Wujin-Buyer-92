//
//  MyAlertView.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/2/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarCell.h"

@interface MyAlertView : UIAlertView

@property (nonatomic,strong) NSMutableString * marketIDs;
@property (nonatomic,strong) NSMutableString * shopIDs;
@property (nonatomic,strong) NSMutableString * productIDs;

@property (nonatomic,strong)CarCell * carCell;
@property (nonatomic,assign) Position position;

@end
