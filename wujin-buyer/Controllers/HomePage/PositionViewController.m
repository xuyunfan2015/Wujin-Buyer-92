//
//  PositionViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/11.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "PositionViewController.h"
#import "City.h"
#import <CoreLocation/CoreLocation.h>
#import "MySearchDisplayController.h"

@interface PositionViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *_cities;//从网络取出数据解析
    NSMutableArray *_spellCities;//检索拼音
    NSMutableArray *_searchCities;//用于search
    NSMutableArray *_spellHeadCities;//用于块头
    
    //上面为拼音
    NSMutableArray *_allCity;
    NSMutableArray *_allSearchCity;
    
    NSInteger _clickSection;
    NSInteger _clickRow;
    NSArray *_showLevelTwo;
    NSArray *_showLevelThree;
    
    //线程。。。离开页面时应该取消所有操作
    commentNetwordRequest *_networdRequest;
}
@property (weak, nonatomic) IBOutlet UITableView *positionTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *positionSearchBar;

@end

@implementation PositionViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"PositionViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"位置"];
    
    self.navigationBar.rightButton.hidden = YES;
    
    self.positionTableView.tableFooterView = [UIView new];
    
    self.positionTableView.sectionIndexBackgroundColor = CLEAR_COLOR;
    self.positionTableView.sectionIndexColor = BLACK_COLOR;
    self.positionTableView.sectionIndexTrackingBackgroundColor = CLEAR_COLOR;
    
    
//   UISearchBar *  searchB = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64,K_UIMAINSCREEN_WIDTH, 44)];
//    [searchB setBackgroundColor:[UIColor colorWithWhite:0.929 alpha:1.000]];
//    [searchB setPlaceholder:@"输入关键词"];
//    [searchB setSearchBarStyle:UISearchBarStyleDefault];
//    
//    MySearchDisplayController  * searchDisplayC = [[MySearchDisplayController alloc] initWithSearchBar:searchB contentsController:self];
//    
//    searchDisplayC.active = NO;
//    searchDisplayC.delegate = self;
//    searchDisplayC.searchResultsDataSource = self;
//    searchDisplayC.searchResultsDelegate = self;
//   // searchDisplayC.searchBar.frame =  CGRectMake(0, 64, K_UIMAINSCREEN_WIDTH, 44);
//    [self.view addSubview:searchDisplayC.searchBar];
    
    
    //无点击项
    _clickSection = -1;
    _clickRow = -1;
    
    [self getAllCity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//进入时从服务器获取地址
- (void)getAllCity {
    
//    if ([CommentRequest networkStatus]) {
//        [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
//        
//        NSURLRequest *_urlRequest = [CommentRequest createGetURLWithSubURL:LOCATION_URL params:nil];
//        
//        [NSURLConnection sendAsynchronousRequest:_urlRequest queue:_operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            
//            if (nil == connectionError) {
//                
//                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
//                    
//                    [self hideCustomIndicator];
//                    [self loadModel:successDic[@"result"]];
//                } fail:^(NSDictionary *failDic) {
//                    
//                    [self showALertViewWithMessage:failDic[@"errMsg"] andImage:nil];
//                }];
//            } else {
//                
//                [self showALertViewWithMessage:ERROR_SERVER andImage:nil];
//            }
//        }];
//    } else {
//        
//       [self showALertViewWithMessage:ERROR_NETWORK andImage:nil];
//    }
    
    [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
    
    [commentNetwordRequest GET:LOCATION_URL withParams:nil success:^(NSDictionary *successDic) {
        
        [self hideCustomIndicator];
        [self loadModel:successDic[@"result"]];
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
    }];
}

//加载模型
- (void)loadModel:(NSDictionary *)aDic {
    
    _allCity = [NSMutableArray array];
    _allSearchCity = [NSMutableArray array];
    
    for (NSDictionary *oneDic in aDic[@"location"]) {
        
        City *province = [City cityWithDiction:oneDic andLevel:kLocationLevelOne];//这是一级
        
        for (NSDictionary *twoDic in oneDic[@"levelTwo"]) {
            
            City *city = [City cityWithDiction:twoDic andLevel:kLocationLevelTwo];//这是二级

            for (NSDictionary *threeDic in twoDic[@"levelThree"]) {
                
                City *county = [City cityWithDiction:threeDic andLevel:kLocationLevelThree];//这是三级
                
                [city.cities addObject:county];//三级开始
                
                [_allSearchCity addObject:county];//搜索
            }
            
            if (0 == [twoDic[@"levelThree"] count]) {
                
                [_allSearchCity addObject:city];//搜索
            }
            
            [province.cities addObject:city];//二级开始
        }
        
        [_allCity addObject:province];//一级开始
    }
    
    [self.positionTableView reloadData];
}

#pragma -mark UITableView -- DataSource & Delegate
//多少块
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.positionTableView) {
        return [_allCity count] + 1;
    } else {
        return 1;
    }
    
}

