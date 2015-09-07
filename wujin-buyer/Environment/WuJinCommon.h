//
//  BLMCommon.h
//  Yujia001
//
//  Created by pansj on 13-9-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppUtil.h"
#import "NSString+CleanStringEmpty.h"
#import "commentNetwordRequest.h"
#import "CommentRequest.h"
#import "CommentResponse.h"
#import "UserInfo.h"
#import "MobClick.h"

//#define BAIDU_API_KEY @"MmzhiIT3XZ0YkKUU3neFzOA2" //已经换为挑夫
#define BAIDU_API_KEY @"G21NcY7MosGHRgxiGcqxMxx0"
#define U_MENG_API_KEY @"556bbc0067e58e9125002d21"//已更换为挑夫

#define SYSTEM_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]
/*常用类*/
#define SYSTEM_BIGTHAN_7 ([[[UIDevice currentDevice]systemVersion]floatValue] ==7.0)||([[[UIDevice currentDevice]systemVersion]floatValue]>7)
#define SYSTEM_BIGTHAN_8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)  
#define MYUSERINFO [BLMUserInfo shareBLMUserInfo]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define DELTA_HEIGHT ((SYSTEM_BIGTHAN_7)?20:0)

// 获取memberId
#define PATHS   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
#define PATH     [PATHS objectAtIndex:0]
#define USER_INFO_PATH    [PATH stringByAppendingPathComponent:@"/userInfo.plist"]
#define MEMBER_INFO   [NSDictionary dictionaryWithContentsOfFile:USER_INFO_PATH]
#define USER_AVATAR_PATH  [PATH stringByAppendingPathComponent:@"/avatar.png"]

//message
#define NO_NETWORK_MESSAGE @"暂无网络"
#define LOADING_MESSAGE @"正在加载中..."
#define UPLOAD_MESSAGE @"上传中..."
#define ENTER_MESSAGE @"登录中..."
#define REGISTER_MESSAGE @"注册中..."

//error
#define ERROR @"错误"
#define ERROR_SERVER @"无法连接至服务器"
#define ERROR_DATA @"获取数据失败"
#define ERROR_NETWORK @"没有网络连接"
#define ERROR_PHONE @"手机号码不能为空"
#define ERROR_HAVETO @"必填项不能为空"

/*屏幕尺寸常量*/
#define K_UIMAINSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define K_UIMAINSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height - (20 - DELTA_HEIGHT))

#define URLSCHEME @"tf-Buyer"
#define PLACE_HORDER_COLOR [UIColor colorWithWhite:0.712 alpha:0.000]
#define PLACE_HORDER_IMAGE(view) [AppUtil imageFromColor:PLACE_HORDER_COLOR Rect:view.bounds]

//#define hostUrl @"http://120.26.41.195:8080/xmb/" //发布地址
#define hostUrl @"http://120.26.41.195:8081/ljc/"
#pragma mark - 接口URL

#define LOGIN_URL	@"Login/shopLogin"
#define REGISTER_URL @"Login/interfaceyhjzc"
#define AUTH_CODE @"Login/interfacescbdsoursyzmbyphone"
///
#define BANNER_URL @"banner/interface/list"//首页banner图片

#define SHOPSEARCH_BY_NAME @"shop/interfaceshopbysname"
#define ALL_SHOPS @"shop/interfaceshopList"//获取所有的商店
#define SHOP_PRODUCTS @"commodity/interfaceshopbyshopid"//获取店铺种的商品
#define SHOP_CATEGORY @"shop/shopCommodityList"//获取商店类别
#define SHOP_PRODUCT_COUNT @"shop/selectcmcout"
#define SHOP_DETAILVIEW @"shop/ay/info"//获取shop详情页

#define SHOUHUO_ACTION @"order/interfaceorderqrsh"

#define ALL_CATEGORY @"commodity/interfacespecies"//获取所有类别
#define GET_PRODUCTS_BY_CATEGORYID @"commodity/interfacecmbyflid"
#define GET_PRODUCT_BY_SMALLID @"shop/smpeciesShopList"

#define SM_CATEGORY @"shop/smpeciesShopList"

#define T_SHOP_COLLECT @"collection/interfacescdp"//收藏店铺

//收藏
#define ALL_COLLECTS @"collection/interfacecom"


