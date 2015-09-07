//
//  BaseViewController.m
//  wujin-buyer
//
//  Created by 波罗密 on 15/1/5.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+KGViewExtend.h"
#import "CustomActivityIndicator.h"
#import "CustomAlertView.h"
#import "userInfo.h"
#import "ForgetPasswordViewController.h"
#import "AddressViewController.h"
#import "AppDelegate.h"
#import "ShowDetailViewController.h"

@interface BaseViewController ()<UITextFieldDelegate, selectAddressDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) CustomActivityIndicator *customActivityIndicator;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ////////////初始化page//////////////
    page = 1;
    refreshing = YES;
    /////////////////////
    first = YES;
    textFrame = CGRectZero;
    
    [self.navigationBar.rightButton setHidden:YES];

    //    self.view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
    //将系统的默认颜色定为黑色
    //self.navigationController.navigationBar.tintColor = BLACK_COLOR;
   // self.tabBarController.tabBar.tintColor = NAV_TAB_COLOR;
    //不透明
    self.tabBarController.tabBar.translucent = NO;
 //   self.navigationController.navigationBar.translucent = NO;
    //白色
    self.tabBarController.tabBar.barTintColor = RGBCOLOR(0xff, 0xff, 0xff);
    //self.navigationController.navigationBar.barTintColor = RGBCOLOR(0xfa, 0xfa, 0xfa);

    [self forIOS7:self];
   
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)updateInfomations {
    
}

- (void)updateInfomations1 {
    
}

#pragma mark - Memory Manage

- (void)dealloc {
    
    if (header) {
        
        [header free];
    }
    
    if (footer) {
        
        [footer free];
    }
    if (header1) {
        [header1 free];
    }
    
    if (footer1) {
        
        [footer1 free];
    }

        
        if (_unReadView) {
            
            AppDelegate * applegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [applegate removeObserver:self forKeyPath:@"unRead" context:nil];
            
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - refreshing & loading

- (void)initHeaderViewWithTableView:(UIScrollView *)tableView {
    
    header = [MJRefreshHeaderView header];
    header.scrollView = tableView; // 或者tableView
    header.delegate = self;
}
- (void)initFooterViewWithTableView:(UIScrollView *)tableView {
    
    footer = [MJRefreshFooterView footer];
    footer.scrollView = tableView; // 或者tableView
    footer.delegate = self;
}
- (void)initHeader1ViewWithTableView:(UIScrollView *)tableView {
    
    header1 = [MJRefreshHeaderView header];
    header1.scrollView = tableView; // 或者tableView
    header1.delegate = self;

}
- (void)initFooter1ViewWithTableView:(UIScrollView *)tableView {
    
    footer1 = [MJRefreshFooterView footer];
    footer1.scrollView = tableView; // 或者tableView
    footer1.delegate = self;
}

#pragma mark - finish loading & refreshing
- (void)updateFinish {
    
    [header endRefreshing];
    [footer endRefreshing];
    
    [footer1 endRefreshing];
    [header1 endRefreshing];
}

#pragma mark - MJRefreshBaseViewDelegate

// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) { //刷新
        
        if (refreshView == header) {
            
            page = 1;
            
            refreshing = YES;
            
            [self updateInfomations];
       
        }else {
        
            page1 = 1;
            refreshing1 = YES;
            [self updateInfomations1];
            
        }
        
    }else {//加载
        
        if (refreshView == footer) {
            
            page = page + 1;
            
            refreshing = NO;
            
            [self updateInfomations];
       
        }else {
        
            page1 = page1 + 1;
            
            refreshing1 =  NO;
            
            [self updateInfomations1];
            
        }
    }
}

#pragma mark - ios 6 / ios 7

-(void)forIOS7:(UIViewController *)ctl
{
    if (SYSTEM_BIGTHAN_7) {
        ctl.navigationController.interactivePopGestureRecognizer.enabled = NO;
        ctl.edgesForExtendedLayout =  UIRectEdgeNone;//IOS7新增属性,但是在导航栏隐藏的情况下还是要向下移动20px
        ctl.navigationController.navigationBar.translucent = NO;//解决导航栏跟状态栏背景色都变的有点暗的问题
        ctl.extendedLayoutIncludesOpaqueBars = NO;
        ctl.modalPresentationCapturesStatusBarAppearance = NO;
    
        [self.navigationController.navigationBar setTranslucent:NO];
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
        [self setNeedsStatusBarAppearanceUpdate];
        
      //  [ctl.navigationController.navigationBar setBackgroundImage:TTImage(@"nav_ios7") forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    else{
        
      // [ctl.navigationController.navigationBar setBackgroundImage:TTImage(@"nav_ios6") forBarMetrics:UIBarMetricsDefault];
    }
}

