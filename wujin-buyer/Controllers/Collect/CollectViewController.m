//
//  CollectionViewController.m
//  wujin-buyer
//
//  Created by wujin on 14/12/31.
//  Copyright (c) 2014年 wujin. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectShopCell.h"
#import "CollectProductCell.h"
#import "UserInfo.h"

@interface CollectViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *_collectShop;
    NSMutableArray *_collectProduct;
    NSMutableArray *_removeArr;
    
    
    commentNetwordRequest *_networdRequest;
}
@property (strong, nonatomic) NSString *subURL;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet UITableView *collectTableView;

@property (weak, nonatomic) IBOutlet UIView *downLine;
@property (strong, nonatomic) UISegmentedControl *segment;

@end

@implementation CollectViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"CollectViewController"];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.downLine.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:@"我的收藏"];
    self.navigationBar.rightButton.hidden = YES;
    
    if (!self.isFromMember) {
        
        self.navigationBar.leftButton.hidden = YES;
    }
     self.collectTableView.bounces = NO;
    self.collectTableView.tableFooterView = [UIView new];
   
    
    _collectProduct = [[NSMutableArray alloc] init];
    _collectShop = [[NSMutableArray alloc] init];
    _removeArr = [[NSMutableArray alloc] init];
    
    [self addSeguedControl];
}

//增加分段控件
- (void)addSeguedControl {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,K_UIMAINSCREEN_WIDTH , 40)];
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"收藏店铺", @"收藏商品"]];
    _segment.frame = CGRectMake(10, 5, K_UIMAINSCREEN_WIDTH - 20, 30);
    
     headerView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:_segment];
    
    _segment.tintColor = [UIColor colorWithRed:0.941 green:0.000 blue:0.000 alpha:1.000];
    [_segment addTarget:self  action:@selector(segmentChange) forControlEvents:UIControlEventValueChanged];
    [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:GRAY_COLOR, NSFontAttributeName:[UIFont systemFontOfSize:16.f]} forState:UIControlStateNormal];
    
//    UIImage *image = [UIImage imageNamed:@"gray_line"];
//    
//    UIImageView *upImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 1)];
//    upImage.image = image;
//    
//    UIImageView *downImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, K_UIMAINSCREEN_WIDTH, 1)];
//    downImage.image = image;
//    
//    upImage.transform = CGAffineTransformMakeScale(1, 0.5f);
//    downImage.transform = CGAffineTransformMakeScale(1, 0.5f);
//    
//    [headerView addSubview:upImage];
//    [headerView addSubview:downImage];
    
   // upImage.hidden = YES;
    
    if (self.isCollectProduct) {
        _segment.selectedSegmentIndex = 1;
    } else {
        _segment.selectedSegmentIndex = 0;
    }
    
    self.collectTableView.tableHeaderView = headerView;
}

#pragma -mark UITableView --Datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == _segment.selectedSegmentIndex) {
        
        return [_collectShop count];
    } else {
        
        return [_collectProduct count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == _segment.selectedSegmentIndex) {
        
        static NSString *_collectShopCell = @"collectShopCell";
        
        CollectShopCell *_cell = [tableView dequeueReusableCellWithIdentifier:_collectShopCell];
        
        if (nil == _cell) {
            
            _cell = [[CollectShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_collectShopCell];
        }
        
        [_cell loadCollectShopCellWithShopInfo:_collectShop[indexPath.row]];
        
        return _cell;
    } else {
        
        static NSString *_collectProductCell = @"collectProductCell";
        
        CollectProductCell *_cell = [tableView dequeueReusableCellWithIdentifier:_collectProductCell];
        
        if (nil == _cell) {
            
            _cell = [[CollectProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_collectProductCell];
        }
        
        [_cell loadCollectProductCellWithProductInfo:_collectProduct[indexPath.row]];
        
        return _cell;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//取消选择
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (YES == self.collectTableView.editing) {
        
        if (0 == self.segment.selectedSegmentIndex) {
            
            [_removeArr removeObject:_collectShop[indexPath.row]];
        } else {
            [_removeArr removeObject:_collectProduct[indexPath.row]];
        }
    }
}

//选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (YES == self.collectTableView.editing) {
        
        if (0 == self.segment.selectedSegmentIndex) {
            
            [_removeArr addObject:_collectShop[indexPath.row]];
        } else {
            [_removeArr addObject:_collectProduct[indexPath.row]];
        }
    } else {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (0 == self.segment.selectedSegmentIndex) {
            
            [self selectShopInfoWith:[_collectShop[indexPath.row] ID]];
        } else {
            [self selectProductInfo:[_collectProduct[indexPath.row] ID]];
        }
    }
}

#pragma -mark segment--Action
- (void)segmentChange {
    
    [_removeArr removeAllObjects];
    
    [self.collectTableView reloadData];
}

- (IBAction)navigationViewRightButton:(UIButton *)sender {
    
    if (YES == self.collectTableView.editing) {
        
        if (0 != [_removeArr count]) {
            
            [[[UIAlertView alloc] initWithTitle:@"警告" message:@"你确定要删除这些收藏物品吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        } else {
        
            [sender setTitle:@"编辑" forState:UIControlStateNormal];
            
            [sender setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
            
            [self.collectTableView setEditing:NO animated:YES];
        }
    } else {
        
        [_removeArr removeAllObjects];
        
        [self.collectTableView setEditing:YES animated:YES];
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        [sender setTitleColor:RED_COLOR forState:UIControlStateNormal];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        if ([CommentRequest networkStatus]) {
            [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
        
            [self performSelectorOnMainThread:@selector(deleteCollect) withObject:self waitUntilDone:YES];
        } else {
            
            [self showAlertViewWithMessage:ERROR_NETWORK andImage:nil];
        }
    }
}

- (void)deleteCollect {
    
    if (0 == self.segment.selectedSegmentIndex) {
        _subURL = COLLECT_SHOP_DELEGATE_URL;
    } else {
        _subURL = COLLECT_PRODUCT_DELETE_URL;
    }
    
    NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", hostUrl, _subURL]];
    
    NSMutableURLRequest *_urlRequest = [[NSMutableURLRequest alloc] initWithURL:_url];
    
    NSMutableString *_paramString = [NSMutableString stringWithFormat:@"%@=%@&%@=", @"buyerID", [[UserInfo sharedUserInfo] userID], @"ID"];
    
    for (id pa in _removeArr) {
        [_paramString appendFormat:@"%@,", [pa ID]];
    }
    
    [_urlRequest setHTTPMethod:@"POST"];
    [_urlRequest setHTTPBody:[_paramString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:_urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError && nil != data) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [self performSelectorOnMainThread:@selector(deleteForArray) withObject:nil waitUntilDone:YES];
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:failDic[@"errMsg"] andImage:nil];
            }];
        } else {
            
            [self showAlertViewWithMessage:ERROR_SERVER andImage:nil];
        }
    }];
}