//购物车
#define ADD_TO_CAR @"order/interfacejrgwc"
#define CAR_LIST @"order/interfaceBuyList"
#define CAR_SUB @"order/interfacejsgwc"

///收获地址
#define ADDRESS_ADD_URL @"address/Addaddress" //增加收货地址
#define ADDRESS_ALT_URL @"address/updateaddress" //修改收货地址
#define ADDRESS_DEL_URL @"address/addressDel" //删除收货地址
#define ADDRESS_GET_URL @"address/addressList" //收货地址 (得到所有收货地址)

#define BUYER_EDITNAME_URL @"user/updateusername"//修改昵称

#define ALT_URL @"Login/interfacescbdcsmm"//修改密码
#define UPDATE_AVATAR  @"user/updateuserheading"

#define BUY_URL @"order/interfaceorderbuy"

#define ORDER_LIST @"order/interfaceddhistory"

#define ORDER_DETAIL @"order/orderdetails"

#define COMMIT_SUGGEST_URL @"userfk/Adduserfk"//提交建议

/////个人中心////
#define REG_URL @"buyerApi/buyer/register"//注册
#define ENT_URL @"buyerApi/buyer/login"//登录

#define FIND_URL @"buyerApi/buyer/find_buyer_passwd"//找回密码
#define SEND_AUTH_URL @"buyerApi/buyer/buyer_mobile_code"//发送验证码


#define COLLECT_SELECT_URL @"buyerApi/collect/buyer_collect_show"//得到所有的收藏
#define COLLECT_SHOP_DELEGATE_URL @"buyerApi/collect/buyer_collect_shop_delete"//删除收藏的店铺
#define COLLECT_PRODUCT_DELETE_URL @"buyerApi/collect/buyer_collect_product_delete"//删除收藏的产品
#define UPLOAD_IMAGE_URL @"buyerApi/buyer/upload_user_image" //上传图片

             //小小订单，可笑可笑//
#define HISTAYR_INDENT_URL @"buyerApi/order/person_order" //获取历史订单
#define DETAIL_INDENT_URL @"buyerApi/order/buyer_order_detail"//获取订单详情
#define VIP_INDENT_URL @"buyerApi/order/buyer_order_vip"//获取vip订单
#define WAITPAY_INDENT_URL @"buyerApi/order/buyer_order_waitpay"//获取待付款订单
#define WAITSHIPMENT_INDENT_URL @"buyerApi/order/buyer_order_waitsend" //获取待发货订单
#define WAITACCEPT_INDENT_URL @"buyerApi/order/buyer_order_waitreceive" //获取待收货订单
#define DELEGATE_INDENT_URL @"buyerApi/order/buyer_order_delete" //删除这个订单

             //支付，退货等有关于钱的操作//
#define PAYMENT_INDENT_URL @"buyerApi/pay/buyer_order_pay"//支付
#define SENDNOT_REFUND_URL @"buyerApi/pay/seller_sendnot_refund"//退款（待发货）
#define SENDDID_REFUND_URL @"buyerApi/pay/seller_send_refund"//退款（已发货）
#define DID_ACCEPT_URL @"buyerApi/order/buyer_order_finish"//确认收货

////首页///
#define MARKET_URL @"buyerApi/search/market"//根据经纬度得到市场
#define LOCATION_URL @"buyerApi/search/location_list"//得到位置列表
#define ADDRESS_URL @"buyerApi/search/location_market_search"//根据城市id得到市场

/////店铺//
#define SHOP_LIST_FORM_MARKET @"buyerApi/search/buyer_shop_search_market"//从市场进入店铺列表
#define SHOP_LIST_FROM_SHOP  @"buyerApi/search/buyer_shop_search_shop"//从tabbar进入店铺列表

//#define SHOP_LIST    @"buyerApi/search/buyer_shop_search"//店铺列表(默认的商品列表)
//#define SHOP_SEARCH  @"buyerApi/search/buyer_shop_search_key"//店铺搜索(根据关键字搜索店铺)
#define SHOP_DETAIL  @"buyerApi/search/buyer_shop_detail" //店铺详情信息
#define SHOP_PRODUCT @"buyerApi/search/shop_product_default"//店铺下的商品列表(默认列表)
#define SHOP_COLLECT @"buyerApi/collect/collect_shop"//收藏店铺()
#define SHOP_PRODUCT_SEARCH @"buyerApi/search/shop_product_seach"//店铺下的商品搜索列表

