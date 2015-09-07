//
//  ShowDetailViewController.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/6.
//  Copyright (c) 2015年 wujin. All rights reserved.
//
//MapViewController
#import "ShowDetailViewController.h"
#import "ShopHeaderView.h"
#import "UIView+KGViewExtend.h"
#import "ShowProductCell.h"
#import "BottomBar.h"
#import "ProductCategoyViewController.h"
#import "UserInfo.h"
#import "AppDelegate.h"
#import "ChatListViewController.h"
#import "AppUtil.h"
#import "ShopCategoryCell.h"
#import "ShopHeaderCell.h"
#import "BottomView.h"
#import "AllCategoryShowView.h"
#import "ProductByProductVC.h"
#import "ConfirmOrderViewController.h"
//商品详情
#import "ProductDetailView.h"

@interface ShowDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ShopHeaderDelegate,UIActionSheetDelegate,UITextFieldDelegate,BottomViewDelegate,ShopHeaderCellDelegate,AllCategoryShowViewDelegate,ProductDetailViewDelegate>

//头部的view
@property (strong, nonatomic) ShopHeaderView * shopHeaderView;
//商品数组
@property (strong, nonatomic) NSMutableArray * productArray;
//类别数组
@property (strong, nonatomic) NSMutableArray * categoryArray;
//商品头部
@property (strong, nonatomic) ShopHeaderCell * shopHeaderCell;
///底部的view
@property (strong, nonatomic) BottomView * bottomView;
////查看所有类别的view
@property (strong, nonatomic) AllCategoryShowView * allCategoryView;

//当前类别
@property (strong, nonatomic) NSDictionary * currentSpecie;

///查看详情
@property (strong,nonatomic)ProductDetailView * productView;

@end

@implementation ShowDetailViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ShowDetailViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ShowDetailViewController"];
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:self.cShopInfo.shopName];
    [self initUnreadView];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self initHeaderViewWithTableView:self.tableView];
    [self initFooterViewWithTableView:self.tableView];

    self.bottomConstraint.constant = 40;
    [self.view setNeedsDisplay];

    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShopHeaderView" owner:nil options:nil];
    _shopHeaderView = [nibView objectAtIndex:0];
    _shopHeaderView.delegate = self;
    _shopHeaderView.frame = CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 117);
    if (!self.isFromMap) {
         [_shopHeaderView layoutWithShopInfo:self.cShopInfo];
    }
    
   
     
    [self.tableView registerClass:[UICollectionViewCell class]  forCellWithReuseIdentifier:@"ShopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCategoryCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"ShopHeaderCell"];
    
     _productArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self layoutContentView];
    
    NSArray* nibView1 =  [[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:nil options:nil];
    _bottomView = [nibView1 objectAtIndex:0];
    _bottomView.delegate = self;
    _bottomView.shopId=self.shopID;
    if (!self.isFromMap) {
         _bottomView.sendPrice = [self.cShopInfo.sfprice floatValue];
    }
    _bottomView.frame = CGRectMake(0,K_UIMAINSCREEN_HEIGHT - 50 , K_UIMAINSCREEN_WIDTH, 50);
    [self.view addSubview:_bottomView];
    [_bottomView initSubViews];
    
    //获取商品总数///////////
    [self getTotalCount];
    //获取所有类别/////////////
    [self getAllCategorys];
    //////获取数据////////////////
    page = 1;
    refreshing = YES;
    [self getAllProducts];
    ////////////////////////////////
}

- (void)resetViews {
    
    [_shopHeaderView layoutWithShopInfo:self.cShopInfo];
    
    _bottomView.sendPrice = [self.cShopInfo.sfprice floatValue];
    [_bottomView updateSubViews];
}

- (void)layoutContentView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向

   // flowLayout.minimumLineSpacing = 0;
   // flowLayout.minimumInteritemSpacing = 0;
    
    if (_category == 0) {
        
        //创建一屏的视图大小
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }else {
        
        //创建一屏的视图大小
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    
    _tableView.collectionViewLayout = flowLayout;
    _tableView.alwaysBounceVertical = YES;
    [_tableView registerNib:[self getNibByIdentifity:@"ShowProductCell" ] forCellWithReuseIdentifier:@"ShowProductCell"];
    [_tableView setUserInteractionEnabled:YES];
    [_tableView setDelegate:self]; //代理－视图
    [_tableView setDataSource:self]; //代理－数据
}

