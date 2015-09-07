//
//  ShopWebViewController.m
//  wujin-buyer
//
//  Created by Alan on 15/8/22.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ShopWebViewController.h"
#import "ShopPerInfoViewCell.h"
#import "ShopOtherInfoCell.h"
#import "ShopImageTableViewCell.h"
#import "ShopCommentViewCell.h"
#import "ShopComDetailViewCell.h"
#import "ShowDetailViewController.h"
#import "ShopAllCommentViewController.h"
#import "UserInfo.h"
#import "PhotoViewController.h"
//#import "<#header#>"
@interface ShopWebViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ayiTv;
@property(nonatomic,strong)NSDictionary* picsdic;
@property(nonatomic,strong)NSArray *commentdic;
@property(nonatomic,strong)UITextView *textview;
@end

@implementation ShopWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutNavigationBarWithString:self.cShopInfo.shopName];
    [self initUnreadView];
    [self getAllProducts];
    self.ayiTv.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.ayiTv registerNib:[UINib nibWithNibName:@"ShopCommentViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCommentViewCell"];
     [self.ayiTv registerNib:[UINib nibWithNibName:@"ShopComDetailViewCell" bundle:nil] forCellReuseIdentifier:@"ShopComDetailViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma -mark Touches代理

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 工具
- (IBAction)showBigImge:(UIButton *)sender {
    PhotoViewController *vc=[[PhotoViewController alloc]init];
    vc.image=sender.currentImage;
    [self.navigationController pushViewController:vc animated:NO];
//    MLPhotoBrowserPhoto *photo=[[MLPhotoBrowserPhoto alloc]init];
//    photo.photoImage=sender.currentImage;
//    NSArray *array=[NSArray arrayWithObject:photo];
   
    //[self openImageSetWithImages:array initImageIndex:0];
}

- (IBAction)pushDingcan:(UIButton *)sender {
        ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
    
    
        showDetailVC.hidesBottomBarWhenPushed = YES;
    
        showDetailVC.shopID = self.cShopInfo.ID;
    
        showDetailVC.cShopInfo = self.cShopInfo;
    
        [self.navigationController pushViewController:showDetailVC animated:YES];
}


-(void)pushCommentVc{
    ShopAllCommentViewController *allcommeng=[[ShopAllCommentViewController alloc]init];
    //HomePageDetailList * homepage = _detailShop[indexPath.row - 1];
    
    allcommeng.sid=self.shopID;
    [self.navigationController pushViewController:allcommeng animated:YES];

}
-(NSDictionary *)getDicPictureUrlarray:(NSArray *)pics{
    NSMutableDictionary *newDic=[NSMutableDictionary dictionary];
    NSMutableArray *array2=[NSMutableArray array];
    NSMutableArray *array3=[NSMutableArray array];
    NSMutableArray *array4=[NSMutableArray array];
    NSMutableArray *array5=[NSMutableArray array];
    NSMutableArray *array6=[NSMutableArray array];
    NSMutableArray *array7=[NSMutableArray array];
    for (NSDictionary *picDic in pics) {
        NSString *type=[picDic objectForKey:@"type"];
        NSString *img=[picDic objectForKey:@"img"];
        if ([type isEqualToString:@"2"]) {
            [array2 addObject:img];
        }else if ([type isEqualToString:@"3"]){
            [array3 addObject:img];
        }else if ([type isEqualToString:@"4"]){
            [array4 addObject:img];
        }else if ([type isEqualToString:@"5"]){
            [array5 addObject:img];
        }else if ([type isEqualToString:@"6"]){
            [array6 addObject:img];
        }else if([type isEqualToString:@"7"]){
            [array7 addObject:img];
        }
    }
    newDic[@"2"]=array2;
    newDic[@"3"]=array3;
    newDic[@"4"]=array4;
    newDic[@"5"]=array5;
    newDic[@"6"]=array6;
    newDic[@"7"]=array7;
    return newDic;
}
#pragma mark - UITableView -- dataSouce & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==2) {
        return 6;
    }
    if (section==4) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        if (section==4) {
        return 60;
    }
    return 5;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==4) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        view.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
        return view;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    view.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.section) {
        static NSString *_shopPerInfoViewCell = @"ShopPerInfoViewCell";
        
        ShopPerInfoViewCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopPerInfoViewCell];
        if (nil == _detailCell ) {
            
            _detailCell = [[ShopPerInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopPerInfoViewCell];
        }
        
        [_detailCell loadHomePageDetailWithDetailList:self.cShopInfo];
        
        return _detailCell;
        
    } else if(1==indexPath.section){
        
        static NSString *_shopOtherInfoCell = @"ShopOtherInfoCell";
        
        ShopOtherInfoCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopOtherInfoCell];
        if (nil == _detailCell ) {
            
            _detailCell = [[ShopOtherInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopOtherInfoCell];
        }
        
        [_detailCell loadHomePageDetailWithDetailList:self.cShopInfo];
        
        return _detailCell;
    }else if(2==indexPath.section){
        static NSString *_shopImageTableViewCell = @"ShopImageTableViewCell";
        
        ShopImageTableViewCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopImageTableViewCell];
        if (nil == _detailCell ) {
            
            _detailCell = [[ShopImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopImageTableViewCell];
        }
        if (0==indexPath.row) {
            _detailCell.typelabel.text=@"小区环境照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"xq.jpg"];
            
        }else if (1==indexPath.row){
         _detailCell.typelabel.text=@"居家环境照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"hj.jpg"];
        }else if (2==indexPath.row){
         _detailCell.typelabel.text=@"厨房环境照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"cf.jpg"];
        }else if (3==indexPath.row){
         _detailCell.typelabel.text=@"生活照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"sh.jpg"];
        }else if (4==indexPath.row){
         _detailCell.typelabel.text=@"烹饪过程照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"cp.jpg"];
        }else if (5==indexPath.row){
        _detailCell.typelabel.text=@"完成菜品照";
            _detailCell.typeimage.image=[UIImage imageNamed:@"cc.jpg"];
        }
        //_detailCell.buttonone.imageView.image
        NSString *key=[NSString stringWithFormat:@"%ld",indexPath.row+2];
        if (self.picsdic) {
            
             [_detailCell loadHomePageDetailWithDetailList:[self.picsdic objectForKey:key]];
        }
       
        
        return _detailCell;

    
    }else if(3==indexPath.section){
         NSString *_shopPerInfoViewCell = @"ShopCommentViewCell";
        
        ShopCommentViewCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopPerInfoViewCell];
        if (nil == _detailCell ) {
            
            _detailCell = [[ShopCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopPerInfoViewCell];
        }
        UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(50, 30, K_UIMAINSCREEN_WIDTH-80, 50)];
        self.textview=textView;
        [_detailCell addSubview:textView];
        textView.layer.borderColor = UIColor.grayColor.CGColor;
        textView.layer.borderWidth = 1;
        textView.layer.cornerRadius = 6;
        textView.layer.masksToBounds = YES;
        
        
        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(K_UIMAINSCREEN_WIDTH-80, 85, 40, 29)];
        [button2 setTitle:@"评论" forState:UIControlStateNormal];
        button2.titleLabel.font=[UIFont systemFontOfSize:12];
        [button2 addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setBackgroundColor:[UIColor orangeColor]];
        [_detailCell addSubview:button2];
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20, 90, 150, 20)];
        [button setTitle:@"获取更多评论" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(pushCommentVc) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [_detailCell addSubview:button];
            return _detailCell;
        
        
        }else if (4==indexPath.section){
            NSString *_shopPerInfoViewCell = @"ShopComDetailViewCell";
            
            ShopComDetailViewCell *_detailCell = [tableView dequeueReusableCellWithIdentifier:_shopPerInfoViewCell];
            if (nil == _detailCell ) {
                
                _detailCell = [[ShopComDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_shopPerInfoViewCell];
                
            }
            if (self.commentdic.count>=indexPath.row+1) {
                
            
            [_detailCell loadHomePageDetailWithDetailList:self.commentdic[indexPath.row]];
            }
                return _detailCell;

            
       
    
    
        }else if (5==indexPath.row){
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(30, 3,cell.frame.size.width-70, 30)];
            [button setTitle:@"获取更多评论" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(pushCommentVc) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor orangeColor]];
            [cell addSubview:button];
        }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0==indexPath.section) {
        return 140;
    }else if (1==indexPath.section){
        return 80;
    
    }else if(2==indexPath.section){
        return 120;
    }else if (3==indexPath.section){
        return 120;
    }else if (4==indexPath.section){
    
        return 70;
    }else if (5==indexPath.section){
        return 100;
        
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//被选择的高亮部分消失
}





