//
//  ProductView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "ProductView.h"
#import "SMProductCell.h"

@implementation ProductView

- (void)layoutSubViewWithCategoryID:(NSString *)categoryID shopID:(NSString *)shopID {
    
    self.cateID = categoryID;
    self.shopID = shopID;
    
    [self layoutContentView];
    
    [self getSMCategory];
}

- (void)layoutContentView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    
     flowLayout.minimumLineSpacing = 2;
     flowLayout.minimumInteritemSpacing = 0;

   _tableView.contentInset = UIEdgeInsetsMake(4, 4, 0, 0);
    _tableView.collectionViewLayout = flowLayout;
    _tableView.alwaysBounceVertical = YES;
    [_tableView registerNib:[UINib nibWithNibName:@"SMProductCell" bundle:nil] forCellWithReuseIdentifier:@"SMProductCell"];
    [_tableView setUserInteractionEnabled:YES];
    [_tableView setDelegate:self]; //代理－视图
    [_tableView setDataSource:self]; //代理－数据
}

#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//定义展示的Section的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    
    return [_productArray count];
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        SMProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SMProductCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        NSDictionary * dic = _productArray[indexPath.row];
        
        NSString * comURL = [CommentRequest getCompleteImageURLStringWithSubURL:[dic valueForKey:@"cmimg"] ];
        [cell.imageView setURL:comURL defaultImage:PLACE_HORDER_IMAGE(cell.imageView)];
        
        cell.nameLabel.text = [dic valueForKey:@"cmname"];
        
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",[dic valueForKey:@"cmprice"]];
        
        cell.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.f].CGColor;
        cell.layer.masksToBounds = YES;
        
        return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(104, 142);
        
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = _productArray[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(productView:didSelectWithProduct:)]) {
        
        [self.delegate productView:self didSelectWithProduct:dic];
    }
    
 }

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark - 根据id获取

- (void)getSMCategory {
    
    NSMutableDictionary * params  = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.shopID,@"shopid",self.cateID,@"id",nil];
    
    NSURLRequest *urlRequest = [CommentRequest createPostURLWithSubURL:GET_PRODUCT_BY_SMALLID postValueParams:params];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            [CommentResponse parseServerData:data success:^(NSDictionary *successDic) {
                
                if (!_productArray) {
                    
                    _productArray = [[NSMutableArray alloc]initWithCapacity:0];
                }
                
                [_productArray addObjectsFromArray:[successDic valueForKey:@"smpeciesShopList"]];
               
                [_tableView reloadData];
                
            } fail:^(NSDictionary *failDic) {
                
               
            }];
            
        } else {
            
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