#pragma mark - ShopHeaderViewDelegate

- (void)collectClick {
    
    if (![self isEnterServer]) {
        
        [self showAlertViewWithMessage:@"请先登录" andImage:nil];
        
    }else {
        
        NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID, @"shopid", [UserInfo sharedUserInfo].userID,@"uid", nil];
        
        NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:T_SHOP_COLLECT bodyParams:params];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [self hideCustomIndicator];
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                    
                    [self showAlertViewWithMessage:@"收藏成功" andImage:TTImage(@"rightAlertImage")];
                    
                    
                } fail:^(NSDictionary *failDic) {
                    
                     [self showAlertViewWithMessage:@"已收藏" andImage:TTImage(@"rightAlertImage")];
                    
                }];
                
            } else {
                
                [self showAlertViewWithMessage:ERROR_SERVER andImage:nil];
            }
        }];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    //每次回来都更新
    [_bottomView updateShoppingCar];
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    //return 4;
    return 2;
}

//定义展示的Section的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

//        if (section == 0) {
//            
//            return 1;
//      
//        }else if(section == 1) {
//            
//            return [_categoryArray count];
//            
//        }else if(section == 2) {
//         
//            return 1;
//            
//        }else {
//            
//            return [_productArray count];
//        }
    if (section == 0) {
        
                    return 1;
        
                }else
                    
                    return [_productArray count];
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        if (indexPath.section == 0) {
            
            UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopHeaderView" forIndexPath:indexPath];
           
            if (![_shopHeaderView superview]) {
                
                [cell.contentView addSubview:_shopHeaderView];
            }
            return cell;
            
        }
        
//        if (indexPath.section == 1) {
//            
//            ShopCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCategoryCell" forIndexPath:indexPath];
//            
//            cell.backgroundColor = [UIColor whiteColor];
//            
//            NSDictionary * dic = _categoryArray[indexPath.row];
//            
//            NSString * comURL = [CommentRequest getCompleteImageURLStringWithSubURL:[dic valueForKey:@"img"] ];
//            [cell.imageView setURL:comURL defaultImage:PLACE_HORDER_IMAGE(cell.imageView)];
//            
//            cell.categoryName.text = [dic valueForKey:@"spname"];
//            
//            cell.otherCategory.text = [dic valueForKey:@"rmeark"];
//            
//            cell.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.f].CGColor;
//            cell.layer.borderWidth = 0.3f;
//
//             cell.layer.masksToBounds = YES;
//            
//            return cell;
//            
//        }
//    
//    if (indexPath.section == 2) {
//        
//        if (_shopHeaderCell) {
//            
//            return _shopHeaderCell;
//        }
//        
//        ShopHeaderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopHeaderCell" forIndexPath:indexPath];
//        cell.delegate = self;
//        _shopHeaderCell = cell;
//        return cell;
//        
//    }
    
        ShowProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowProductCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
        NSDictionary * dic = _productArray[indexPath.row];
        
    [cell.productHeaderImageView setURL:[CommentRequest getCompleteImageURLStringWithSubURL:[dic valueForKey:@"cmimg"]] defaultImage:PLACE_HORDER_IMAGE(cell.productHeaderImageView)];
        cell.productName.text = [dic valueForKey:@"cmname"];
        
        cell.productPrice.text = [NSString stringWithFormat:@"￥%@", [dic valueForKey:@"cmprice"]];
        cell.layer.cornerRadius = 5.f;
        cell.layer.masksToBounds = YES;
        
        cell.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.f].CGColor;
        
        cell.layer.borderWidth = 0.5f;
        
        cell.clipsToBounds = YES;
        
        [cell setNeedsDisplay];
        
        return cell;

}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        if (indexPath.section == 0) {
            
            return CGSizeMake(K_UIMAINSCREEN_WIDTH, 110);
            
//        }else if (indexPath.section == 1){
//            
//            if ([_categoryArray count] % 2 == 0) {
//                
//                   return CGSizeMake(K_UIMAINSCREEN_WIDTH/2, 60);
//            
//            }else {
//                
//                if (([_categoryArray count] - 1) == indexPath.row) {
//                    
//                    return CGSizeMake(K_UIMAINSCREEN_WIDTH, 60);
//                
//                }else {
//                    
//                     return CGSizeMake(K_UIMAINSCREEN_WIDTH/2, 60);
//                }
//                
//            }
//            
//        }else if (indexPath.section == 2){
//         
//            return CGSizeMake(K_UIMAINSCREEN_WIDTH, 48);
            
        }else {
            
            return CGSizeMake((K_UIMAINSCREEN_WIDTH - 30)/2, (K_UIMAINSCREEN_WIDTH - 30)/2 * 200 / 145);
        }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