//块里多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.positionTableView) {
        if (section == _clickSection) {
            
            return [_showLevelTwo count] + [_showLevelThree  count];
        } else {
            
            return 0;
        }
    } else {
        return [_searchCities count];
    }
}

//块头内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.positionTableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 40.f)];
        headerView.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 39.5f)];
        _button.tag = section;
        _button.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _button.tintColor = BLACK_COLOR;
        [_button addTarget:self action:@selector(clickSectionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *_name  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, K_UIMAINSCREEN_WIDTH - 10, 39.5f)];
        
        if (0 == section) {
            
            _name.text = GPS;
            _name.textColor = RED_COLOR;
        } else {
            
            _name.text = [_allCity[section - 1] name];
        }
        
        _name.backgroundColor = CLEAR_COLOR;
        
        [headerView addSubview:_button];
        [headerView addSubview:_name];
        
        return headerView;
    } else {
        return nil;
    }
}

//展开关闭省份
- (void)clickSectionAction:(UIButton *)sender {
    
    if (0 == sender.tag) {//定位系统
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            if ([self.cityDelegate respondsToSelector:@selector(selectAddress:)]) {
                
                [self.cityDelegate selectAddress:GPS];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            
            [self showAlertViewWithMessage:@"请打开定位服务" andImage:nil];
        }
        
        return;
    }
    
    
    if (-1 == _clickSection) {
        
        _clickSection = sender.tag;
        _showLevelTwo = [_allCity[_clickSection - 1] cities];
    } else if (_clickSection == sender.tag) {
        
        _clickSection = -1;
        _clickRow = -1;
        
        _showLevelThree = nil;
        _showLevelTwo = nil;
    }
    else {
        //先去掉前面点击的
        _clickRow = -1;
        _showLevelThree = nil;
        _showLevelTwo = nil;
        [self.positionTableView reloadSections:[NSIndexSet indexSetWithIndex:_clickSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //加上后来的
        _clickSection = sender.tag;
        _showLevelTwo = [_allCity[_clickSection - 1] cities];
    }
    [self.positionTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//块头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.positionTableView) {
        return 40.f;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.positionTableView) {
        
        static NSString *_position = @"PositionCell";
        
        UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_position];
        
        if (nil == _cell) {
            
            _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_position];
        }
        
        if (-1 == _clickRow) {
            
            [_cell setSeparatorInset:UIEdgeInsetsMake(0, 30, 0, 0)];
            _cell.textLabel.font = [UIFont systemFontOfSize:16.f];
            _cell.textLabel.text = [_showLevelTwo[indexPath.row] name];
            
            if (0 != [[_showLevelTwo[indexPath.row] cities] count]) {
                _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                _cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else {
            
            NSInteger row = [self locationWhere:indexPath];
            
            if (kLocationLevelThree == [self locationLevel:indexPath]) {//三层
                
                [_cell setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 0)];
                _cell.textLabel.font = [UIFont systemFontOfSize:15.f];
                _cell.textLabel.text = [_showLevelThree[row] name];
                _cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                
                [_cell setSeparatorInset:UIEdgeInsetsMake(0, 30, 0, 0)];
                _cell.textLabel.font = [UIFont systemFontOfSize:16.f];
                _cell.textLabel.text = [_showLevelTwo[row] name];
                
                if (0 != [[_showLevelTwo[row] cities] count]) {
                    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                } else {
                    _cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
        
        return _cell;
    } else {
        
        static NSString *_search = @"Search";
        
        UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_search];
        
        if (nil == _cell) {
            
            _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_search];
        }
        
        _cell.textLabel.text = [_searchCities[indexPath.row] name];
        
        return _cell;
    }
}

//展开关闭市区或者选择地区
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.positionTableView) {
        
        if (kLocationLevelThree == [self locationLevel:indexPath]) {
            
            NSInteger row = [self locationWhere:indexPath];
            
            if ([self.cityDelegate respondsToSelector:@selector(selectAddress:)]) {
                
                [self.cityDelegate selectAddress:[_showLevelThree[row] ID]];//选择了三级城市
            }
            [self.navigationController popViewControllerAnimated:YES];
       
        } else {
            
            NSInteger row = [self locationWhere:indexPath];
            
            if (_clickRow == row) {
                
                _clickRow = -1;
                _showLevelThree = nil;
                
                [self.positionTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (0 == [[_showLevelTwo[row] cities] count]) {
                
                if ([self.cityDelegate respondsToSelector:@selector(selectAddress:)]) {
                    
                    [self.cityDelegate selectAddress:[_showLevelTwo[row] ID]];//选择了二级城市
                }
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
                _clickRow = row;
                _showLevelThree = [_showLevelTwo[row] cities];
                
                [self.positionTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }

    } else {
        
        if ([self.cityDelegate respondsToSelector:@selector(selectAddress:)]) {
            
            [self.cityDelegate selectAddress:[_searchCities[indexPath.row] ID]];//选择了搜索栏
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//等级制度
- (kLocationLevel)locationLevel:(NSIndexPath *)indexPath {
    
    if (-1 == _clickRow) {
        
        return kLocationLevelTwo;
    } else {
        
        if (indexPath.row > _clickRow && indexPath.row <= _clickRow + [_showLevelThree count]) {
            
            return kLocationLevelThree;
        } else {
            
            return kLocationLevelTwo;
        }
    }
}

//点在哪一行
- (NSInteger)locationWhere:(NSIndexPath *)indexPath {
    
    if (-1 == _clickRow) {
        
        return indexPath.row;
    } else {
        
        if (indexPath.row <= _clickRow) {
            
            return indexPath.row;
        } else if (indexPath.row <= _clickRow + [_showLevelThree count]) {
            
            return _clickRow + [_showLevelThree count] - indexPath.row;
        } else {
            
            return indexPath.row - (_clickRow + [_showLevelThree count]);
        }
    }
}

#pragma -mark ---UISearchDisplayDelegate
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
    controller.searchResultsTableView.tableFooterView = [UIView new];

    
//    [controller.searchContentsController.view addSubview:<#(UIView *)#>];
    
//    [controller.searchBar  setShowsCancelButton:YES animated:NO];
//    
//    for (UIView *button in [controller.searchBar.subviews[0] subviews]) {
//        
//        if ([@"UINavigationButton" isEqualToString:NSStringFromClass([button class])]) {
//            
//            UIButton *custom = (UIButton *)button;
//            
//            [custom setTitle:@"取消" forState:UIControlStateNormal];
//        }
//    }
}

#pragma -mark searchBar--delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchCities = [NSMutableArray array];
    
    if (0 == searchText.length) {

        return;
    }
    
    for (NSInteger i = 0; i < [_allSearchCity count]; ++i) {
        
        City *_city = _allSearchCity[i];
        if (NSNotFound != [_city.name rangeOfString:searchText].location) {
            
            [_searchCities addObject:_city];
        }
    }
}

#pragma -mark 汉字转拼音
- (void)chineseChangeSpell:(NSArray *)aCities {
    
    _spellCities = [NSMutableArray array];
    _spellHeadCities = [NSMutableArray array];
    _allCity = [NSMutableArray array];
    
    if (nil != aCities) {
        
        for (NSString *_city in aCities) {
            
            NSMutableString *_ms = [[NSMutableString alloc] initWithString:_city];
            
            if (CFStringTransform((__bridge CFMutableStringRef)_ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
                
            if (CFStringTransform((__bridge CFMutableStringRef)_ms, 0, kCFStringTransformStripDiacritics, NO)) {
                
                [_spellCities addObject:_ms];
            }
        }
    }
    
    [_cities sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSInteger i = [_cities indexOfObject:obj1];
        NSInteger j = [_cities indexOfObject:obj2];
        
        return [_spellCities[i] compare:_spellCities[j]];
    }];
    
    [_spellCities sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    //将城市按拼音头字母分好
    BOOL clickValueAtIndex = NO;
    NSMutableArray *tempArray = nil;
    for (NSInteger i = 0; i < [aCities count]; ++i) {
        
        NSString *sr = [_spellCities[i] substringToIndex:1];
        
        if (![_spellHeadCities containsObject:[sr uppercaseString]]) {
            
            [_spellHeadCities addObject:[sr uppercaseString]];
            tempArray = [[NSMutableArray alloc] init];
            clickValueAtIndex = NO;
        }
        
        if ([_spellHeadCities containsObject:[sr uppercaseString]]) {
            [tempArray addObject:aCities[i]];
            
            if (NO == clickValueAtIndex) {
                
                [_allCity addObject:tempArray];
                clickValueAtIndex = YES;
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"PositionViewController"];
    //线程。。。离开页面时应该取消所有操作
    if (nil != _networdRequest) {
        
        [_networdRequest cancelGET];
    }
}

@end
