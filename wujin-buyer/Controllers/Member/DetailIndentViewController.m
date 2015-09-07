//
//  DetailIndentViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/14.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "DetailIndentViewController.h"
#import "DetailIndentCell.h"
#import "ShopNameCell.h"
#import "UserInfo.h"

@interface DetailIndentViewController () <UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *_shopNames;
    NSMutableArray *_shopVIPs;
    NSArray *_productNames;
    
    NSMutableDictionary *_allIndent;
    
    NSMutableDictionary *_showIndent;
    
    NSString *_subURL;
    
    commentNetwordRequest *_networdRequest;
}

@property (weak, nonatomic) IBOutlet UITableView *detailIndentTableView;

@end

@implementation DetailIndentViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"DetailIndentViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"DetailIndentViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"订单详情"];
    
    self.detailIndentTableView.tableFooterView = [UIView new];
    
    [self.detailIndentTableView registerNib:[self getNibByIdentifity:@"ShopNameCell"] forCellReuseIdentifier:@"ShopNameCell"];
    
    if (nil != self.indentInfo) {
        
        [self getIndentDetail:self.indentInfo.ID];
    }
    
    //注册
    [self.detailIndentTableView registerNib:[self getNibByIdentifity:@"DetailIndentCell"] forCellReuseIdentifier:@"DetailIndentCell"];
}

- (void)getIndentDetail:(NSString *)ID {
    
    NSMutableDictionary *_params = [NSMutableDictionary dictionaryWithObjectsAndKeys:ID, @"indentID", [[UserInfo sharedUserInfo] userID], @"buyerID",[[UserInfo sharedUserInfo] token], @"token", nil];
    
    if (self.sellerID) {
        
        [_params setValue:self.sellerID forKey:@"sellerID"];
    } else {
        
        [_params setValue:@"" forKey:@"sellerID"];
    }
    
    _subURL = DETAIL_INDENT_URL;
    
    [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
    
//    NSURLRequest *_urlRequest = [CommentRequest createGetURLWithSubURL:_subURL params:_params];
//    
//    [NSURLConnection sendAsynchronousRequest:_urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (nil == connectionError) {
//            
//            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
//                
//                [self loadModel:successDic[@"result"]];
//            } fail:^(NSDictionary *failDic) {
//                
//                [self showALertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
//            }];
//        } else {
//            
//            [self showALertViewWithMessage:ERROR_SERVER andImage:nil];
//        }
//    }];
    
    _networdRequest = [commentNetwordRequest GET:_subURL withParams:_params success:^(NSDictionary *successDic) {
        
        [self hideCustomIndicator];
        
        [self addHeaderView];
        [self addFooterView];
        
        [self loadModel:successDic[@"result"]];
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        
        [self tokenLogoff:failerDic];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 增加点新的东西。。。
- (void)addHeaderView {
    
    UILabel *_lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, K_UIMAINSCREEN_WIDTH - 10, 30)];
    
    _lab.text = [NSString stringWithFormat:@"订单号:%@", self.indentInfo.name];
    _lab.textColor = RGBCOLOR(214, 37, 42);
    _lab.font = [UIFont systemFontOfSize:16.f];
    
    UIView *_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 40)];
    
    _headerView.backgroundColor = WHITE_COLOR;
    
    [_headerView addSubview:_lab];
    
    self.detailIndentTableView.tableHeaderView = _headerView;
    
    [self.detailIndentTableView setSeparatorInset:UIEdgeInsetsZero];
}