/**
 定制导航条上的标题
 */
-(void)initTitleViewWithTitleString:(NSString *)titleString {
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 24)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = CLEAR_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:20.f];
    titleLabel.textColor = BLACK_COLOR;
    titleLabel.text = titleString;
    self.navigationItem.titleView = titleLabel;
}

/*
 自定义导航条(右边2个按钮)
 */

- (UIButton *)setBarButtonItemWithImageName:(NSString *)imageName title:(NSString *)title imageNameExtenel:(NSString*)imageNameExtenel titleExtenel:(NSString *)titleExtenel action:(SEL)action actionExtenel:(SEL)extenelAction {
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(K_UIMAINSCREEN_WIDTH - 60, 20, 60, 44)];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (imageName) {
        
        [button setImage:TTImage(imageName) forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0, 7, 30, 30);
        
    }else {
        
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0, 10, 40, 24);
    }
    
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button1 addTarget:self action:extenelAction forControlEvents:UIControlEventTouchUpInside];
    
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (imageNameExtenel) {
        
        [button1 setImage:TTImage(imageNameExtenel) forState:UIControlStateNormal];
        
          button1.frame = CGRectMake(20, 7, 30, 30);
        
    }else{
        
        [button1 setTitle:titleExtenel forState:UIControlStateNormal];
        button1.frame = CGRectMake(0, 10, 40, 24);
    }
    
    button.hidden = YES;
    
    [rightView addSubview:button];
    [rightView addSubview:button1];
    
//  UIBarButtonItem * rightButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightButtonItem,rightButtonItem1, nil];
    
    self.navigationBar.rightView.hidden = YES;
    
    [self.navigationBar addSubview:rightView];
    
    return button;
    //return nil;
}
/*
 定制 店铺&商品 按钮
 */
- (void)layoutShopWithName:(NSString *)shopName actions:(SEL)action type:(int)type {//0.店铺 1.产品
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(44, 27, K_UIMAINSCREEN_WIDTH - 44*2, 30)];
   
  //  view.backgroundColor = [UIColor colorWithWhite:0.867 alpha:1.000];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat startX = 0;
    
    if (shopName) {
        
        self.buttonType = 0;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 5, 40, 20);
        button.enabled = NO;
        [button addTarget:self action:@selector(changeType) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:shopName forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [button setTitleColor:[UIColor colorWithWhite:0.376 alpha:1.000] forState:UIControlStateNormal];
        self.titleButton = button;
        [view addSubview:button];
        
//        if (type == 0) {
//            
//            UIImageView * view1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleButton.right - 10, self.titleButton.bottom - 7 - 5, 7, 7)];
//            view1.image = TTImage(@"change-1");
//            [button addSubview:view1];
//            
//        }

        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(50, 5, 1, 20)];
        line.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line];
    
        startX = 55;
    
    }else {
        
        startX = 10;
    }
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(startX, 5, view.width - startX - 20 - 50, 20)];
    _searchField.delegate = self;
    _searchField.returnKeyType = UIReturnKeySearch;
    _searchField.placeholder = @"请输入搜索词";
    _searchField.font = [UIFont systemFontOfSize:14.0f];
    [view addSubview:_searchField];
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
// 
//    button.frame = CGRectMake(view.width - 50 , 0, 50, 30);
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//  ///  [button setBackgroundImage:TTImage(@"search_background") forState:UIControlStateNormal];
//  //  button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"搜索" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
//    [button setTitleColor:[UIColor colorWithWhite:0.376 alpha:1.000] forState:UIControlStateNormal];
//
//    [view addSubview:button];
    
    view.layer.cornerRadius = 5.f;
    view.layer.masksToBounds = YES;
    
    self.navigationBar.titleView.hidden = YES;
    
    [self.navigationBar addSubview:view];
}

/**
 定制返回按钮
 */
