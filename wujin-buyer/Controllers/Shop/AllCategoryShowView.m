//
//  AllCategoryShowView.m
//  wujin-buyer
//
//  Created by jensen on 15/6/26.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AllCategoryShowView.h"

@implementation AllCategoryShowView

- (void)openCategoryInView:(UIView *)superView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20 , K_UIMAINSCREEN_WIDTH, superView.bounds.size.height - 20) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_allCategoryArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * tableCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * dic = _allCategoryArray[indexPath.row];
    
    tableCell.textLabel.text = [dic valueForKey:@"spname"];
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dic = _allCategoryArray[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryShowView:didSelectCategoryShowView:)]) {
        
        [self.delegate categoryShowView:self didSelectCategoryShowView:dic];
    }
    
    if ([self superview]) {
        
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