//    }else if(section == 1){
//        
//        return 0;
//        
//    }else if(section == 2){
//     
//        return 0;
//        
    }
    else {
        
        return 5;
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    }
//    else if(section == 1){
//        
//        return 0;
//        
//    }else if(section == 2){
//     
//        return 0;
//        
//    }
    else {
        
        return 10;
    }

}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

        if (section == 0) {
            
            return UIEdgeInsetsMake(0, 0, 0, 0);
          
        }
//        else if (section == 1){
//            
//            return UIEdgeInsetsMake(0, 0, 0, 0);
//            
//        }else if (section == 2){
//            
//             return UIEdgeInsetsMake(0, 0, 0, 0);
//            
//        }
        else {
            
            return UIEdgeInsetsMake(10, 10, 0, 10);
        }
}

#pragma mark - ProductDetailViewDelegate

- (void)addToCarWithProductInfo:(NSDictionary *)productInfo number:(NSString *)number {
    
    if (![self isEnterServer]) {
        
        return;
    }
    
    NSString * uid = [[UserInfo sharedUserInfo] userID];
    NSString * cmid = [productInfo valueForKey:@"cmid"];
    NSString * sid = [productInfo valueForKey:@"sid"];
  
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sid,@"shopid",cmid,@"cmid",uid,@"uid",number,@"num", nil];
    
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

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        
        return;
    }
    
//    if (indexPath.section == 1) {
//            
//        ProductByProductVC * productByCategoryVC = [self storyBoardControllerID:@"Other" WithControllerID:@"ProductByProductVC"];
//        
//        productByCategoryVC.sendPrice = [self.cShopInfo.sfprice floatValue];
//   
//        NSDictionary * cate = _categoryArray[indexPath.row];
//        
//        productByCategoryVC.categoryInfo = cate;
//        
//        productByCategoryVC.shopID = self.shopID;
//       
//        [self.navigationController pushViewController:productByCategoryVC animated:YES];
//        
//    }
    else {
        
        if (!_productView) {
            
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ProductDetailView" owner:nil options:nil];
            _productView = [nibView objectAtIndex:0];
            _productView.delegate = self;
            _productView.frame = self.view.bounds;
            
        }
        
        NSDictionary * dic = _productArray[indexPath.row];
        
        [_productView openWithProductInfo:dic inSuperView:self.view];
        
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return NO;
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

#pragma mark - ShopHeaderCellDelegate

- (void)shopHeaderViewDidSelectedCate:(ShopHeaderCell *)shopHeaderView {
    
    if (!_allCategoryView || ([_allCategoryView.allCategoryArray count] == 0)) {
        
        NSMutableDictionary * params  = [NSMutableDictionary dictionary];
        
        NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:ALL_CATEGORY postValueParams:params];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                    
                    NSMutableArray * category = [[NSMutableArray alloc] initWithArray:[successDic valueForKey:@"species"]];;
                    
                    NSDictionary * firstDic = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"spname",@"0",@"spid", nil];
                    
                    [category insertObject:firstDic atIndex:0];
                    
                    
                    if (!_allCategoryView) {
                        
                        _allCategoryView = [[AllCategoryShowView alloc] initWithFrame:self.view.bounds];
                        
                        _allCategoryView.delegate  = self;
                        
                        _allCategoryView.allCategoryArray = category;
                        
                        [_allCategoryView openCategoryInView:self.view];
                    }
                    
                    [self.view addSubview:_allCategoryView];
                    
                } fail:^(NSDictionary *failDic) {
                    
                    [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
                }];
            } else {
                
            }
        }];
        
    }else {
     
        [self.view addSubview:_allCategoryView];
        
    }
}

#pragma mark - AllCategoryViewDelegate

