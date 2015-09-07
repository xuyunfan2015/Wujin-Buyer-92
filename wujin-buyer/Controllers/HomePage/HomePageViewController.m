    //
//  HomePageViewController.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageHeadCell.h"
#import "HomePageDetailCell.h"
#import "ShopViewController.h"
#import "HomePageDetailList.h"
#import <CoreLocation/CoreLocation.h>
#import "UserInfo.h"
#import "PositionViewController.h"
#import "AppDelegate.h"
#import "ChatListViewController.h"
#import "EnterViewController.h"
#import "ShowDetailViewController.h"
#import "FirstEnterLinQi.h"
#import "MapViewController.h"
#import "ShopWebViewController.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CLLocationManagerDelegate, selectAddressDelegate, BMKLocationServiceDelegate, enterToLinQiDelegate, UIAlertViewDelegate,UITabBarControllerDelegate>

{
    CLLocationManager *_locationManager;
    BOOL isGetting;//正在获取服务器信息
    
    NSString *_city;
    
    CLLocationCoordinate2D locationCoordinate;//定位的经纬度
    
    BMKLocationService *_locService;
    
    commentNetwordRequest *_networdRequest;
    
    BOOL isFirst;//第一次进入应用
    BOOL isFirstEnterApp;//每次第一次打开
    
    //介绍页面
    FirstEnterLinQi *_first;
    
    //首页
    HomePageHeadCell *_headCell;
}

@property (strong, nonatomic) UIActivityIndicatorView *navIndicator;

@property (strong, nonatomic) UIScrollView *firstEnterApp;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (strong, nonatomic) NSString *subURL;

@property (weak, nonatomic) IBOutlet UITableView *homePageTableView;
@property (strong, nonatomic) NSMutableArray *detailShop;
@property (strong, nonatomic) NSMutableArray *headImages;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *homeScrollView;
@property (strong,nonatomic)  NSArray *getheadimges;
@end

@implementation HomePageViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"HomePageViewController"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"HomePageViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFirstEnterApp = YES;
    
     [self layoutNavigationBarWithString:@"上海市"];
    
    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:nil];
    
    //更改一下左键图标
    [self.navigationBar.leftButton setImage:[UIImage imageNamed:@"gray_weizhi"] forState:UIControlStateNormal];
    [self initUnreadView];///初始化
    
    //[self initFooterViewWithTableView:self.homePageTableView];
   
  //  self.homePageTableView.scrollEnabled = NO;
    self.homePageTableView.tableFooterView = [[UIView alloc] init];
    
    [self settingTabbar];
    
   // [self getBannerImages];
    
    [self settingLocation];
    //先请掉图片
    [self.navigationBar.rightButton setImage:nil forState:UIControlStateNormal];
}

- (void)updateInfomations {
    
    [self getAllHomePageInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (isFirstEnterApp) {
        isFirstEnterApp = NO;
        
        NSUserDefaults *_user = [NSUserDefaults standardUserDefaults];
        
        if ([[_user valueForKey:@"FirstEnter"] boolValue]) {
            
            isFirst = YES;
            
            _first = [FirstEnterLinQi firstEnterLinQi];
            _first.scroll.delegate = self;
            _first.enterDelegate = self;
            [_first show];
            
            [_user setValue:@"NO" forKey:@"FirstEnter"];
        } else {
            
            isFirst = NO;
            //[self settingLocation];
        }
    }
    
    self.tabBarController.delegate = self;
    
    if (1 == self.pageControl.numberOfPages) {
        
        [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage), 0) animated:NO];
    } else {
        
        [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage + 1), 0) animated:NO];
        
        if (nil != _timer) {
            
            [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.0f]];
        }
    }
}

#pragma -mark enterToLinQiDelegate
- (void)didEnterToLinQi {
    
    //[self settingLocation];
}

- (void)settingTabbar {
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.996 green:0.000 blue:0.000 alpha:1.000];
    
    for (NSInteger i = 0; i < self.tabBarController.tabBar.items.count; ++i) {
        
        UITabBarItem *item = self.tabBarController.tabBar.items[i];
        
        NSString *imageName = [NSString stringWithFormat:@"main_btn_%@", @(i)];
        NSString *selectesImageName = [NSString stringWithFormat:@"main_selected_btn_%@", @(i)];
        
        item.image = [UIImage imageNamed:imageName];
        item.selectedImage = [UIImage imageNamed:selectesImageName];
    
       
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                 NSForegroundColorAttributeName : [UIColor colorWithRed:0.518 green:0.510 blue:0.510 alpha:1.000]}
                                                                        forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                 NSForegroundColorAttributeName : [UIColor colorWithRed:0.996 green:0.000 blue:0.000 alpha:1.000]}
                                                                        forState:UIControlStateSelected];
    }
}

