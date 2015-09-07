//
//  ProductCategoyViewController.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/8.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ProductCategoyViewController.h"
#import "ProductListViewController.h"
#import "ShowDetailViewController.h"
#import "AppUtil.h"


@interface ProductCategoyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int one_level;
    int two_level;

}

@property (nonatomic,strong) NSMutableArray * categoryArray;/////

@property (nonatomic,assign) NSInteger sectedSection;

@end

@implementation ProductCategoyViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"ProductCategoyViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"ProductCategoyViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //////////返回
//    [self layoutBackButton];
    //////////标题
    //[self initTitleViewWithTitleString:@"分类"];
    
    [self layoutNavigationBarWithString:@"分类"];
    
    self.navigationBar.rightButton.hidden = YES;
    
    ///////初始化数据/////////
    _categoryArray = [[NSMutableArray alloc] initWithCapacity:0];
    ///////////////////
    
    one_level = -1;
    two_level = -1;
    
    /////////////
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getShopCategorys];
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _categoryArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == one_level) {
        
        UIImageView *imageV = (UIImageView *)[_tableView viewWithTag:20000+section];
        imageV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
        
        NSArray *array1 = [_categoryArray[section] valueForKey:@"levelTwo"];
      
        if ((two_level >= 0) && (two_level < [array1 count])) {
            
            NSArray * array2 = [array1[two_level] valueForKey:@"levelThree"];
            
            return array1.count + array2.count;
        
        }else {
            
            return array1.count;
        }
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width - 20, 30)];
    titleLabel.text = [[_categoryArray objectAtIndex:section] valueForKey:@"name"];
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    imageView.tag = 20000 + section;
    
    //判断是不是选中状态
   // NSString *string = [NSString stringWithFormat:@"%d",section];
    
    if (one_level == section) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 40);
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, K_UIMAINSCREEN_WIDTH, 1)];
    lineImage.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:lineImage];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   NSString *indexStr = [NSString stringWithFormat:@"%d",indexPath.section];
   
    return 40;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UILabel *  label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, K_UIMAINSCREEN_WIDTH - 30 - 20, 40)];
        
        label.tag = 3000;
        
        [cell.contentView addSubview:label];
        

        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, K_UIMAINSCREEN_WIDTH, 1)];
        lineImage.tag = 3001;
        lineImage.image = [UIImage imageNamed:@"line.png"];
        [cell.contentView addSubview:lineImage];
    }
    
    UILabel * label = (UILabel *)[cell.contentView viewWithTag:3000];
    UIImageView * imageView = (UIImageView *)[cell.contentView viewWithTag:3001];
    //////////// section : 1     2,3用同一层
   int level = [self getLevel:indexPath];
    
    if (level == 2) {
        
        label.frame = CGRectMake(30, 0, K_UIMAINSCREEN_WIDTH - 30 - 20, 40);
        imageView.frame = CGRectMake(30, 39, K_UIMAINSCREEN_WIDTH - 30, 1);
    
    }else {
        
        label.frame = CGRectMake(60, 0, K_UIMAINSCREEN_WIDTH - 60 - 20, 40);
         imageView.frame = CGRectMake(60, 39, K_UIMAINSCREEN_WIDTH - 60, 1);
    }
    
    NSDictionary * dataDic = [self getRealDataWithIndexPath:indexPath];
    
    label.text = [dataDic valueForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int level = [self getLevel:indexPath];
    
    if (level == 2) { ///第二级 ///第二级
        
        int realRow = [self getRealRowWhenLevelTwo:indexPath];
        
        if (two_level == realRow) {
            
            two_level = -1;
            
        }else {
            
           two_level = realRow;
            
        }
        
      [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];

    }else if(level == 3) {
        
        NSDictionary * dic = [self getRealDataWithIndexPath:indexPath]; ///跳转到其他的页面
        
    //    NSString * name = [dic valueForKey:@"name"];
        
        ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
          showDetailVC.category = 1;
        showDetailVC.shopID = self.shopID;
        showDetailVC.categoryID = [dic valueForKey:@"ID"];
        [self.navigationController pushViewController:showDetailVC animated:YES];
        
        //由于有的二级下面没东西
      //  UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:name delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]
       // [alertView show];
        
    }
}