- (void)addFooterView {
    
    UILabel *_lab = [[UILabel alloc] init];
    
    _lab.text = [NSString stringWithFormat:@"￥%@", self.indentInfo.money];
    _lab.font = [UIFont systemFontOfSize:18.f];
    _lab.textAlignment = NSTextAlignmentRight;
    _lab.textColor = BLACK_COLOR;
    
    CGSize size = [_lab sizeThatFits:CGSizeMake(K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT)];
    _lab.frame = CGRectMake(K_UIMAINSCREEN_WIDTH - size.width - 10, 12, size.width, 20);
    
    UILabel *_total = [[UILabel alloc] initWithFrame:CGRectMake(_lab.frame.origin.x - 50, 12, 50, 20)];
    
    _total.textAlignment = NSTextAlignmentRight;
    
    _total.font = [UIFont systemFontOfSize:14.f];
    _total.text = @"总计:";
    _total.textColor = BLACK_COLOR;
    
    UILabel *_freight = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, K_UIMAINSCREEN_WIDTH/2, 20)];
    _freight.font = [UIFont systemFontOfSize:13.f];
    _freight.text = [NSString stringWithFormat:@"运费:￥%@", self.indentInfo.freight];
    _freight.textColor = BLACK_COLOR;
    
    if (0 == [self.indentInfo.isNotFreight intValue]) {
        
        NSUInteger length = [_freight.text length];
        
        NSMutableAttributedString *strAttr = [[NSMutableAttributedString alloc] initWithString:_freight.text]; //绘制删除线
        [strAttr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) range:NSMakeRange(0, length)];
        [strAttr addAttribute:NSStrikethroughColorAttributeName value:BLACK_COLOR range:NSMakeRange(0, length)];
        
        [_freight setAttributedText:strAttr];
    }
    
    UIView *_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 44)];
    
    UIView *_showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 44)];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 1)];
    
    line.image = [UIImage imageNamed:@"gray_line"];
    
    line.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, K_UIMAINSCREEN_WIDTH, 1)];
    line1.image = [UIImage imageNamed:@"gray_line"];
    line1.transform = CGAffineTransformMakeScale(1.f, 0.5f);
    
    _showView.backgroundColor = WHITE_COLOR;
    
    [_showView addSubview:_lab];
    
    if (!self.sellerID) [_showView addSubview:_freight];

    [_showView addSubview:_total];
    [_showView addSubview:line];
    [_showView addSubview:line1];
    
    [_footerView addSubview:_showView];
    
    _footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.detailIndentTableView.tableFooterView = _footerView;
}

#pragma -mark UITableView dataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_showIndent[_shopNames[section]] count] + 1;
}

//块里的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {//返回店名
        
//        static NSString *_detailIndentShopCell = @"detailIndentShopCell";
//        
//        UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_detailIndentShopCell];
//        
//        if (nil == _cell) {
//            
//            _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_detailIndentShopCell];
//            _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        
//        _cell.textLabel.textColor = [UIColor darkGrayColor];
//        _cell.textLabel.text = _shopNames[indexPath.section];
//        _cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        ShopNameCell *_cell = [tableView dequeueReusableCellWithIdentifier:@"ShopNameCell"];
        
        _cell.shopName.text = _shopNames[indexPath.section];
        
        NSString *vip = _shopVIPs[indexPath.section];
        
        if ([vip boolValue]) {
            
            _cell.vip.hidden = NO;
            [_cell selectVIPPay];
        } else {
            _cell.vip.hidden = YES;
        }
        
        return _cell;
        
    } else {
            
        static NSString *_detailIndentCell = @"DetailIndentCell";
    
        DetailIndentCell *_cell = [tableView dequeueReusableCellWithIdentifier:_detailIndentCell];
        
        if (nil == _cell) {
            
            _cell = [[DetailIndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_detailIndentCell];
        }
        
        DetailIndentInfo *_info = _showIndent[_shopNames[indexPath.section]][indexPath.row - 1];
        
        [_cell loadDetailIndentCellWithInfo:_info];
        
        return _cell;
    }
}

//行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        
        return 40;
    } else {
        
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        
        NSString *name = _shopNames[indexPath.section];

        if (0 == [_showIndent[name] count]) {
            
            NSMutableArray *_tmp = [NSMutableArray array];
            
            for (NSString *_product in _allIndent[name]) {
                [_tmp addObject:_product];
            }
            
            [_showIndent setObject:_tmp forKey:name];
        } else {
            
            NSMutableArray *_tmp = [NSMutableArray array];
            
            [_showIndent setObject:_tmp forKey:name];
        }
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//多少块
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_showIndent count];
}

//加载模型
- (void)loadModel:(NSDictionary *)aDic {
    
    _allIndent = [NSMutableDictionary dictionary];
    _shopNames = [NSMutableArray array];
    _shopVIPs = [NSMutableArray array];
    
    for (NSDictionary *dic in aDic[@"shops"]) {
        
        [_shopNames addObject:dic[@"name"]];
        [_shopVIPs addObject:dic[@"VIP"]];
        
        NSMutableArray *_tmp = [NSMutableArray array];
        
        for (NSDictionary *tDic in dic[@"product"]) {
            
            DetailIndentInfo *_info = [DetailIndentInfo detailIndentInfo:tDic];
            
            [_tmp addObject:_info];
        }
        
        [_allIndent setObject:_tmp forKey:dic[@"name"]];
    }
    
    _showIndent = [_allIndent mutableCopy];
    
    [self.detailIndentTableView reloadData];
}
@end
