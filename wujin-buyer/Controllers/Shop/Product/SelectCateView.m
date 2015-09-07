//
//  SelectCateView.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/24.
//  Copyright (c) 2015年 wujin. All rights reserved.  
//

#import "SelectCateView.h"
#import "UIView+KGViewExtend.h"
#import "ShowCateCell.h"
#import "AddCell.h"

@implementation SelectCateView

- (void)initReloadCateView {
    
    self.selectCateTableView.delegate = self;
    self.selectCateTableView.dataSource = self;
    self.selectCateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.selectCateTableView registerNib:[self getNibByIdentifity:@"AddCell"] forCellReuseIdentifier:@"AddCell"];
    [self.selectCateTableView registerNib:[self getNibByIdentifity:@"ShowCateCell"] forCellReuseIdentifier:@"ShowCateCell"];
    
    self.selectAddCarButton.left = (K_UIMAINSCREEN_WIDTH - 210)/2;
    
    self.selectBuyButton.left = self.selectAddCarButton.right + 10;
    
    self.sureButton.left = (K_UIMAINSCREEN_WIDTH - 100)/2;
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5f);
  
}

- (void)reloadCateView {
    
    [self.selectCateTableView reloadData];
    
}

- (void)setCateImageWithURL:(NSString *)url {
    
    /*
     图片
     */
    NSString * imageURL = [CommentRequest getCompleteImageURLStringWithSubURL:url];
    [self.selectImageView setURL:imageURL defaultImage:PLACE_HORDER_IMAGE(self.selectImageView)];
}

///所有类别数据 + 选中第几个 + 图片(商品图片)
- (void)layoutSubviewWithCateData:(NSDictionary *)cateData selectIndex:(int)selectIndex1 productImage:(NSString *)url {
    
    self.numbers = @"1";
    
    selectIndex = selectIndex1;////保存选中的索引
  /*
   图片
   */
    if(url) {
        
        NSString * imageURL = [CommentRequest getCompleteImageURLStringWithSubURL:url];
      
        [self.selectImageView setURL:imageURL defaultImage:PLACE_HORDER_IMAGE(self.selectImageView)];
    }
    
    categoryList = [cateData valueForKey:@"category_list"];
    
    ///初始选中的值 机器索引
    hasSelectedCategory = categoryList[selectIndex];///已选了第几个
    tempIndex = selectIndex;
    
    /////填值
    self.selectPrice.text = [NSString stringWithFormat:@"￥%@",[hasSelectedCategory valueForKey:@"price"]];
    
    self.selectCName.text = [NSString stringWithFormat:@"已选：\"%@\"",[hasSelectedCategory  valueForKey:@"format"]];
    
    [self.selectCName sizeToFit];
    
    if (!_showCategorySelectView) {
        
        //cell 总高度是为该view + 45
        _showCategorySelectView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, K_UIMAINSCREEN_WIDTH - 20, 0)];

    }else {
        
        for (UIView * view  in _showCategorySelectView.subviews) {
            
            [view removeFromSuperview];
            
        }
    }
    
    for (int index = 0; index < [categoryList count]; index ++) {
        
        NSDictionary * dic = categoryList[index];
        
        NSString * cName = [dic valueForKey:@"format"];
        
        UILabel * tLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 135, 50)];
    //    tLabel.backgroundColor = [UIColor colorWithWhite:0.984 alpha:1.000];
        tLabel.textAlignment = NSTextAlignmentCenter;
        tLabel.text = cName;
        tLabel.userInteractionEnabled = NO;
        tLabel.backgroundColor = [UIColor clearColor];
        tLabel.tag = 5000 + index;
        tLabel.font = [UIFont systemFontOfSize:13];
        tLabel.numberOfLines = 2;
        //[tLabel sizeToFit];
       
        int x = index % 2;
        int y = index / 2;
        
        UIButton * button = [UIButton  buttonWithType:UIButtonTypeCustom];
        button.tag = 6000 + index;
        button.frame = CGRectMake(x * 155, 60 * y, tLabel.width + 10, tLabel.height);
        [button addTarget:self action:@selector(selectActions:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:tLabel];
        
        [button setBackgroundImage:TTImage(@"color_noSelected") forState:UIControlStateNormal];
        
        [button setBackgroundImage:TTImage(@"color_selected") forState:UIControlStateSelected];
        
        if(tempIndex == index) {///是选中的那一项
            
            tLabel.textColor = RGBCOLOR(224, 61, 60);//[UIColor colorWithRed:0.874 green:0.713 blue:0.721 alpha:1.000];
            
            button.selected = YES;
        
            
        }else {
            
            tLabel.textColor = RGBCOLOR(98, 98, 98);//[UIColor colorWithWhite:0.827 alpha:1.000];
            
            button.selected = NO;
    
        }
        
        [_showCategorySelectView addSubview:button];
        
        
       // startX = startX + button.width + (K_UIMAINSCREEN_WIDTH - 290)/3;
    }
    
    _showCategorySelectView.height = ([categoryList count]%2 == 0)? (([categoryList count]/2) * 60):(([categoryList count]/2 + 1) * 60);
    
    
    [self reloadCateView];
    
}