#pragma mark - 获取数据
-(void)getAllProducts{
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"id",nil];
   
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:SHOP_DETAILVIEW postValueParams:params];
    [self showCustomIndicatorWithMessage:@"正在加载中..."];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self hideCustomIndicator];
        [self updateFinish];
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                //NSLog(@"successDic=======%@",successDic);
                NSArray *PICS=[successDic objectForKey:@"data"][@"imgs"];
                
                self.picsdic= [self getDicPictureUrlarray:PICS];
                self.commentdic=[successDic objectForKey:@"data"][@"comments"];
                
                [self.ayiTv reloadData];
            } fail:^(NSDictionary *failDic) {
                
            }];
        } else {
            
        }
    }];

}
//post comment
-(void)pinglun{
    [self isEnterServer];
    NSLog(@"text======|%@|",self.textview.text);
    NSLog(@"uid========|%@|",[[UserInfo sharedUserInfo] userID]);
    if (self.textview.text&&(![self.textview.text isEqualToString:@""])) {
        NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"id",[[UserInfo sharedUserInfo] userID],@"uid",self.textview.text,@"content", nil];
        
        NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:@"shop/saveComment" postValueParams:params];
        [self showCustomIndicatorWithMessage:@"正在加载中..."];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [self hideCustomIndicator];
            [self updateFinish];
            
            if (nil == connectionError) {
                
                [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                    [self getAllProducts];
                    //[self.ayiTv reloadData];
                    
                } fail:^(NSDictionary *failDic) {
                    
                }];
            } else {
                
            }
        }];
        
        //[self.ayiTv reloadData];
    }else
    {
        [self showAlertViewWithMessage:@"评论不能为空" andImage:nil];
    }
}
@end
