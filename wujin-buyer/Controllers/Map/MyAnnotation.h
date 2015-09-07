//
//  MyPointAnimationView.h
//  wujin-buyer
//
//  Created by jensen on 15/6/28.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

@interface MyAnnotation : BMKPointAnnotation

@property (nonatomic,strong) NSDictionary * shopInfo;

@property (nonatomic,assign) BOOL isRegion;

@end