///所有类别数据 + 选中第几个 + 图片(商品图片)
- (void)layoutSubviewWithCateData:(NSDictionary *)cateData selectIndex:(int)selectIndex1 productImage:(NSString *)url numbers:(NSString *)numbers {
    
    self.numbers = numbers;
    
    selectIndex = selectIndex1;////保存选中的索引
    /*
     图片
     */
    if(url) {
        
        NSString * imageURL = [CommentRequest getCompleteImageURLStringWithSubURL:url];
        
        [self.selectImageView setURL:imageURL defaultImage:PLACE_HORDER_IMAGE(self.selectImageView)];
    }
    
    categoryList = [cateData valueForKey:@"category_list"];
    
    ///初始选中的值 机器索引
    hasSelectedCategory = categoryList[selectIndex];///已选了第几个
    tempIndex = selectIndex;
    
    /////填值
    self.selectPrice.text = [NSString stringWithFormat:@"￥%@",[hasSelectedCategory valueForKey:@"price"]];
    
    self.selectCName.text = [NSString stringWithFormat:@"已选：\"%@\"",[hasSelectedCategory  valueForKey:@"format"]];
    
    [self.selectCName sizeToFit];
    
    if (!_showCategorySelectView) {
        
        //cell 总高度是为该view + 45
        _showCategorySelectView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, K_UIMAINSCREEN_WIDTH - 20, 0)];
        
    }else {
        
        for (UIView * view  in _showCategorySelectView.subviews) {
            
            [view removeFromSuperview];
            
        }
    }
/////////////////////
    
    for (int index = 0; index < [categoryList count]; index ++) {
        
        NSDictionary * dic = categoryList[index];
        
        NSString * cName = [dic valueForKey:@"format"];
        
        UILabel * tLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 135, 50)];
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.backgroundColor = [UIColor colorWithWhite:0.984 alpha:1.000];
        tLabel.textAlignment = NSTextAlignmentCenter;
        tLabel.text = cName;
        tLabel.numberOfLines = 2;
        tLabel.userInteractionEnabled = NO;
        tLabel.backgroundColor = [UIColor clearColor];
        tLabel.textColor = RGBCOLOR(98, 98, 98);
        tLabel.tag = 5000 + index;
        
        int x = index % 2;
        int y = index / 2;
        
        UIButton * button = [UIButton  buttonWithType:UIButtonTypeCustom];
        button.tag = 6000 + index;
        button.frame = CGRectMake(x * 155, 60 * y, tLabel.width + 10, tLabel.height);
        [button addTarget:self action:@selector(selectActions:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:tLabel];
        
        [button setBackgroundImage:TTImage(@"color_noSelected") forState:UIControlStateNormal];
        
        [button setBackgroundImage:TTImage(@"color_selected") forState:UIControlStateSelected];
        
        if(tempIndex == index) {///是选中的那一项
            
            tLabel.textColor = RGBCOLOR(224, 61, 60);//[UIColor colorWithRed:0.874 green:0.713 blue:0.721 alpha:1.000];
            
            button.selected = YES;
            
            
        }else {
            
            tLabel.textColor = RGBCOLOR(98, 98, 98);//[UIColor colorWithWhite:0.827 alpha:1.000];
            
            button.selected = NO;
            
        }
        
        [_showCategorySelectView addSubview:button];
        
    }
    
    _showCategorySelectView.height = ([categoryList count]%2 == 0)? (([categoryList count]/2) * 60):(([categoryList count]/2 + 1) * 60);
    
    //////////////////////////////////////
    
    [self reloadCateView];
    
}




- (UINib *)getNibByIdentifity:(NSString *)identifity {
    
    UINib * cellNib = [UINib nibWithNibName:identifity bundle:nil];
    
    return cellNib;
}


#pragma mark - Acions

