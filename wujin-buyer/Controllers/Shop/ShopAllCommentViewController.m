//
//  ShopAllCommentViewController.m
//  wujin-buyer
//
//  Created by Alan on 15/8/27.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopAllCommentViewController.h"
#import "ShopComDetailViewCell.h"
@interface ShopAllCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *comtv;
@property(assign)NSInteger count;
@end

@implementation ShopAllCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count=1;
    [self layoutNavigationBarWithString:@"所有评论"];
    [self initUnreadView];
    UITableView *comment=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    self.comtv=comment;
    comment.delegate=self;
    comment.dataSource=self;
    [self.view addSubview:comment];
     [comment registerNib:[UINib nibWithNibName:@"ShopComDetailViewCell" bundle:nil] forCellReuseIdentifier:@"ShopComDetailViewCell"];
    [self initHeaderViewWithTableView:self.comtv];
    [self initFooterViewWithTableView:self.comtv];
    [self loadComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *_shopOtherInfoCell = @"ShopComDetailViewCell";
    
    ShopComDetailViewCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopOtherInfoCell];
    if (nil == _detailCell ) {
        
        _detailCell = [[ShopComDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopOtherInfoCell];
    }
    
    [_detailCell loadHomePageDetailWithDetailList:self.dataArray[indexPath.row]];
    return _detailCell;

}
-(void)updateInfomations{
    [self loadComments];
    [self updateFinish];

}
-(void)updateInfomations1{
    [self updateFinish];
    
}
-(void)loadComments{
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.sid,@"sid",[NSString stringWithFormat:@"%ld",self.count],@"count", nil];
   
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:@"shop/commentList" postValueParams:params];
    [self showCustomIndicatorWithMessage:@"正在加载中..."];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        [self updateFinish];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                //NSLog(@"successDic=======%@",successDic);
                NSArray *array=[successDic objectForKey:@"data"];
                [self.dataArray addObjectsFromArray:array];
                self.count++;
                
                [self.comtv reloadData];
            } fail:^(NSDictionary *failDic) {
                
            }];
        } else {
            
        }
    }];
    


}

@end