#define MARKET_PRODUCT_FORM_MARKET @"buyerApi/search/market_product_seach"//市场下的商品列表（从市场进入）
#define MARKET_PRODUCT_FROM_SHOP @"buyerApi/search/market_product_shop_seach"//从首页店铺进入

/////分类////
#define PRODUCT_CATEGORYS   @"buyerApi/search/shop_product_category"//店铺下的分类()

///////商品//////
#define PRODUCT_BY_CATEGORY  @"buyerApi/search/product_category_level_seach"//根据类别查找

#define PRODUCT_DETAIL          @"buyerApi/search/product_detail" ////商品详情()
#define PRODUCT_DETAIL_CATEGORY @"buyerApi/search/product_detail_category"//商品类别选择()
#define PRODUCT_COLLECT         @"buyerApi/collect/collect_product"//商品收藏 ()

////购物车
#define CAR_ADD @"buyerApi/shoppingCart/shopping_cart_add"//（）加入购物车
#define CAR_SHOW @"buyerApi/shoppingCart/shopping_cart_show"//()//购物车展示
#define CAR_DEL @"buyerApi/shoppingCart/shopping_cart_delete"//()//删除购物车商品
#define CAR_EDIT @"buyerApi/shoppingCart/shopping_cart_editor"//()//编辑购物车

#define INSTANT_BUY_CHANGE_ADDRESS @"buyerApi/shoppingCart/buyer_buy_now_editaddress"//()

///订单模块
#define PLACE_ORDER @"buyerApi/order/place_your_order"//下订单
#define COMFIRM_ORDER @"buyerApi/order/confirm_your_order"//确认订单
#define HISTORY_ORDER @"buyerApi/order/person_order" //历史订单

#define LOAD_FREIGHT_URL @"buyerApi/order/place_editaddress_order" //更改收货人重新计算运费

#define INSTANT_BUY @"buyerApi/shoppingCart/buyer_buy_now" ///立即购买

///环信聊天
#define USERINFO_BY_ACCOUNT @"buyerApi/buyer/seller_userinfo"


#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

/* { thread } */
#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

/*常用方法*/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define HEXCOLOR(hexString)  [UIColor colorWithHexString:hexString]
#define DARK_BLUE RGBCOLOR(0x47,0x88,0xb2)
#define LIGHT_BLUE RGBCOLOR(0x76,0xb2,0xd4)
#define OTHER_BLUE RGBCOLOR(0x1c,0x63,0x8d)
#define TEXT_COLOR RGBCOLOR(0x48,0x48,0x48)
#define LIGHT_TEXT_COLOR RGBCOLOR(0x98,0x98,0x98)
#define LINE_COLOR RGBCOLOR(0xdc,0xdc,0xdc)
#define LIGHT_GREEN RGBCOLOR(0x61,0xc3,0xd5)

#define SEGEMENT_BTN_COLOR RGBCOLOR(0xf1,0xf1,0xf1)
#define SEGEMENT_TITLE_COLOR RGBCOLOR(0x61,0xc3,0xd5)

#define BLACK_TEXT_COLOR RGBCOLOR(0x11,0x11,0x11)
#define LIGHT_BLACK_COLOR RGBCOLOR(0x88,0x88,0x88)
#define BLUE_NAV_COLOR RGBCOLOR(0x13,0xa7,0xe5)
#define CELL_SELECTED_COLOR RGBCOLOR(0xdf,0xdf,0xdf)
#define LIGHT_LINE_COLOR RGBCOLOR(0xd8,0xd8,0xd8)

//自定义颜色
#define NAV_TAB_COLOR RGBCOLOR(212, 61, 60)

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define CITY_DICT @"cityDict"
//#define COLORWITHHEX(hexString) [UIColor colorWithHexString:hexString]


