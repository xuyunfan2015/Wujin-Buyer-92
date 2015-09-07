//
//  MapViewController.m
//  wujin-buyer
//
//  Created by jensen on 15/6/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
#import "ShopView.h"
#import "ShowDetailViewController.h"
#import "AppUtil.h"

@interface MapViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKCloudSearchDelegate,ShopViewDelegate>
{
    BMKLocationService* _locService;
    CLLocationCoordinate2D locationCoordinate;
    NSTimer * timer;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic)BMKCloudSearch * cloudSearch;

@property (strong, nonatomic)ShopView * shopView;

@property (assign, nonatomic) BOOL cISRegion;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"地图"];
    [self.navigationBar.rightButton setHidden:YES];
    
    _cloudSearch = [[BMKCloudSearch alloc] init
                    ];
    ///定位操作
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel = 13.6;

    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lookZoomLevel) userInfo:nil repeats:YES];
    
    /////监听地图的zoomLevel
 //   [_mapView addObserver:self forKeyPath:@"zoomLevel" options:NSKeyValueObservingOptionNew context:nil];
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor greenColor];
//    button.frame = CGRectMake(0, 100, 100, 100);
//    [button addTarget:self action:@selector(zm) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(0, 200, 100, 100);
//    [button1 addTarget:self action:@selector(getzm) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button1];
//    button1.backgroundColor = [UIColor redColor];
//    self.button1 = button1;
}

//- (void)zm {
//    
//    _mapView.zoomLevel = 13;
//}
//- (void)getzm {
//    
//    [self.button1 setTitle:[NSString stringWithFormat:@"%.2f",_mapView.zoomLevel] forState:UIControlStateNormal];
//}

-(void)viewWillAppear:(BOOL)animated {
  
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    _cloudSearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _cloudSearch.delegate = nil;
}

//停止定位
-(void)stopLocation
{
    [_locService stopUserLocationService];
   
}

//#pragma mark - 改变
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"zoomLevel"]) {
//        
//        float  zoomLevel = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
//        
//        NSLog(@"zoomLevel:%.2f",zoomLevel);
//        
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

//////查看缩放方式
- (void)lookZoomLevel {
    
    if (self.cISRegion == [self isRegion]) {
        
        return;
    }
    
    self.cISRegion = [self isRegion];
    
    [self getCurrentData];
}

#pragma mark - BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];

     [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    locationCoordinate = userLocation.location.coordinate;
    
    [self stopLocation];

    [self getCurrentData];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark - 获取

- (int)getRadius {
    
    int radius = 0;
    
    float mapZoom = _mapView.zoomLevel;
    
    if(mapZoom < 13.5){ //////小于13.5获取区域的
        radius = 15;
    }else if(mapZoom < 14.5 && mapZoom >= 13.5){
        radius = 12;
    }else if(mapZoom < 15.5 && mapZoom >= 14.5){
        radius = 10;
    }else if(mapZoom < 16.5 && mapZoom >= 15.5){
        radius = 9;
    }else if(mapZoom < 17.5 && mapZoom >= 16.5){
        radius = 6;
    }else{
        radius = 3;
    }
    return radius;
}

- (BOOL)isRegion {
    
    float mapZoom = _mapView.zoomLevel;
    
    if (mapZoom < 13.5) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - 

- (void)getCurrentData {
    
    BMKCloudNearbySearchInfo *cloudNearbySearch = [[BMKCloudNearbySearchInfo alloc]init];
    cloudNearbySearch.ak = @"utpZLxtt8119qgTcdsT57Auf";
    
    if ([self isRegion]) {
        
        cloudNearbySearch.geoTableId = 103989;

    }else {//
        
        cloudNearbySearch.geoTableId = 103990;
    }
    
    cloudNearbySearch.pageIndex = 0;
    cloudNearbySearch.pageSize = 100;
    cloudNearbySearch.location = [NSString stringWithFormat:@"%lf,%lf",locationCoordinate.longitude,locationCoordinate.latitude];
    cloudNearbySearch.radius = [self getRadius] * 1000;
    cloudNearbySearch.keyword = @"*";
    
    BOOL flag = [_cloudSearch nearbySearchWithSearchInfo:cloudNearbySearch];
    
    if(flag)
    {
        NSLog(@"周边云检索发送成功");
    }
    else
    {
        NSLog(@"周边云检索发送失败");
    }
}

#pragma mark implement BMKSearchDelegate

- (void)onGetCloudPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    // 清楚屏幕中所有的annotation
     NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
      
        BMKCloudPOIList* result = [poiResultList objectAtIndex:0];
      
        for (int i = 0; i < result.POIs.count; i++) {
            
            BMKCloudPOIInfo* poi = [result.POIs objectAtIndex:i];
            
             NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:poi.customDict];
            
            MyAnnotation* item = [[MyAnnotation alloc]init];
            
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
            
            item.coordinate = pt;
            
            item.title = poi.title;
            
            if ([AppUtil isNotNull:[poi.customDict valueForKey:@"shopid"]]) {
                
                item.isRegion = NO;
                
                [dic setValue:poi.title forKey:@"name"];
                [dic setValue:poi.address forKey:@"address"];
            
            }else {
                
                item.isRegion = YES;
            }
        
            item.shopInfo = dic;
            [_mapView addAnnotation:item];
            
            if(i == 0)
            {
                _mapView.centerCoordinate = pt;
            }
        }
        
    }else {
        
        NSLog(@"errorCode:%d",error);
   
    }
}

