//
//  HomePageHeadCell.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "HomePageHeadCell.h"
#import "UIImageView+WebCache.h"
#import "AppUtil.h"

@implementation HomePageHeadCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadHomePageHeadCellWithImages:(NSArray *)aArr {
    
    if (nil != aArr) {
        
        for (UIImageView *image in self.homeScrollView.subviews) {
            [image removeFromSuperview];//移除前面的东西
        }
        
        if (aArr.count > 1) {
           
            UIImageView *_lastImage = [[UIImageView alloc] initWithFrame:CGRectMake((aArr.count + 1)*K_UIMAINSCREEN_WIDTH, 0, K_UIMAINSCREEN_WIDTH, 160)];//[[self.homeScrollView subviews] lastObject];
            
            [_lastImage setImageWithURL:[NSURL URLWithString:[CommentRequest getCompleteImageURLStringWithSubURL:[[aArr lastObject]valueForKey:@"img"]]] placeholderImage:[AppUtil imageFromColor:PLACE_HORDER_COLOR Rect:_lastImage.bounds]];
           // NSLog(@"url======%@",[CommentRequest getCompleteImageURLStringWithSubURL:[[aArr lastObject]valueForKey:@"img"]]);
            UIImageView *_firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 160)];
            
             [_firstImage setImageWithURL:[NSURL URLWithString:[CommentRequest getCompleteImageURLStringWithSubURL:[[aArr firstObject]valueForKey:@"img"]]] placeholderImage:[AppUtil imageFromColor:PLACE_HORDER_COLOR Rect:_firstImage.bounds]];
            
            [self.homeScrollView addSubview:_firstImage];
            [self.homeScrollView addSubview:_lastImage];
            
            
            self.homeScrollView.contentSize = CGSizeMake(CGRectGetMaxX(_lastImage.frame), 160);
            
            for (NSInteger i = 1; i <= [aArr count]; ++i) {
                
                UIImageView *_image = [[UIImageView alloc] initWithFrame:CGRectMake(i*K_UIMAINSCREEN_WIDTH, 0, K_UIMAINSCREEN_WIDTH, 160)];
                
                  [_image setImageWithURL:[NSURL URLWithString:[CommentRequest getCompleteImageURLStringWithSubURL:[aArr[i-1] valueForKey:@"img"]]] placeholderImage:[AppUtil imageFromColor:PLACE_HORDER_COLOR Rect:_image.bounds]];
                
                [self.homeScrollView addSubview:_image];
            }
        } else {
            
            self.homeScrollView.contentSize = CGSizeMake(K_UIMAINSCREEN_WIDTH, 160);
            
            UIImageView *_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 160)];
            
            
            [_image setImageWithURL:[NSURL URLWithString:[CommentRequest getCompleteImageURLStringWithSubURL:[aArr[0] valueForKey:@"img"]]] placeholderImage:[AppUtil imageFromColor:PLACE_HORDER_COLOR Rect:_image.bounds]];
            
            [self.homeScrollView addSubview:_image];
        }
    
        self.homePagePageControl.numberOfPages = [aArr count];
    }
}
@end
