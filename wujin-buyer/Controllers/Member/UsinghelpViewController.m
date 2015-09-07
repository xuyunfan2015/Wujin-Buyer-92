//
//  UsinghelpViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/3/17.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "UsinghelpViewController.h"

@interface UsinghelpViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *usinghelp;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (strong, nonatomic) NSMutableArray *showData;
@property (strong, nonatomic) NSDictionary *originalData;
@property (strong, nonatomic) NSArray *sortedKeys;
@end

@implementation UsinghelpViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"UsinghelpViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"UsinghelpViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"使用帮助"];
    self.navigationBar.rightView.hidden = YES;
    
    [self loadHTML];
    self.usinghelp.tableFooterView = [UIView new];
}

#pragma mark 加载本地html文件
- (void)loadHTML
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buyer.html" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [self.webview loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
}

- (void)loadFile {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"usinghelp" ofType:@"plist"];
    
    _originalData = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    _sortedKeys = [[_originalData allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    
    _showData = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sortedKeys.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *myHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 44)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, K_UIMAINSCREEN_WIDTH - 10, 44)];
    title.font = [UIFont systemFontOfSize:15.f];
    title.textColor = BLACK_COLOR;
    title.text = _sortedKeys[section];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 44)];
    button.tag = section;
    button.backgroundColor = CLEAR_COLOR;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray_line"]];
    imageView.frame = CGRectMake(0, 44, K_UIMAINSCREEN_WIDTH, 1);
    imageView.transform = CGAffineTransformMakeScale(1.0f, 0.5f);

    [myHeader addSubview:title];
    [myHeader addSubview:imageView];
    [myHeader addSubview:button];
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    myHeader.backgroundColor = WHITE_COLOR;
    
    return myHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray_line"]];
    imageView.frame = CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 1);
    imageView.transform = CGAffineTransformMakeScale(1.0f, 0.5f);
    
    return imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([_showData containsObject:_sortedKeys[section]]) {
        
        return 1;
    } else {
        
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect rect = [_originalData[ _sortedKeys[indexPath.section] ] boundingRectWithSize:CGSizeMake(K_UIMAINSCREEN_WIDTH - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    
    return rect.size.height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = WHITE_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _originalData[ _sortedKeys[indexPath.section] ];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)clickButton:(UIButton *)sender {
    
    if ([_showData containsObject:_sortedKeys[sender.tag]]) {
        
        [_showData removeObject:_sortedKeys[sender.tag]];
    } else {
        
        [_showData addObject:_sortedKeys[sender.tag]];
    }
    
    [self.usinghelp reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
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