#pragma mark implement BMKMapViewDelegate
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    MyAnnotation * myAnnotation = (MyAnnotation *)annotation;
    
    if (!myAnnotation.isRegion) {
        
        // 生成重用标示identifier
        NSString *AnnotationViewID = @"shopMark";
        
        // 检查是否有重用的缓存
        BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil) {
            
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
            // 设置重天上掉下的效果(annotation)
            ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = NO;
        // 设置是否可以拖拽
        annotationView.draggable = NO;
        return annotationView;

    }else {
        
        // 生成重用标示identifier
        NSString *AnnotationViewID = @"regionMark";
        
        // 检查是否有重用的缓存
        BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil) {
            
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
            // 设置重天上掉下的效果(annotation)
            ((BMKPinAnnotationView*)annotationView).animatesDrop = NO;
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0,0);
        annotationView.annotation = annotation;
        annotationView.image = TTImage(@"circle");
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = NO;
        
        if (![annotationView viewWithTag:100]) {
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(-7, -8, 30, 30)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:9];
            label.textColor = [UIColor whiteColor];
            label.tag = 100;
            //label.center =  CGPointMake(0, -(annotationView.frame.size.height * 0.5));
            [annotationView addSubview:label];
        }
        
        UILabel * label = (UILabel *)[annotationView viewWithTag:100];
        label.text = [myAnnotation.shopInfo valueForKey:@"number"];
    
        // 设置是否可以拖拽
        annotationView.draggable = NO;
        return annotationView;
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
    
    MyAnnotation * annotation = (MyAnnotation *)view.annotation;
    
    if (!annotation.isRegion) {
        
        if (!_shopView) {
            
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShopView" owner:nil options:nil];
            _shopView = [nibView objectAtIndex:0];
            _shopView.delegate = self;
            _shopView.frame = self.view.bounds;
        }
        [_shopView openWithShopInfo:annotation.shopInfo inSuperView:self.view];

    }
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark - ShowViewDelegate

- (void)shopView:(ShopView *)shopView didGotoShop:(NSDictionary *)shopInfo {
    
    NSString * shopID = [shopInfo valueForKey:@"shopid"];
   
    ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
    showDetailVC.shopID = shopID;
    showDetailVC.isFromMap = YES;
    [self.navigationController pushViewController:showDetailVC animated:YES];
}

#pragma mark - Memory Manage

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_mapView) {
//        [_mapView removeObserver:self forKeyPath:@"zoomLevel" context:nil];
        _mapView = nil;
    }
    if (timer) {
        
        [timer invalidate];
        timer = nil;
    }
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
