//
//  MenuTableViewCell.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/21.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutMenuTableView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.tableView registerNib:[self getNibByIdentifity:@"CarCell"] forCellReuseIdentifier:@"CarCell"];
    
    UIView * view = [UIView new];
    self.tableView.tableFooterView = view;
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UINib *)getNibByIdentifity:(NSString *)identifity {
    
    UINib * cellNib = [UINib nibWithNibName:identifity bundle:nil];
    
    return cellNib;
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate tableView:self didSelectMCRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return  [self.delegate numberOfMCSectionsInTableView:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return [self.delegate tableView:self numberOfMCRowsInSection:section];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.delegate tableView:self heightForMCRowAtIndexPath:indexPath];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.delegate tableView:self cellForMCRowAtIndexPath:indexPath];
    
}
@end