-(void)categoryShowView:(AllCategoryShowView *)allCateShowView didSelectCategoryShowView:(NSDictionary *)categoryDic {
    
//    ///////////////没有选择///////////////////////////////////////////
//    if ((!self.currentSpecie && ([[categoryDic valueForKey:@"spid"] intValue] == 0)) || ([[categoryDic valueForKey:@"spid"] intValue] == [[self.currentSpecie valueForKey:@"sqid"] intValue])) {
//        
//        return;
//    }
    ///当前view
    self.currentSpecie = categoryDic;
    //设置类别名称
    [self.shopHeaderCell.categoryButton setTitle:[categoryDic valueForKey:@"spname"] forState:UIControlStateNormal];
 
    page = 1;
    refreshing = YES;
    
    if (!self.currentSpecie || [[categoryDic valueForKey:@"spid"] intValue] == 0) {
        
        [self getAllProducts];
    }else {
        
        [self getAllProductsByCategoryID];
    }
}

#pragma mark - BottomBarDelegate

//去结算
- (void)bottomViewDidCheck:(BottomView *)bottomView {
    
     ConfirmOrderViewController * confirmVC = [self storyBoardControllerID:@"Other" WithControllerID:@"ConfirmOrderViewController"];
    confirmVC.shopid=self.shopID;
    confirmVC.shopArrays = [[NSMutableArray alloc] initWithArray:_bottomView.carList];;
    
    [self.navigationController pushViewController:confirmVC animated:YES];
}
//去购物车
-(void)bottomViewDidGoCar:(BottomView *)bottomView {
    //去购物车
}

#pragma mark - imp super method

- (void)updateInfomations {
    
    if (![CommentRequest networkStatus]) {
        
        [self showCustomIndicatorWithMessage:NO_NETWORK_MESSAGE];
        
    }else {
        
        [self showCustomIndicatorWithMessage:LOADING_MESSAGE];

      
        if (!self.currentSpecie || ([[self.currentSpecie valueForKey:@"spid"] intValue] == 0)) {
            
            [self getAllProducts];
        
        }else {
            
            [self getAllProductsByCategoryID];
        }
        
    }
}

#pragma mark - 获取商品

- (void)getAllProducts {
    
        NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"countpage",self.shopID,@"shopid", nil];
        
        NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOP_PRODUCTS postValueParams:params];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [self hideCustomIndicator];
            [self updateFinish];
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                    
                    if (refreshing) {
                        [_productArray removeAllObjects];
                    }
                    
                    [_productArray addObjectsFromArray:[successDic valueForKey:@"shops"]];
                    
                    if (self.isFromMap && [_productArray count] > 0) {
                        
                        self.cShopInfo = [HomePageDetailList homePageDetailListWithDictionary:_productArray[0]];
                        
                        [self resetViews];
                    }
                    
                    for (NSDictionary * dic in _productArray) {
                        
                        if ([AppUtil isNull:[dic valueForKey:@"cmid"]]) {
                            
                            [_productArray removeObject:dic];
                        }
                    }
                  //  [_tableView reloadSections:[NSIndexSet indexSetWithIndex:3]];
                     [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1]];
                } fail:^(NSDictionary *failDic) {
                    
                   // [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
                }];
            } else {
                
            }
        }];
}
//
- (void)getAllProductsByCategoryID {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"countpage",self.shopID,@"shopid",[self.currentSpecie valueForKey:@"spid"],@"spid", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:GET_PRODUCTS_BY_CATEGORYID postValueParams:params];
    
    [self showCustomIndicatorWithMessage:@"正在加载中..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        [self updateFinish];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                if (refreshing) {
                    [_productArray removeAllObjects];
                }
                
                [_productArray addObjectsFromArray:[successDic valueForKey:@"mapss"]];
                
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:3]];
                
            } fail:^(NSDictionary *failDic) {
                
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];
}

- (void)getAllCategorys {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"shopid",@"1",@"type", @"0",@"pid",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOP_CATEGORY postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                if (!_categoryArray) {
                    
                    _categoryArray = [[NSMutableArray alloc] initWithCapacity:0];
                }
                
                [_categoryArray addObjectsFromArray:[successDic valueForKey:@"shopCommodityList"]];
                
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1]];
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];
}


- (void)getTotalCount {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"shopid",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOP_PRODUCT_COUNT postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
              //  NSLog(@"%@",successDic);
                
                NSString * count = [[successDic valueForKey:@"countList"][0] valueForKey:@"count"];
                
                _shopHeaderCell.totalCount.text = count;
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
        }
    }];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {

        NSString * telString = [NSString stringWithFormat:@"tel://%@",[self.cShopInfo valueForKey:@"smobile"]];
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    }
}

#pragma mark - Memory Manage

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