#ifndef TTImage
#define TTImage(_IMAGENAME_) [UIImage imageNamed: _IMAGENAME_ ]
#endif
#ifndef TTFont
#define TTFont(_FONTSIZE_) [UIFont systemFontOfSize:_FONTSIZE_]
#endif
#ifndef TTBoldFont
#define TTBoldFont(_FONTSIZE_) [UIFont boldSystemFontOfSize:_FONTSIZE_]
#endif
#ifndef BUTTON_CUSTOM 
#define BUTTON_CUSTOM [UIButton buttonWithType:UIButtonTypeCustom]
#endif
#ifndef BLACK_COLOR
#define BLACK_COLOR [UIColor blackColor]
#endif
#ifndef CLEAR_COLOR 
#define CLEAR_COLOR [UIColor clearColor]
#endif
#ifndef WHITE_COLOR 
#define WHITE_COLOR [UIColor whiteColor]
#endif
#ifndef RED_COLOR
#define RED_COLOR [UIColor redColor]
#endif
#define DARKGRAY_COLOR [UIColor darkGrayColor]
#define GRAY_COLOR [UIColor grayColor]
#define TTUrl(_URL_) [NSURL URLWithString: _URL_ ]

#define PLACEHOLDER_IMAGE TTImage(@"thedefault_04")
#define CHANGGUAN_PLACEHOLDER_IMAGE TTImage(@"thedefault_01")
#define CHANGGUAN_LOGO_PLACEHOLDER TTImage(@"thedefault_02")
#define PHOTO_PLACEHOLDER TTImage(@"thedefault_03")
 
#define MORE_IMAGE TTImage(@"btn_more_unselected")



#ifndef PopAnimation
#define PopAnimation      CATransition *transition = [CATransition animation];\
transition.duration = 0.2f;\
transition.type = kCATransitionReveal;\
transition.subtype = kCATransitionFromLeft;\
[self.navigationController.view.layer addAnimation:transition forKey:@"animation"];\
[self.navigationController popViewControllerAnimated:NO];
#endif
#ifndef PushAnimation
#define PushAnimation      CATransition *transition = [CATransition animation];\
transition.duration = 0.2f;\
transition.type = kCATransitionMoveIn;\
transition.subtype = kCATransitionFromRight;\
[self.navigationController.view.layer addAnimation:transition forKey:@"animation"];
#endif

//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_blue_lump.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];

#ifndef NAV_COLOR_DEFINE 
#define NAV_COLOR_DEFINE    if (SYSTEM_BIGTHAN_7) \
[self.navigationController.navigationBar setBackgroundImage:TTImage(@"bg_blue_blump") forBarPosition:UIBarPositionTopAttached barMetrics:UIBarStyleDefault];\
else \
[self.navigationController.navigationBar setBackgroundImage:TTImage(@"bg_blue_blump_ios6") forBarMetrics:UIBarStyleDefault];
#endif

#ifndef NAV_RIGHT_TITLE
#define NAV_RIGHT_TITLE(x,color) UIButton *rightBtn=BUTTON_CUSTOM;\
[rightBtn setTitle:x forState:UIControlStateNormal];\
rightBtn.frame=CGRectMake(320-50,(44-20)/2,50,20);\
 [rightBtn setTitleColor:color forState:UIControlStateNormal];\
[rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];\
UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];\
self.navigationItem.rightBarButtonItem=rightItem;
#endif

#ifndef NAV_BACK_BTN
#define NAV_BACK_BTN   UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];\
UIImage *leftImage=[UIImage imageNamed:@"btn_back"];\
[leftBtn setImage:leftImage forState:UIControlStateNormal];\
[leftBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateHighlighted];\
leftBtn.frame=CGRectMake(25,(44-leftImage.size.height)/2,leftImage.size.width, leftImage.size.height);\
[leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];\
UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];\
self.navigationItem.leftBarButtonItem =leftItem;
#endif


#ifndef TITLE_VIEW 
#define TITLE_VIEW(x) UILabel *titleLabel = [[UILabel alloc] init];\
titleLabel.backgroundColor  = [UIColor clearColor];\
titleLabel.textColor        = [UIColor whiteColor];\
titleLabel.text             = x;\
[titleLabel sizeToFit];\
self.navigationItem.titleView = titleLabel;
#endif


#define BACKGROUND_COLOR [UIColor colorWithRed:0xE6/255.0 green:0xE6/255.0 blue:0xE6/255.0 alpha:0xE6/255.0]