#pragma -mark UITableView -- dataSouce & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_detailShop count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        
        if (_headCell) {
            
            return _headCell;
        }
        
        static NSString *_homePageHead = @"HomePageHeadCell";
        
       _headCell = [tableView dequeueReusableCellWithIdentifier:_homePageHead];
       
        if (nil == _headCell) {
            
            _headCell = [[HomePageHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_homePageHead];
        }
        
        return _headCell;
   
    } else {
        
        static NSString *_homePageDetail = @"HomePageDetailCell";
        
        HomePageDetailCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_homePageDetail];
        if (nil == _detailCell ) {
            
            _detailCell = [[HomePageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_homePageDetail];
        }
        
        [_detailCell loadHomePageDetailWithDetailList:_detailShop[indexPath.row - 1]];
        
        return _detailCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        
        return 168;
    } else {
       // return 50+20;
        return 87+20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {//第一行无法点击
        return;
    }
    
//    ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
//    
//    HomePageDetailList * homepage = _detailShop[indexPath.row - 1];
//    
//    showDetailVC.hidesBottomBarWhenPushed = YES;
//    
//    showDetailVC.shopID = homepage.ID;
//    
//    showDetailVC.cShopInfo = homepage;
//    
//    [self.navigationController pushViewController:showDetailVC animated:YES];
    
    ShopWebViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShopWebViewController"];
    
    HomePageDetailList * homepage = _detailShop[indexPath.row - 1];
    
    showDetailVC.hidesBottomBarWhenPushed = YES;
    
    showDetailVC.shopID = homepage.ID;
    
    showDetailVC.cShopInfo = homepage;
    
    [self.navigationController pushViewController:showDetailVC animated:YES];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//被选择的高亮部分消失
}

#pragma -mark ScrollView --delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.homeScrollView) {
        
        NSInteger currentPage = scrollView.contentOffset.x/K_UIMAINSCREEN_WIDTH - 1;
        
        if (currentPage == self.pageControl.numberOfPages) {
            
            self.pageControl.currentPage = 0;
            
            [scrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH, 0)];
        } else if (-1 == currentPage) {
            
            self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
            
            [scrollView setContentOffset:CGPointMake(self.pageControl.numberOfPages * K_UIMAINSCREEN_WIDTH, 0)];
    
        } else {
            
            self.pageControl.currentPage = currentPage;
        }
        
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.f]];
    } else if (scrollView == _first.scroll) {
        
        _first.page.currentPage = _first.scroll.contentOffset.x/K_UIMAINSCREEN_WIDTH;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.homeScrollView) {
        
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollPage {
    
    CGPoint point;
//    if (self.homeScrollView.contentOffset.x < ([self.homeScrollView.subviews count])*K_UIMAINSCREEN_WIDTH) {

    point = CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage + 2), 0);
        
    [self.homeScrollView setContentOffset:point animated:YES];
//    } else {
//        
//        point = CGPointMake(0, 0);
//        
//        [self.homeScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
    
    NSInteger currentPage = point.x/K_UIMAINSCREEN_WIDTH - 1;
    
    if (currentPage == self.pageControl.numberOfPages) {
        
        self.pageControl.currentPage = 0;
    } else {
        
        self.pageControl.currentPage = currentPage;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (scrollView == self.homeScrollView) {
        
        if (0 == self.pageControl.currentPage) {
            
            [scrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH, 0)];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (nil != _networdRequest)
        [_networdRequest cancelGET];
    
    if (1 == self.pageControl.numberOfPages) {
        
        [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage), 0) animated:NO];
    } else {
        
        [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage + 1), 0) animated:NO];
        
        if (nil != _timer) {
            
            [_timer setFireDate:[NSDate distantFuture]];
        }
    }
}

//定位  位置更新内容
- (void)settingLocation {
    
    if([CLLocationManager locationServicesEnabled]) {
        
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        [_locService startUserLocationService];
   
    } else {
        
        page = 1;
        refreshing = YES;
        locationCoordinate = CLLocationCoordinate2DMake(31.22, 121.48);
        [self getAllHomePageInfo];
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"到\n 设置-隐私-定位服务 \n 开启定位服务,可获更精准的数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
     }
}


#pragma -mark BMKLocationServiceDelegate
//百度地图更新位置成功
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
        
    CLLocation *_loc = userLocation.location;
    
    locationCoordinate = _loc.coordinate;
    
    page = 1;
    refreshing = YES;
    [self getAllHomePageInfo];

    [_locService stopUserLocationService];
}