- (void)layoutBackButton {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(16, 12, 12, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
/**
 定制NavigationBar的左边按钮
 */
- (void)initLeftBarButtonItem:(NSString *)imageName title:(NSString *)title action:(SEL)action{
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (imageName) {
        
        [rightButton setImage:TTImage(imageName) forState:UIControlStateNormal];
       
        rightButton.frame = CGRectMake(11, 11, 22, 22);
        
    }else {
        
        [rightButton setTitle:title forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 6,60 , 28);
    
    }
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
   
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
/**
 定制NavigationBar的右边按钮
 */
- (void) initWithRightButtonWithImageName:(NSString *)imageName title:(NSString *)title action:(SEL)action {
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    if (imageName) {
        
        [rightButton setImage:TTImage(imageName) forState:UIControlStateNormal];
        [rightButton setTintColor:RGBCOLOR(98, 98, 98)];
        [rightButton setContentEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        rightButton.frame = CGRectMake(K_UIMAINSCREEN_WIDTH - 44, 6, 30, 30);
    }else {
        
        rightButton.frame = CGRectMake(K_UIMAINSCREEN_WIDTH - 44, 6, 44, 30);
        
        [rightButton setTitle:title forState:UIControlStateNormal];
        
        [rightButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
        
    }
    self.rightButton = rightButton;
    
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStyleBordered target:self action:action];//[[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    rightButtonItem.style = UIBarButtonItemStyleBordered;
//    rightButtonItem.tintColor = BLACK_COLOR;
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

/**
 获取Other故事版中的控制器
 */
- (id)getStoryBoardControllerWithID:(NSString *)cid {

    UIStoryboard * board = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
        
    id  controller = [board instantiateViewControllerWithIdentifier:cid];
        
    return controller;
}

//获取故事板中得controller
- (id)storyBoardControllerID:(NSString *)storyBoardID WithControllerID:(NSString *)cID {
    
    UIStoryboard * board = [UIStoryboard storyboardWithName:storyBoardID bundle:nil];
    
    id  controller = [board instantiateViewControllerWithIdentifier:cID];
    
    return controller;
}

/*
 根据reuseid 获取uinib
 */
- (UINib *)getNibByIdentifity:(NSString *)identifity {
    
   UINib * cellNib = [UINib nibWithNibName:identifity bundle:nil];

    return cellNib;
}


#pragma mark - Actions

- (void)changeType {
    
    if (self.buttonType == 0) {
        
        self.buttonType = 1;
    
    }else {
        self.buttonType = 0;
    }
    
    if (self.buttonType == 0) {
        
        [self.titleButton setTitle:@"店铺" forState:UIControlStateNormal];
   
    }else{
        
        [self.titleButton setTitle:@"商品" forState:UIControlStateNormal];
    }
    
    if([self respondsToSelector:@selector(changeBType:)]){
        
        [self changeBType:self.buttonType];
    }
}

- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 展现菊花
 */
- (void)showCustomIndicatorWithMessage:(NSString *)message {
    
    if (nil == _customActivityIndicator) {
        
        _customActivityIndicator = [CustomActivityIndicator customActivityIndicatorWithMessage:message];
        
        _customActivityIndicator.frame = CGRectMake(0, 64, K_UIMAINSCREEN_WIDTH, K_UIMAINSCREEN_HEIGHT - 64);
        
     //   _customActivityIndicator.center = CGPointMake(K_UIMAINSCREEN_WIDTH/2, K_UIMAINSCREEN_HEIGHT/2);
        [self.view addSubview:_customActivityIndicator];
        
        //设置状态栏的菊花
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

/**
 隐藏菊花
 */
- (void)hideCustomIndicator {
    
    [_customActivityIndicator removeFromSuperview];
    _customActivityIndicator = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/**
 显示一个一秒的警告
 */
- (void)showAlertViewWithMessage:(NSString *)message andImage:(UIImage*)image {
    
//    if (nil == image) {
//        
//        image = [UIImage imageNamed:@"whiteAlertImage"];
//    }
//    
//    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", message, @"message", nil];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: message, @"message", nil];
//    
//    [self performSelectorOnMainThread:@selector(showCustomAlert:) withObject:dic waitUntilDone:YES];
   
    if (nil == image) {
        
        image = [UIImage imageNamed:@"whiteAlertImage"];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", message, @"message", nil];
    
    [self performSelectorOnMainThread:@selector(showCustomAlert:) withObject:dic waitUntilDone:YES];

}

- (void)showCustomAlert:(NSDictionary *)dic {
    
    [self updateFinish];//结束刷新
    
    [self hideCustomIndicator];//菊花隐藏起来吧。。。。
    
    CustomAlertView *alert = [CustomAlertView customAlertViewWithMessage:dic[@"message"] andImage:dic[@"image"]];
    
    alert.center = CGPointMake(K_UIMAINSCREEN_WIDTH/2, K_UIMAINSCREEN_HEIGHT/2);
    
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:alert];
    
    [self performSelector:@selector(removeCustomAlert:) withObject:alert afterDelay:1.f];
}

- (void)removeCustomAlert:(CustomAlertView *)alertView {
    
    if (nil != alertView) {
        
        [UIView animateWithDuration:1.5f animations:^{
            
            alertView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [alertView removeFromSuperview];
        }];
    }
}

//点击屏幕结束编辑
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)selectAddressInfo {
    
    AddressViewController *_address = [self storyBoardControllerID:@"Main" WithControllerID:@"AddressViewController"];
    
//    _address.isSelected = YES;
//    
//    _address.seclectDelegate = self;
    
    [self.navigationController pushViewController:_address animated:YES];
}

/**
 键盘弹出事件，如果需要调用请添加键盘弹出 通知
 */
- (void)keyboardWillShow:(NSNotification *)notification {
    
    myNotification = notification;
    
    if (0 == textFrame.origin.y) {
        
        return;
    }

    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *_value = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [_value CGRectValue];
    
    CGFloat height = K_UIMAINSCREEN_HEIGHT;//导航栏

    CGFloat lastOffset = (height - keyboardRect.size.height)/2 + 32;
    
    CGFloat viewOffset = keyboardView.frame.origin.y - lastOffset;
    
    CGFloat offset = textFrame.origin.y + viewOffset;
    
    NSTimeInterval animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    UIViewAnimationCurve animationCurve = [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    [UIView beginAnimations:@"keyboardShow" context:nil];

    [UIView setAnimationDuration:animationDuration];

    [UIView setAnimationCurve:animationCurve];
    
    if (offset > 0 || textFrame.origin.y > lastOffset) {
//        
//        offset = offset - oldOffset;
    
        keyboardView.center = CGPointMake(keyboardView.center.x, keyboardView.center.y - offset);
        
//        oldOffset += offset;
    } else {
        
//        if () {
//            <#statements#>
//        }
//
        keyboardView.frame = CGRectMake(0, 64, keyboardView.frame.size.width, keyboardView.frame.size.height);
//        
//        oldOffset = 0;
    }

    [UIView commitAnimations];
}

/**
 键盘隐藏事件 如果需要调用请添加键盘隐藏 通知
 */
- (void)keyboardWillHide:(NSNotification *)notification {
    
    first = YES;
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UIViewAnimationCurve animationCurve = [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    [UIView beginAnimations:@"keyboardShow" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationCurve:animationCurve];
    
    keyboardView.frame = CGRectMake(0, 64, keyboardView.frame.size.width, keyboardView.frame.size.height);
    
    [UIView commitAnimations];
    
    myNotification = nil;
    
    textFrame = CGRectZero;
}

- (void)keyboardWillChange:(NSNotification *)notification {
    
    myNotification = notification;
}

#pragma mark - PhotoBrowerDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
    return self.photosArray.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < self.photosArray.count) {
        return [self.photosArray objectAtIndex:index];
    }
    return nil;
}

#pragma mark - 查看图片(图片数组作为参数)

- (void)openImageSetWithImages:(NSArray *)images initImageIndex:(int)index {
    
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    [_photosArray removeAllObjects];
    
    for (int i = 0; i < images.count; i++) {
        
        MWPhoto *photo = [MWPhoto photoWithImage:images[i]];///图片封装
        
        [_photosArray addObject:photo];
        
    }
    
    MWPhotoBrowser * browser = [[MWPhotoBrowser alloc] initWithDelegate:self];\
    browser.displayActionButton = YES;
//    browser.wantsFullScreenLayout = YES;
    
    browser.edgesForExtendedLayout = UIRectEdgeNone;
    browser.extendedLayoutIncludesOpaqueBars = NO;
    [browser setInitialPageIndex:index];
    [self presentViewController:browser animated:YES completion:^{
        
    }];
}

#pragma mark - 查看图片(url数组作为参数)

- (void)openImageSetWithUrls:(NSArray *)urls initImageIndex:(int)index {
    
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    [_photosArray removeAllObjects];
    
    for (int i = 0; i < urls.count; i++) {
        
        if ([urls[i] isKindOfClass:[NSURL class]]) {
            
            MWPhoto * photo = [MWPhoto photoWithURL:urls[i]];//url封装
            
            [_photosArray addObject:photo];
            
        }else if ([urls[i] isKindOfClass:[NSString class]]) {
            
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:urls[i]]];//url封装
            
            [_photosArray addObject:photo];
        }
    }
    
    MWPhotoBrowser * browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    //    browser.wantsFullScreenLayout = YES;
    
    browser.edgesForExtendedLayout = UIRectEdgeNone;
    browser.extendedLayoutIncludesOpaqueBars = NO;
    [browser setInitialPageIndex:index];
    
    [self presentViewController:browser animated:YES completion:^{
        
    }];
}

- (BOOL)tokenLogoff:(NSDictionary *)info {
    
    if ([@"500" isEqualToString:info[@"err"]]) {
        
        return YES;
    } else {
        
        return NO;
    }

}

/**
 自定义navigation
 */
- (void)layoutNavigationBarWithString:(NSString *)title {
    
    self.navigationController.navigationBar.hidden = YES;
    
    _navigationBar = [CustomNavigationView customNavigationView];
    
    _navigationBar.navigationDelegate = self;
    
    [self.view addSubview:_navigationBar];
    
    if (nil != title) {
        
        _navigationBar.title.text = title;
    }
}

#pragma -mark CustomNavigationViewDelegate代理

- (void)navigationViewLeftButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationViewRightButton:(UIButton *)sender {
    
    //环信
    if ([self isEnterServer]) {
    
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appDelegate.chatListVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:appDelegate.chatListVC animated:YES];
    
    } else {
        
        [self showAlertViewWithMessage:@"请先登陆" andImage:nil];
    }
}

/**
 跳到店铺详情
 */
- (void)selectShopInfoWith:(NSString *)shopID {
    
    ShowDetailViewController * showDetailVC = [self getStoryBoardControllerWithID:@"ShowDetailViewController"];
    
    showDetailVC.hidesBottomBarWhenPushed = YES;
    
    showDetailVC.shopID = shopID;
    
    [self.navigationController pushViewController:showDetailVC animated:YES];
    
}

/**
 跳到产品详情
 */
- (void)selectProductInfo:(NSString *)productID {
    
   
    

}

/**
 判断是否登录，如果没有登录就跳到登录界面 (还有正在登录中这个暂时没做判断，需要商讨)
 */
- (BOOL)isEnterServer {
    
    if ([UserInfo isEnter]) {
        
        return YES;
   
    } else {
        
        UINavigationController *enterNav = [self storyBoardControllerID:@"Main" WithControllerID:@"EnterNavigation"];
        
        [self.view.window.rootViewController presentViewController:enterNav animated:YES completion:nil];
        
        return NO;
    }
}

- (void)popToRoot {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma -mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ( viewController == tabBarController.viewControllers[0] || viewController == tabBarController.viewControllers[1] ) {
        
        return YES;
    } 
    
    if ([self isEnterServer]) {
        
        return YES;
    } else {
        
        return NO;
    }
}

- (void)initUnreadView {
    
    if (!_unReadView) {
        
        _unReadView = [[UILabel alloc] initWithFrame:CGRectMake(K_UIMAINSCREEN_WIDTH - 20, 25, 15, 15)];
        _unReadView.backgroundColor = [UIColor whiteColor];
        _unReadView.layer.cornerRadius = _unReadView.frame.size.width/2;
        _unReadView.layer.masksToBounds = YES;
        _unReadView.font = [UIFont systemFontOfSize:9];
        _unReadView.textColor = [UIColor blackColor];
        _unReadView.textAlignment = NSTextAlignmentCenter;
        [_unReadView setHidden:YES];
        [_navigationBar addSubview:_unReadView];
        
        AppDelegate * applegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (applegate.unRead == 0) {

            [_unReadView setHidden:YES];
        
        }else {
            
            _unReadView.text = [NSString stringWithFormat:@"%d",applegate.unRead];
            [_unReadView setHidden:NO];
         }
        
      [applegate addObserver:self forKeyPath:@"unRead" options:NSKeyValueObservingOptionNew context:nil];
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"unRead"]) {
        
        int unRead = [[change valueForKey:NSKeyValueChangeNewKey] intValue];
        
        if (unRead == 0) {
            
            [_unReadView setHidden:YES];
            
        }else {
            
            _unReadView.text = [NSString stringWithFormat:@"%d",unRead];
            [_unReadView setHidden:NO];
        }

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