///当为等级2的时候,是属于第几个
- (NSInteger)getRealRowWhenLevelTwo:(NSIndexPath *)indexPath {
    
    if (two_level == -1) {
        
        return indexPath.row;
        
    }else {
        
        if (indexPath.row <= two_level) {
            
            return indexPath.row;
            
        }else{
            
            NSArray * array = [_categoryArray[indexPath.section] valueForKey:@"levelTwo"];
            
            NSArray * array1 = [array[two_level] valueForKey:@"levelThree"];
            
            return (indexPath.row - array1.count);
    
        }
    }

}

- (int)getLevel:(NSIndexPath *)indexPath {
    
    if (two_level == -1) {
        
        return 2;
        
    }else {
        
        if (indexPath.row <= two_level) {
            
            return 2;
            
        }else{
            
            NSArray * array = [_categoryArray[indexPath.section] valueForKey:@"levelTwo"];
            
            NSArray * array1 = [array[two_level] valueForKey:@"levelThree"];
            
            if((indexPath.row > two_level) && (indexPath.row <= two_level + [array1 count])){
                
                return 3;
                
            }else {
                
                ///第二级
                
                return 2;
                
            }
            
        }
    }
}
//5   3   11
- (NSDictionary *)getRealDataWithIndexPath:(NSIndexPath *)indexPath {
    
    if (two_level == -1) {
        
          NSArray * array = [_categoryArray[indexPath.section] valueForKey:@"levelTwo"];
        
        return array[indexPath.row];
    
    }else {
        
        if (indexPath.row <= two_level) {
            
            NSArray * array = [_categoryArray[indexPath.section] valueForKey:@"levelTwo"];
            
            return array[indexPath.row];
        
        }else{
            
            NSArray * array = [_categoryArray[indexPath.section] valueForKey:@"levelTwo"];
            
            NSArray * array1 = [array[two_level] valueForKey:@"levelThree"];
            
            if((indexPath.row > two_level) && (indexPath.row <= two_level + [array1 count])){
                
                ////第三级别
                NSDictionary * dic = array1[indexPath.row - two_level - 1];
                
                return dic;
                
            }else {
                
                ///第二级
                
                return array[indexPath.row - array1.count];
                
            }
            
        }
    }
}

//////////点击第一个组//////////////
-(void)doButton:(UIButton *)sender
{
    int section = sender.tag - 100;
    
    if (section == one_level)///已被选中--》收起
    {
        int temp = one_level;//先存值
    
        one_level = -1;
        two_level = -1;
    
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    else
    {
        
        if (one_level == -1) { ///没有选中
            
            one_level = section;
            two_level = -1;
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

        }else {
            
            int temp = one_level;//之前展开的
            
            one_level = section;//现在展开的
            
            two_level = -1;
            
            NSMutableIndexSet * indexSets = [[NSMutableIndexSet alloc] init];
            
            [indexSets addIndex:temp];
            
            [indexSets addIndex:section];
            
            [self.tableView reloadSections:indexSets withRowAnimation:UITableViewRowAnimationAutomatic];

        }
    }
}

#pragma mark - 获取店铺详情

- (void)getShopCategorys {
    
   // NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"shop_id", nil];
    
     NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"id", nil];
    
    NSURLRequest *urlRequest = [CommentRequest createGetURLWithSubURL:PRODUCT_CATEGORYS params:params];
    
    [self showCustomIndicatorWithMessage:@"正在加载中..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                [_categoryArray addObjectsFromArray:[[successDic valueForKey:@"result"] valueForKey:@"categoryList"]];
                
                [self.tableView reloadData];
                
                
            } fail:^(NSDictionary *failDic) {
                
                [self showAlertViewWithMessage:[failDic valueForKey:@"errMsg"] andImage:nil];
            }];
        } else {
            
            [self showAlertViewWithMessage:ERROR_SERVER andImage:nil];
        }
    }];
    
}

#pragma mark - Memory Manage

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