#define K_OFFLNE_NOTIICATION @"K_OFFLNE_NOTIICATION"

#define K_LOCATIOIN_UPDATE_SUCCESS @"K_LOCATIOIN_UPDATE_SUCCESS"

#define K_PULL_BLACK_NOTIFICATION @"K_PULL_BLACK_NOTIFICATION"

#define K_UPDATE_CONTACTS @"K_UPDATE_CONTACTS"

#define K_CHANGE_AVATAR_NOTIFICATION @"K_CHANGE_AVATAR_NOTIFICATION"//更换头像

#define KNOTIFICATION_LOGINCHANGE @"KNOTIFICATION_LOGINCHANGE"//

#define K_SET_AXISNAME_NOTIFICATION @"K_SET_AXISNAME_NOTIFICATION"

#define K_GOTOLOGIN_FROM_SET @"K_GOTOLOGIN_FROM_SET"

#define K_GOTOLOGIN_NOTIFICATION @"K_GOTOLOGIN_NOTIFICATION"
#define K_LOGIN_NOTIFICATION @"K_LOGIN_NOTIFICATION"
#define K_PERSON_LEAVE_NOTIFICATION @"K_PERSON_LEAVE_NOTIFICATION"
#define k_CAFE_LEAVE_NOTIFICATION @"k_CAFE_LEAVE_NOTIFICATION"

#define K_UPDATE_SHOP @"K_UPDATE_SHOP"
/*消息*/
#define K_ADDPHOTO_NOTIFICATION @"K_ADDPHOTO_NOTIFICATION"
#define K_PHOTOCHOOSED_NOTIFICATION @"K_PHOTOCHOOSED_NOTIFICATION"
#define K_BTNCLICKED_NOTIFICATION @"K_BTNCLICKED_NOTIFICATION"
#define K_CHANGEINFO_NOTIFICATION @"K_CHANGEINFO_NOTIFICATION"
#define K_PUSHTOMEMBER_NOTIFICATION @"K_PUSHTOMEMBER_NOTIFICATION"
#define K_TOUCHBEGIN_NOTIFICATION @"K_TOUCHBEGIN_NOTIFICATION"
#define K_REACH_CHANGE_NOTIFICATION @"kNetworkReachabilityChangedNotification"
#define K_PUSH_MESSAGE_NOTIFICATION @"K_PUSH_MESSAGE_NOTIFICATION"
#define K_PUSH_DETAIL_NOTIFICATION @"K_PUSH_DETAIL_NOTIFICATION"
#define K_ADDorDELETE_NOTIFICATION @"K_ADDorDELETE_NOTIFICATION"
#define K_ALREADY_SIGN_NOTIFICATION @"K_ALREADY_SIGN_NOTIFICATION"
#define K_COLOCK_NOTIFICATION @"K_COLOCK_NOTIFICATION"
#define K_CLEANDATA_NOTIFICATION @"K_CLEANDATA_NOTIFICATION"
#define K_CHANGE_CLOCK_NOTIFICATION @"K_CHANGE_CLOCK_NOTIFICATION"
#define K_CLOCK_NOTIFICATION @"K_CLOCK_NOTIFICATION"
#define K_MEMBER_NOTIFICATION @"K_MEMBER_NOTIFICATION"
#define K_POPBACK_NOTIFICATION @"K_POPBACK_NOTIFICATION"
#define K_HAS_SIGNIN_NOTIFICATION @"K_HAS_SIGNIN_NOTIFICATION"//登陆
#define K_COLLECT_VIDEO_NOTIFICATION @"K_COLLECT_VIDEO_NOTIFICATION" //收藏视频
#define K_ADD_FRIEND_NOTIFICATION @"K_ADD_FRIEND_NOTIFICATION"
#define K_CITYCHANGE_NOTIFICATION @"K_CITYCHANGE_NOTIFICATION"
#define K_CATEGORY_NOTIFICATION @"K_CATEGORY_NOTIFICATION"
#define K_LOCATION_CLICK_NOTIFICATION @"K_LOCATION_CLICK_NOTIFICATION"
#define K_KEYWORD_NOTIFICATION @"K_KEYWORD_NOTIFICATION"
#define K_LOGOUT_NOTIFICATION @"K_LOGOUT_NOTIFICATION"



/*设备版本号比较*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