- (void)deleteForArray {
    
    [self hideCustomIndicator];
    
    NSMutableArray *_removeRow = [NSMutableArray array];
    
    if (0 == self.segment.selectedSegmentIndex) {
        for (CollectShopInfo *info in _removeArr) {
            NSInteger row = [_collectShop indexOfObject:info];
            
            NSIndexPath *_indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            
            [_removeRow addObject:_indexPath];
        }
        
        [_collectShop removeObjectsInArray:_removeArr];
        
        NSString *collectShopStr = [[UserInfo sharedUserInfo] collectShop];
        
        NSUInteger collectShop = [collectShopStr intValue] - _removeArr.count;
        
        [[UserInfo sharedUserInfo] setCollectShop:[[NSString alloc] initWithFormat:@"%@", @(collectShop)]];
    } else {
        for (CollectProductInfo *info in _removeArr) {
            NSInteger row = [_collectProduct indexOfObject:info];
            
            NSIndexPath *_indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            
            [_removeRow addObject:_indexPath];
        }
        
        [_collectProduct removeObjectsInArray:_removeArr];
        
        NSString *collectProductStr = [[UserInfo sharedUserInfo] collectProduct];
        
        NSUInteger collectProduct = [collectProductStr intValue] - _removeArr.count;
        
        [[UserInfo sharedUserInfo] setCollectProduct:[[NSString alloc] initWithFormat:@"%@", @(collectProduct)]];
    }
    
    [_removeArr removeAllObjects];
    
    [self.collectTableView deleteRowsAtIndexPaths:_removeRow withRowAnimation:UITableViewRowAnimationBottom];
    
    _removeRow = nil;
}

//进入时重新加载数据
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"CollectViewController"];
    
//    if ([self isEnterServer]) {
//        
//        _subURL = ALL_COLLECTS;
//        NSString *ID = [[UserInfo sharedUserInfo] userID];
//        
//        _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:ID, @"uid", nil];
//        
//        if (nil != ID) {
//            
//            _networdRequest = [commentNetwordRequest POST:_subURL withParams:_params success:^(NSDictionary *successDic) {
//                
//                [self loadModel:successDic[@"result"]];
//          
//            } failer:^(NSDictionary *failerDic) {
//                
//                [self showAlertViewWithMessage:failerDic[@"errMsg"] andImage:nil];
//            }];
//        }
//    }
}

//将数据装进模型
- (void)loadModel:(NSDictionary *)aDic {
    
    if (nil != aDic) {
        
        [_collectShop removeAllObjects];
        [_collectProduct removeAllObjects];
        
        NSArray *_aArr = aDic[@"collect_shop_list"];
        NSArray *_bArr = aDic[@"collect_product_list"];
        
        for (NSDictionary *dic in _aArr) {
            
            CollectShopInfo *_info = [CollectShopInfo collectShopInfoWithDictionary:dic];
            
            [_collectShop addObject:_info];
        }
        
        for (NSDictionary *dic in _bArr) {
            
            CollectProductInfo *_info = [CollectProductInfo collectProductInfoWithDictionary:dic];
            
            [_collectProduct addObject:_info];
        }
        
        [self.collectTableView reloadData];
    }
}
@end
