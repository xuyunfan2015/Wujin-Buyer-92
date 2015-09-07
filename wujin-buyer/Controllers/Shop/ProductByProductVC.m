//
//  ProductByProductVC.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ProductByProductVC.h"
#import "UIView+KGViewExtend.h"
#import "ProductByProductVC.h"
#import "ProductView.h"
#import "ProductDetailView.h"
#import "ConfirmOrderViewController.h"

@interface ProductByProductVC ()<CategoryHeaderViewDelegate,ProductViewDelegate,UIScrollViewDelegate,ProductDetailViewDelegate>

//小类别数组
@property (nonatomic, strong) NSArray * smallCategory;
//底部的view
@property (nonatomic, strong) BottomView * bottomView;
///查看详情的view
@property (strong,nonatomic)ProductDetailView * productView;

@end

@implementation ProductByProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self layoutNavigationBarWithString:[self.categoryInfo valueForKey:@"spname"]];
    
    NSArray* nibView1 =  [[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:nil options:nil];
    _bottomView = [nibView1 objectAtIndex:0];
    _bottomView.delegate = self;
    _bottomView.frame = CGRectMake(0,K_UIMAINSCREEN_HEIGHT - 50 , K_UIMAINSCREEN_WIDTH, 50);
    _bottomView.sendPrice = self.sendPrice;
    [self.view addSubview:_bottomView];
    [_bottomView initSubViews];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.874 alpha:1.000];
    
    [self getProductsByCategory];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [_bottomView updateShoppingCar];
}

#pragma mark - 

- (void)getProductsByCategory {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"type",[self.categoryInfo valueForKey:@"spid"],@"pid",self.shopID,@"shopid",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOP_CATEGORY postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                self.smallCategory = [successDic valueForKey:@"shopCommodityList"];
                
                if ([self.smallCategory count] > 0) {
                    
                     [self layoutSubviews];
                }
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];

}

- (void)layoutSubviews {
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CategoryHeaderView" owner:nil options:nil];
    _categoryHeaderView = [nibView objectAtIndex:0];
    _categoryHeaderView.delegate = self;
    _categoryHeaderView.frame = CGRectMake(0, 64, K_UIMAINSCREEN_WIDTH, 35);
    [_categoryHeaderView layoutWithCategorys:self.smallCategory];
    [self.view insertSubview:_categoryHeaderView belowSubview:_bottomView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , _categoryHeaderView.bottom, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT - _categoryHeaderView.bottom - 50)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(K_UIMAINSCREEN_WIDTH * [self.smallCategory count], _scrollView.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view insertSubview:_scrollView belowSubview:_bottomView];
    
    for(int index = 0; index < [self.smallCategory count]; index ++) {
        
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ProductView" owner:nil options:nil];
      ProductView *productView   = [nibView objectAtIndex:0];
        productView.frame = CGRectMake(K_UIMAINSCREEN_WIDTH * index, 0, K_UIMAINSCREEN_WIDTH, self.scrollView.height );
        productView.delegate = self;
        [self.scrollView addSubview:productView];
        
        NSDictionary * dic = self.smallCategory[index];
        
        [productView layoutSubViewWithCategoryID:[dic valueForKey:@"smpid"] shopID:self.shopID];
    
    }
}

#pragma mark - ProductViewDelegate

- (void)productView:(ProductView *)productView didSelectWithProduct:(NSDictionary *)productInfo {
    
    if (!_productView) {
        
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ProductDetailView" owner:nil options:nil];
        _productView = [nibView objectAtIndex:0];
        _productView.delegate = self;
        _productView.frame = self.view.bounds;
        
    }
    [_productView openWithProductInfo:productInfo inSuperView:self.view];
}

#pragma mark - ProductDeatilViewDelegate

- (void)addToCarWithProductInfo:(NSDictionary *)productInfo number:(NSString *)number {
    
    if (![self isEnterServer]) {
        
        return;
    }
    
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [productInfo valueForKey:@"cmid"];
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"shopid",cmid,@"cmid",uid,@"uid",number,@"num", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ADD_TO_CAR postValueParams:params];
    
    [self showCustomIndicatorWithMessage:@"加入中..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self showAlertViewWithMessage:@"加入购物车成功" andImage:nil];
                
                [_productView closeAction:nil];
                
                [_bottomView updateShoppingCar];
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
            
        } else {
            
        }
    }];

}

#pragma mark - BottomViewDelegate

- (void)bottomViewDidCheck:(BottomView *)bottomView {
    
    ConfirmOrderViewController * confirmVC = [self storyBoardControllerID:@"Other" WithControllerID:@"ConfirmOrderViewController"];
    
    confirmVC.shopArrays = _bottomView.carList;
    
    [self.navigationController pushViewController:confirmVC animated:YES];
}

-(void)bottomViewDidGoCar:(BottomView *)bottomView {
    
    
}


#pragma mark - CategoryHeaderViewDelegate

- (void)categoryHeaderView:(CategoryHeaderView *)categoryView didSelectedAtIndex:(int)index {

    CGPoint point = _scrollView.contentOffset;
    point.x = K_UIMAINSCREEN_WIDTH * index;
    
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = point;
    }];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    
    int index = point.x/K_UIMAINSCREEN_WIDTH;
    
    [self.categoryHeaderView setScrollAtIndex:index];
    
}

#pragma mark - Memory Manage

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