- (void)selectActions:(UIButton *)button {
    
    if (button.tag - 6000 == tempIndex) {
        
        return;
    }
    
    UIButton * lastSelecedButton = (UIButton *)[_showCategorySelectView viewWithTag:6000 + tempIndex];
    lastSelecedButton.selected = NO;
   
    UILabel * lastSelectedLabel = (UILabel *)[lastSelecedButton viewWithTag:5000 + tempIndex];
    lastSelectedLabel.textColor = RGBCOLOR(98, 98, 98);//[UIColor colorWithWhite:0.827 alpha:1.000];
    
    UILabel * curSelectdLabel = (UILabel *)[button viewWithTag:button.tag - 1000];
    
    tempIndex = (int)button.tag - 6000;///更新现在的tag
    
    hasSelectedCategory = categoryList[tempIndex];
    
    button.selected = YES;

    curSelectdLabel.textColor = RGBCOLOR(224, 61, 60);;//[UIColor colorWithRed:0.874 green:0.713 blue:0.721 alpha:1.000];
    
    self.selectPrice.text = [NSString stringWithFormat:@"￥%@",[hasSelectedCategory valueForKey:@"price"]];
    self.selectCName.text = [NSString stringWithFormat:@"已选：\"%@\"",[hasSelectedCategory valueForKey:@"format"]];
    self.selectCName.width = 190;
    [self.selectCName sizeToFit];
}

//type:1 : 确定  0: 加入购物车

- (void)openSelectViewInSuperView:(UIView *)superView WithType:(int)type  {
    
    if (!_blackView) {
        
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        
    }

    ////////////////
    [superView addSubview:_blackView];
    [superView addSubview:self];
    //////////////////////
    
     _blackView.alpha = 0;
  
    self.top = K_UIMAINSCREEN_HEIGHT ;
    
    if (type == 0) {
        
        [self.sureButton setHidden:YES];
        [self.selectAddCarButton setHidden:NO];
        [self.selectBuyButton setHidden:NO];
        
    }else {
        
        [self.sureButton setHidden:NO];
        [self.selectAddCarButton setHidden:YES];
        [self.selectBuyButton setHidden:YES];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _blackView.alpha = 0.7;
        
        self.top = K_UIMAINSCREEN_HEIGHT - self.height - (self.hasTbar?0:49);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)selectCloseAction:(id)sender {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _blackView.alpha = 0;
        
        self.top = K_UIMAINSCREEN_HEIGHT;
        
        
    } completion:^(BOOL finished) {
        
        [_blackView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

- (IBAction)selectAddToCar:(id)sender {
    
    selectIndex = tempIndex;///选中了这个
    
    NSDictionary * dic = categoryList[selectIndex];///选中了这个类别
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCateView:didClickAddToCar:buyNum:)]) {
        
        [self.delegate selectCateView:self didClickAddToCar:dic buyNum:[_textField.text intValue]];
        
    }
    
    [self selectCloseAction:nil];
}

- (IBAction)selectInstantBuyAction:(id)sender {
    
    selectIndex = tempIndex;///选中了这个
    
    NSDictionary * dic = categoryList[selectIndex];///选中了这个类别
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCateView:didClickInstantBuy:buyNum:)]) {
        
        [self.delegate selectCateView:self didClickInstantBuy:dic buyNum:[_textField.text intValue]];
    }

    [self selectCloseAction:nil];
}

- (IBAction)sureAction:(id)sender {
    
    selectIndex = tempIndex;///选中了这个
    
    NSDictionary * dic = categoryList[selectIndex];///选中了这个类别
    
    if (self.isClickAddToCar) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCateView:didClickAddToCar:buyNum:)]) {
            
            [self.delegate selectCateView:self didClickAddToCar:dic buyNum:[_textField.text intValue]];
        }
    }else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCateView:didClickInstantBuy:buyNum:)]) {
            
            [self.delegate selectCateView:self didClickInstantBuy:dic buyNum:[_textField.text intValue]];
        }
    }
    
    [self selectCloseAction:nil];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.row == 0) {
            
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShowCateCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.contentView addSubview:_showCategorySelectView];
            
            return cell;
            
        }else {
            
            AddCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            _textField = cell.numberField;
            
            _textField.text = self.numbers;
            
            return cell;
            
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.row == 0) {
            
            //计算高度
            return _showCategorySelectView.height + 50;
            
        }else {
            
            return 60;
        }
}

#pragma mark - AddCellDelegate

- (void)showHintWithMsg:(NSString *)msg {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCateView:didShowMsg:)]) {
        
        [self.delegate selectCateView:self didShowMsg:msg];
    }
    
}

@end
