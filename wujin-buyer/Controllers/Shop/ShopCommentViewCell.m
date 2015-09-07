//
//  ShopCommentViewCell.m
//  wujin-buyer
//
//  Created by Alan on 15/8/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopCommentViewCell.h"
#import "ShopAllCommentViewController.h"
@implementation ShopCommentViewCell

- (void)awakeFromNib {
    _textView.layer.borderColor = UIColor.grayColor.CGColor;
    _textView.layer.borderWidth = 1;
    _textView.layer.cornerRadius = 6;
    _textView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (IBAction)pushallCom:(UIButton *)sender {
//    
//    ShopAllCommentViewController *allcommeng=[[ShopAllCommentViewController alloc]init];
//    //HomePageDetailList * homepage = _detailShop[indexPath.row - 1];
//    
//    allcommeng.sid=self.shopID;
//    UIViewController *vc=[self viewController];
//    [vc.navigationController pushViewController:allcommeng animated:YES];
//
//}
//- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}
@end