//百度地图更新失败
- (void)didFailToLocateUserWithError:(NSError *)error {
    
    NSString *message = nil;
    
    /////////////////////////////////////////
    self.navigationBar.title.text = self.title;
    self.navigationBar.leftButton.userInteractionEnabled = YES;
    [self.navIndicator removeFromSuperview];
    /////////////////////////////////////////////////////////////////////////
    if ([error code] == kCLErrorDenied) {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];

        message = [NSString stringWithFormat:@"到\n 设置-隐私-定位服务-%@ \n 开启定位服务,可获取更精准的数据", app_Name];
        
    } else  if ([error code] == kCLErrorLocationUnknown) {
        
          locationCoordinate = CLLocationCoordinate2DMake(31.22, 121.48);
        message = @"无法获取位置信息,定位成功可以获取更精准数据";
    }
    
    locationCoordinate = CLLocationCoordinate2DMake(31.22, 121.48);
    
    page = 1;
    refreshing = YES;
    [self getAllHomePageInfo];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新定位", nil];
    
    alertView.tag = 520;
    
    [alertView show];
}


#pragma mark - 获取数据

- (void)getAllHomePageInfo {
    
    _networdRequest = [commentNetwordRequest POST:ALL_SHOPS withParams:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page],@"page",[NSNumber numberWithDouble:locationCoordinate.longitude],@"long1",[NSNumber numberWithDouble:locationCoordinate.latitude] ,@"lat1",nil] success:^(NSDictionary *successDic) {
        
        [self updateFinish];
        
        
        _networdRequest = [commentNetwordRequest POST:BANNER_URL withParams:nil success:^(NSDictionary *imagedata) {
            
            self.getheadimges=[imagedata objectForKey:@"data"];
            [self performSelectorOnMainThread:@selector(loadModel:) withObject:successDic waitUntilDone:YES];
            
        } failer:^(NSDictionary *failerDic) {
            
            [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
        }];

        
        
   
    } failer:^(NSDictionary *failerDic) {
        
        [self updateFinish];
        
       // [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];
}
//
-(void)getBannerImages {
    
    _networdRequest = [commentNetwordRequest POST:BANNER_URL withParams:nil success:^(NSDictionary *successDic) {
        
        self.getheadimges=[successDic objectForKey:@"data"];
        
        
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];

}

- (void)loadModel:(NSDictionary *)aDic {
    
    //////////////////头图///////////////////////
//    NSArray * shopimgs = [aDic valueForKey:@"shops"];
   // [self getBannerImages];
    NSArray * shopimgs = self.getheadimges;

    if (!_headImages && ([shopimgs count] > 0)) {
        
        _headImages = [[NSMutableArray alloc] initWithCapacity:0];
        
        if ([shopimgs count] > 5) {
            
            for (int index = 0;index < 5; index ++) {
              
                [_headImages addObject:shopimgs[index]];
            }
            
        }else {
            
            [_headImages addObjectsFromArray:shopimgs];
        }
        
        [_headCell loadHomePageHeadCellWithImages:_headImages];
        self.pageControl = _headCell.homePagePageControl;
        self.homeScrollView = _headCell.homeScrollView;
        
        [self.homeScrollView setContentOffset:CGPointMake(0, 0)];
        
        [self.timer invalidate]; self.timer = nil;
        
        if (_headImages.count > 1) {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollPage) userInfo:nil repeats:YES];
            [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH, 0)];
            
        } else {
            
            [self.homeScrollView setContentOffset:CGPointZero];
        }
    }
  
    ///////////列表的值//////////////

    if (!_detailShop) {
        
        _detailShop = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if (refreshing) {
        
        [_detailShop removeAllObjects];
    }
    
    for (NSDictionary *dic in aDic[@"shops"]) {
        
        HomePageDetailList *_list = [HomePageDetailList homePageDetailListWithDictionary:dic];
        
        [_detailShop addObject:_list];
    }
    [self.homePageTableView reloadData];
}

#pragma -mark 准备数据获取
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:nil sender:nil];
    
    if ([segue.destinationViewController isKindOfClass:[PositionViewController class]]) {
        
        PositionViewController *_position = segue.destinationViewController;
        _position.cityDelegate = self;
    }
}

#pragma mark - NavigationViewDelegate

- (void)navigationViewLeftButton:(UIButton *)sender {
    
    MapViewController * mapViewController = [self storyBoardControllerID:@"Other" WithControllerID:@"MapViewController"];
    mapViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mapViewController animated:YES];
}


@end
