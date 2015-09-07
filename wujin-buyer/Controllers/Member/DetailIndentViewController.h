//
//  DetailIndentViewController.h
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "HistoryIndentInfo.h"

@interface DetailIndentViewController : BaseViewController

@property (strong, nonatomic) HistoryIndentInfo *indentInfo;

@property (strong, nonatomic) NSString *sellerID;

@end
