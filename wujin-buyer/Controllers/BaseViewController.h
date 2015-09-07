//
//  BaseViewController.h
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "CustomNavigationView.h"

@protocol EnterDelegate;

@interface BaseViewController : UIViewController<MJRefreshBaseViewDelegate, MWPhotoBrowserDelegate, CustomNavigationViewDelegate>
{
    MJRefreshFooterView * footer;//上拉属性
    MJRefreshHeaderView * header;//下拉属性
    
    MJRefreshFooterView * footer1;
    MJRefreshHeaderView * header1;
    
    int page;
    BOOL refreshing;
    
    int page1;
    BOOL refreshing1;
    BOOL first;
    CGRect textFrame;//正在激活的text
    UIView *keyboardView;//需要移动的View
    
    NSNotification *myNotification;//键盘的配置
}

@property (strong, nonatomic) CustomNavigationView *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (assign, nonatomic)int buttonType;////0.店铺 1.产品
@property (nonatomic, strong) UIButton * titleButton;
@property (strong,nonatomic) UITextField * searchField;
@property (strong, nonatomic) UILabel * unReadView;

/**
 添加下拉刷新&上拉加载
 */
- (void)initHeaderViewWithTableView:(UIScrollView *)tableView;
- (void)initFooterViewWithTableView:(UIScrollView *)tableView;
- (void)initHeader1ViewWithTableView:(UIScrollView *)tableView;
- (void)initFooter1ViewWithTableView:(UIScrollView *)tableView;
/**
 定制导航条上的标题
 */
-(void)initTitleViewWithTitleString:(NSString *)titleString;
/*
 定制 店铺&商品 按钮
 */
- (void)layoutShopWithName:(NSString *)shopName actions:(SEL)action type:(int)type;//0.店铺 1.产品
/**
 定制返回按钮
 */
- (void)layoutBackButton;
/*
 定制NAV 右边2个按钮
 */
- (UIButton *)setBarButtonItemWithImageName:(NSString *)imageName title:(NSString *)title imageNameExtenel:(NSString*)imageNameExtenel titleExtenel:(NSString *)titleExtenel action:(SEL)action actionExtenel:(SEL)extenelAction;
/**
 定制NavigationBar的左边按钮
 */
- (void)initLeftBarButtonItem:(NSString *)imageName title:(NSString *)title action:(SEL)action;
/**
 定制NavigationBar的右边按钮
 */
- (void) initWithRightButtonWithImageName:(NSString *)imageName title:(NSString *)title action:(SEL)action;
/**
 获取Other故事版中的控制器
 */
- (id)getStoryBoardControllerWithID:(NSString *)cid;

/**
 获取故事板上得controller
 */
- (id)storyBoardControllerID:(NSString *)storyBoardID WithControllerID:(NSString *)cID;

/**
 根据reuseIdentifity获取nib
 */
- (UINib *)getNibByIdentifity:(NSString *)identifity;

/**
 展现菊花  遮盖用户操作
 */
- (void)showCustomIndicatorWithMessage:(NSString *)message;

/**
 隐藏菊花
 */
- (void)hideCustomIndicator;

/**
 显示一个一秒的警告
 */
- (void)showAlertViewWithMessage:(NSString *)message andImage:(UIImage*)image;

/**
 刷新,加载方法
 */
- (void)updateInfomations;
- (void)updateInfomations1;

/*
 结束刷新加载方法
 */
- (void)updateFinish;

/**
 判断是否登录，如果没有登录就跳到登录界面 (还有正在登录中这个暂时没做判断，需要商讨)
 */
- (BOOL)isEnterServer;

/**
 token验证不正确，退出登录
 */
- (BOOL)tokenLogoff:(NSDictionary *)info;

/**
 自定义navigation
 */
- (void)layoutNavigationBarWithString:(NSString *)title;

/**
 跳到选择地址页面
 */
- (void)selectAddressInfo;

/**
 跳到店铺详情
 */
- (void)selectShopInfoWith:(NSString *)shopID;

/**
 跳到产品详情
 */
- (void)selectProductInfo:(NSString *)productID;

- (void)popToRoot;
/////////////////////////
- (void)changeBType:(int)type;

- (void)keyboardWillHide:(NSNotification *)notification;

- (void)keyboardWillShow:(NSNotification *)notification;

- (void)keyboardWillChange:(NSNotification *)notification;

/////////////看大图相关方法///////////////////////////
@property (strong, nonatomic) NSMutableArray * photosArray;
- (void)openImageSetWithImages:(NSArray *)images initImageIndex:(int)index;////查看图片(图片数组作为参数)
- (void)openImageSetWithUrls:(NSArray *)urls initImageIndex:(int)index;///////查看图片(url数组作为参数)

////////////////初始化未读label///////////
- (void)initUnreadView;

@end
