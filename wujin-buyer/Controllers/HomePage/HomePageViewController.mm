//
//  HomePageViewController.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "HomePageViewController.h"
#import "HomePageHeadCell.h"
#import "HomePageDetailCell.h"
#import "ShopViewController.h"
#import "HomePageDetailList.h"
#import "UserInfo.h"
#import "PositionViewController.h"
//#import "BMapKit.h"

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CLLocationManagerDelegate, selectAddressDelegate>

{
    CLLocationManager *_locationManager;
    BOOL isGetting;//正在获取服务器信息
    
    NSString *_city;
    
//    BMKLocationService *_locService;
}

@property (strong, nonatomic) NSString *subURL;

@property (weak, nonatomic) IBOutlet UITableView *homePageTableView;
@property (strong, nonatomic) NSMutableArray *detailShop;
@property (strong, nonatomic) NSMutableArray *headImages;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *homeScrollView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = RED_COLOR;
    self.navigationController.navigationBar.tintColor = WHITE_COLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:WHITE_COLOR};
    
    self.homePageTableView.tableFooterView = [[UIView alloc] init];
    isGetting = NO;
    
//    _locService = [[BMKLocationService alloc] init];
//    _locService.delegate = self;
    
    [self settingLocation];
    
}


#pragma -mark UITableView -- dataSouce & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_detailShop count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        
        static NSString *_homePageHead = @"HomePageHeadCell";
        
        HomePageHeadCell *_headCell = [tableView dequeueReusableCellWithIdentifier:_homePageHead];
        if (nil == _headCell) {
            
            _headCell = [[HomePageHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_homePageHead];
        }
        
        if (nil != _headImages) {
            
            
            [_headCell loadHomePageHeadCellWithImages:_headImages];
            self.pageControl = _headCell.homePagePageControl;
            self.homeScrollView = _headCell.homeScrollView;
            
            [self.timer invalidate];
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollPage) userInfo:nil repeats:YES];
        }
        
        _headImages = nil;//防止滑动时的重新加载
        
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
        
        return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {//第一行无法点击
        return;
    }
    
    ShopViewController *_shop = [self storyBoardControllerID:@"Main" WithControllerID:@"ShopViewController"];
    
    _shop.hidesBottomBarWhenPushed = YES;
    
    [self performSelector:@selector(prepareForSegue:sender:) withObject:nil];
    
    [self.navigationController pushViewController:_shop animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//被选择的高亮部分消失
}

#pragma -mark ScrollView --delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.homeScrollView) {
        
        self.pageControl.currentPage = scrollView.contentOffset.x/K_UIMAINSCREEN_WIDTH;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

#pragma -mark NSTimer --Action
- (void)scrollPage {
    
    CGPoint point;
    if (self.homeScrollView.contentOffset.x < ([self.homeScrollView.subviews count] - 1)*K_UIMAINSCREEN_WIDTH) {

        point = CGPointMake(K_UIMAINSCREEN_WIDTH*(self.pageControl.currentPage + 1), 0);
        
        [self.homeScrollView setContentOffset:point animated:YES];
    } else {
        
        point = CGPointMake(0, 0);
        
        [self.homeScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    self.pageControl.currentPage = point.x/K_UIMAINSCREEN_WIDTH;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*self.pageControl.currentPage, 0) animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.homeScrollView setContentOffset:CGPointMake(K_UIMAINSCREEN_WIDTH*self.pageControl.currentPage, 0) animated:NO];
}

- (void)viewWillDisapper:(BOOL)animated {

}
//定位  位置更新内容
- (void)settingLocation {
    
    if([CLLocationManager locationServicesEnabled]) {
        
        _subURL = MARKET_URL;
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100.f;
        
        if (SYSTEM_BIGTHAN_8) {
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager requestAlwaysAuthorization];
        }
        
        [_locationManager startUpdatingLocation];
        
        
//        [_locService startUserLocationService];
    } else {
        
        [self updateMarketInfo];
    }
}

//如果无法更新位置
- (void)updateMarketInfo {
    
    NSUserDefaults *_user = [NSUserDefaults standardUserDefaults];
    
    _city = [_user valueForKey:@"cityID"];
    
    _subURL = ADDRESS_URL;
    
    if (nil == _city) {
        
        [self showAlertWithTitle:@"提示" message:@"需要定位服务"];
    } else {
        
        [self getAllHomePageInfo:[NSMutableDictionary dictionaryWithObjectsAndKeys:_city, @"cityID", nil]];
    }
}

#pragma -mark  CLLocationManager -- Delegate
//更新位置成功的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (!isGetting) {
        CLLocation *_loc = [locations firstObject];
        
        [self getAllHomePageInfo:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", @(_loc.coordinate.longitude)], @"longitude",
                                                                                   [NSString stringWithFormat:@"%@", @(_loc.coordinate.latitude)], @"latitude", nil]];
        NSLog(@"%@", [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", @(_loc.coordinate.longitude)], @"longitude",
                      [NSString stringWithFormat:@"%@", @(_loc.coordinate.latitude)], @"latitude", nil]);
        isGetting = YES;
    }
}

//更新位置失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ([error code] == kCLErrorDenied) {
        
        [self showAlertWithTitle:@"提示" message:@"访问被拒绝"];
    } else  if ([error code] == kCLErrorLocationUnknown) {
        
        [self showAlertWithTitle:@"提示" message:@"无法获取位置信息"];
    }

    [self updateMarketInfo];
}

#pragma -mark BMKLocationServiceDelegate代理
//暂时还无

- (void)getAllHomePageInfo:(NSMutableDictionary *)params {
    
    if (nil == params) {
        return;
    }
    
    NSURLRequest *_urlRequest = [CommentRequest createGetURLWithSubURL:_subURL params:params];
    
    [NSURLConnection sendAsynchronousRequest:_urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self performSelectorOnMainThread:@selector(loadModel:) withObject:successDic[@"result"] waitUntilDone:YES];
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertWithTitle:ERROR message:failDic[@"errMsg"]];
            }];
            
        } else {
            
            [self showAlertWithTitle:ERROR message:ERROR_SERVER];
        }
    }];
}

- (void)loadModel:(NSDictionary *)aDic {
    _headImages = [NSMutableArray array];
    _detailShop = [NSMutableArray array];
    
    self.title = aDic[@"area"];
    
    _headImages = aDic[@"images"];
    
    for (NSDictionary *dic in aDic[@"market"]) {
        
        HomePageDetailList *_liset = [HomePageDetailList homePageDetailListWithDictionary:dic];
        
        [_detailShop addObject:_liset];
    }
    
    
    [self.homePageTableView reloadData];
    
    NSUserDefaults *_user = [NSUserDefaults standardUserDefaults];
    
    [_user setValue:aDic[@"cityID"] forKey:@"cityID"];
}

#pragma -mark 准备数据获取
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:nil sender:nil];
    
    PositionViewController *_position = segue.destinationViewController;
    
    _position.cityDelegate = self;
}

- (void)selectAddress:(NSString *)cityID {
    
    if ([GPS isEqualToString:cityID]) {
        
        isGetting = NO;
        [self settingLocation];
    } else {
        
        _subURL = ADDRESS_URL;
        
        [self getAllHomePageInfo:[NSMutableDictionary dictionaryWithObjectsAndKeys:cityID, @"cityID", nil]];
    }
}
@end
