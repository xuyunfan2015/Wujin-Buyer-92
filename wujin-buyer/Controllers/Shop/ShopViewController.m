//
//  ShopViewController.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCell.h"
#import "ShowDetailViewController.h"
#import "JSON.h"
#import "ShopProductViewCell.h"
#import "ShowProductCell.h"
#import "AppDelegate.h"
#import "CommentNetwordRequest.h"
#import "HomePageDetailList.h"


@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ShopCellDelegate,UIActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate,UIScrollViewDelegate>
{
    NSMutableArray * shopArray;
}

@property (weak, nonatomic) IBOutlet UIView *downLine;
@end

@implementation ShopViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ShopViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ShopViewController"];
}

- (void)viewDidLoad {
    
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:nil];
    
    if (!self.isFromMarket) {
        
        self.navigationBar.leftButton.hidden = YES;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self layoutShopWithName:@"店铺" actions:@selector(searchAction)  type:0];
    
    [self initUnreadView];
  //  [self initHeaderViewWithTableView:self.tableView];
   // [self initFooterViewWithTableView:self.tableView];
    
    self.tableView.bounces = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"noDataCell"];
    
    self.tableView.tableFooterView = [UIView new];
    
    ///////
    self.searchField.delegate = self;
    
    //////////
    shopArray = [[NSMutableArray alloc] initWithCapacity:0];
    _productArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self layoutContentView];
    
    page = 1;
    refreshing = YES;
    
    [self.tableView setHidden:NO];
    [self.productCollectView setHidden:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.delegate = self;
}

- (void)layoutContentView {
    
    [self initHeader1ViewWithTableView:self.productCollectView];
    [self initFooter1ViewWithTableView:self.productCollectView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    
    //创建一屏的视图大小
    self.productCollectView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.productCollectView.alwaysBounceVertical = YES;
    self.productCollectView.bounces = YES;
    self.productCollectView.collectionViewLayout = flowLayout;
    [self.productCollectView registerNib:[self getNibByIdentifity:@"ShowProductCell" ] forCellWithReuseIdentifier:@"ShowProductCell"];
    [self.productCollectView setUserInteractionEnabled:YES];
    [self.productCollectView setDelegate:self]; //代理－视图
    [self.productCollectView setDataSource:self]; //代理－数据
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.searchField resignFirstResponder];
    
    NSString * searchName = textField.text;
    
    if (![CommentRequest networkStatus]) {
        
        [self showAlertViewWithMessage:NO_NETWORK_MESSAGE andImage:nil];
        
    }else {
        
        if (searchName && ![searchName isEqualToString:@""]) {
            
            self.searchName = searchName;
            
            if (self.tableView.hidden == NO) {//商店
                
                page = 1;
                refreshing = YES;
                [self shopSearchWithKeyname:searchName];
                
            }
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length == 0) {
        
        self.searchName = nil;
        
        [shopArray removeAllObjects];
        
        [self.tableView reloadData];
      
    }
    return YES;
    
}

#pragma mark - imp super method

- (void)updateInfomations {
    
    if (![CommentRequest networkStatus]) {

        [self showCustomIndicatorWithMessage:NO_NETWORK_MESSAGE];
        
    }else {

        
        if (self.searchName && ![self.searchName isEqualToString:@""]) {
            
             [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
            
            [self shopSearchWithKeyname:self.searchName];
            
        }else {
           
            [self updateFinish];

        }
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!shopArray || [shopArray count] == 0) {
        
        return K_UIMAINSCREEN_HEIGHT -64 - 49;
    }
    
    return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!shopArray || [shopArray count] == 0) {
        
        return 1;
    }
    
    return [shopArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!shopArray || [shopArray count] == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"noDataCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([AppUtil isNull:[cell viewWithTag:100]]) {
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT - 64 - 49)];
            label.tag = 100;
            label.text = @"换个关键词试试";
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
        }

        return cell;
    }

    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    cell.backgroundColor = [UIColor clearColor];

    cell.delegate = self;
    cell.index = indexPath.row;

    HomePageDetailList * homepageList = shopArray[indexPath.row];
    
    [cell.shopImage setURL:[NSURL URLWithString:[CommentRequest getCompleteImageURLStringWithSubURL:homepageList.shopImage]]];
    
    cell.shopName.text = homepageList.shopName;
    
    cell.shopThings.text = [NSString stringWithFormat:@"地址:%@",homepageList.shopAddress];
    
    NSString * telPhone = homepageList.smobile;
    
    [cell.phoneButton setTitle:[NSString stringWithFormat:@"电话:%@",telPhone] forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!shopArray || [shopArray count] == 0) {
        
        return;
    }
    
    ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
    
    HomePageDetailList * homepage = shopArray[indexPath.row];
    
    showDetailVC.hidesBottomBarWhenPushed = YES;
    
    showDetailVC.shopID = homepage.ID;
    
    showDetailVC.cShopInfo = homepage;
    
    [self.navigationController pushViewController:showDetailVC animated:YES];
}

#pragma mark - UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//定义展示的Section的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [_productArray count];
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowProductCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary * dic = _productArray[indexPath.row];
    
    [cell.productHeaderImageView setURL:[CommentRequest getCompleteImageURLStringWithSubURL:[dic valueForKey:@"image"]] defaultImage:PLACE_HORDER_IMAGE(cell.productHeaderImageView)];
    
    cell.productName.text = [dic valueForKey:@"name"];
    
    cell.productPrice.text = [NSString stringWithFormat:@"￥%@",[dic valueForKey:@"price"] ];
    
    cell.layer.cornerRadius = 5.f;
    cell.layer.masksToBounds = YES;
    
    cell.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.f].CGColor;
    
    cell.layer.borderWidth = 1.0f;
    
    cell.clipsToBounds = YES;
    
    [cell setNeedsDisplay];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
return CGSizeMake((K_UIMAINSCREEN_WIDTH - 30)/2, (K_UIMAINSCREEN_WIDTH - 30)/2 * 200 / 145);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
        
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}

#pragma mark - Actions

-(void)messageAction {
    
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.chatListVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:appDelegate.chatListVC animated:YES];
}

/////搜搜按钮
- (void)searchAction {
    
    NSString * searchName = self.searchField.text;
    
    if (![CommentRequest networkStatus]) {
        
        [self showAlertViewWithMessage:NO_NETWORK_MESSAGE andImage:nil];
  
    }else {
    
        self.searchName = searchName;
        
        if (self.buttonType == 0) {
            
            if (searchName && ![searchName isEqualToString:@""]) {
                
                [self shopSearchWithKeyname:searchName];
            }

        }
    }
}


- (void)shopSearchWithKeyname:(NSString *)keyName {
    
    NSMutableDictionary *  params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page",keyName,@"sname", nil];
    
    [self showCustomIndicatorWithMessage:@"正在加载中..."];
    
    [commentNetwordRequest POST:SHOPSEARCH_BY_NAME withParams:params success:^(NSDictionary *successDic) {
       
        [self updateFinish];
        [self hideCustomIndicator];
        
       if (refreshing) {
           [shopArray removeAllObjects];
       }
      
        [self loadModel:[successDic valueForKey:@"shops"]];
       
    } failer:^(NSDictionary *failerDic) {
        
        [self updateFinish];
        [self hideCustomIndicator];
        
        [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];
 }

- (void)loadModel:(NSArray *)shops {
    
    for (NSDictionary *dic in shops) {
        
        HomePageDetailList *info = [HomePageDetailList homePageDetailListWithDictionary:dic];
        
        [shopArray addObject:info];
    }
    
    [self.tableView reloadData];
}


@end
