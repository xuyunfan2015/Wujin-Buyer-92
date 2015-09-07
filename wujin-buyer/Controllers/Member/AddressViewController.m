//
//  AddressViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressEditViewController.h"
#import "AddressCell.h"

@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate, AddressEditState>

{
    commentNetwordRequest *_networdRequest;
}

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property (strong, nonatomic) NSMutableArray *addresses;

@property (strong, nonatomic) NSString *subURL;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@end

@implementation AddressViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"AddressViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"AddressViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5f);
    // Do any additional setup after loading the view.
    
    [self layoutNavigationBarWithString:@"我的收货地址"];
    
    self.navigationBar.rightButton.hidden = YES;
    
    self.addressTableView.tableFooterView = [UIView new];
    
    [self getAddressInfo];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (nil != _networdRequest) {
        
        [_networdRequest cancelGET];
    }
}

- (void)getAddressInfo {
    
    [self showCustomIndicatorWithMessage:LOADING_MESSAGE];
    _subURL = ADDRESS_GET_URL;
    _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[UserInfo sharedUserInfo] userID], @"uid",  nil];
    
    _networdRequest = [commentNetwordRequest POST:_subURL withParams:_params success:^(NSDictionary *successDic) {
        
        [self hideCustomIndicator];
      
        [self loadAddressInfo:successDic[@"mapss"]];
  
    } failer:^(NSDictionary *failerDic) {
        
        [self showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
        
    }];
}

//加载信息
- (void)loadAddressInfo:(NSArray *)addressInfos {
   
    if (!_addresses) {
        
        _addresses = [[NSMutableArray alloc] initWithCapacity:0];
    
    }else {
        
        [_addresses removeAllObjects];
    }
    
    for (NSDictionary *dic in addressInfos) {
        
        [_addresses addObject:[AddressInfo addressInfoWithDictionary:dic]];
    }
    
    [self.addressTableView reloadData];
}

#pragma -mark tableView dataSource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_addresses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *_cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    
    if (nil == _cell) {
        
        _cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCell"];
    }
    
    [_cell loadCellContentWithInfo:_addresses[indexPath.row]];
    
    AddressInfo * addressInfo = _addresses[indexPath.row];
    
    if ([addressInfo.isDefault intValue] == 1) {
        
        _cell.name.textColor = WHITE_COLOR;
        _cell.address.textColor = WHITE_COLOR;
        _cell.telephone.textColor = WHITE_COLOR;
        _cell.backgroundColor = [UIColor darkGrayColor];
        _cell.defaulAddress.hidden = NO;
    
    } else {
        
        _cell.name.textColor = BLACK_COLOR;
        _cell.address.textColor = BLACK_COLOR;
        _cell.telephone.textColor = BLACK_COLOR;
        _cell.backgroundColor = [UIColor whiteColor];
        _cell.defaulAddress.hidden = YES;
    }
    
    return _cell;
}

//得到cell高度
- (CGFloat)getCellHeight:(AddressCell *)cell {
    
    [cell layoutIfNeeded];
    
    cell.address.font = [UIFont systemFontOfSize:16.f];
    CGSize size = [cell.address sizeThatFits:CGSizeMake(K_UIMAINSCREEN_WIDTH - 40, 0)];
    
    return size.height + 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static AddressCell *cell = nil;
    
    if (nil == cell) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    }
    
    [cell loadCellContentWithInfo:[_addresses objectAtIndex:indexPath.row]];
    
    return 94;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isSelected) {
        
        if ([self.seclectDelegate respondsToSelector:@selector(selectAddressWithAddressInfo:)]) {
            
            [self.seclectDelegate selectAddressWithAddressInfo:_addresses[indexPath.row]];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
    
        AddressEditViewController *_addressEdit = [self storyBoardControllerID:@"Main" WithControllerID:@"AddressEdit"];

        _addressEdit.addressInfo = [_addresses objectAtIndex:indexPath.row];

        [self prepareForSegue:nil sender:nil];

        _addressEdit.addressDelegate = self;

        [self.navigationController pushViewController:_addressEdit animated:YES];
    }
}

#pragma -mark AddressEditState
- (void)addressEditState:(kAddressState)state andInfo:(AddressInfo *)aInfo {
    
    switch (state) {
        case kAddressStateAdd:

            [self getAddressInfo];
            
            break;
        
        case kAddressStateSub:
            [_addresses removeObject:aInfo];
            break;
            
        case kAddressStateDef:
            [_addresses removeObject:aInfo];
            [_addresses insertObject:aInfo atIndex:0];
            break;
         case kAddressStateAlt:
            [self getAddressInfo];
            break;
            
        default:
            break;
    }
    
    [self.addressTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([@"ToAddress" isEqualToString:segue.identifier]) {
        
        AddressEditViewController *_addressEdit = segue.destinationViewController;
        
        _addressEdit.addressDelegate = self;
    }
}

@end
