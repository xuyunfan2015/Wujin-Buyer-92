//
//  AddressEditViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/9.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AddressInfo.h"

@interface AddressEditViewController () <UIAlertViewDelegate, UITextFieldDelegate>

{
    commentNetwordRequest *_networdRequest;
}

@property (strong, nonatomic) NSArray *textFields;
@property (strong, nonatomic) NSString *subURL;
@property (strong, nonatomic) NSMutableDictionary *params;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *detailAddress;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *postcode;

@property (weak, nonatomic) IBOutlet UIButton *variableButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIView *myView;
//线条
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;
@property (weak, nonatomic) IBOutlet UIImageView *line5;
@property (weak, nonatomic) IBOutlet UIImageView *line6;
@property (weak, nonatomic) IBOutlet UIImageView *line7;
@property (weak, nonatomic) IBOutlet UIImageView *line8;
@property (weak, nonatomic) IBOutlet UIImageView *line9;
@property (weak, nonatomic) IBOutlet UIImageView *line10;

@end

@implementation AddressEditViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"AddressEditViewController"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.line.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line5.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line6.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line7.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line8.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line9.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line10.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    
    keyboardView = self.myView;
    
    // Do any additional setup after loading the view.

    [self layoutNavigationBarWithString:@"收货地址管理"];
    
    self.navigationBar.rightButton.hidden = YES;
    
    _textFields = [NSArray arrayWithObjects:self.name, self.address, self.detailAddress, self.telephone, self.postcode, nil];
    
    ////////////
    [self.setDefaults setBackgroundImage:TTImage(@"check_noSelected") forState:UIControlStateNormal];
    [self.setDefaults setBackgroundImage:TTImage(@"check_Selected") forState:UIControlStateSelected];
    
    [self loadStatus];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (nil != _networdRequest) {
        
        [_networdRequest cancelGET];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)defaultAction:(id)sender {
    
    self.setDefaults.selected = !self.setDefaults.selected;
}


- (void)loadStatus {

    
    if (nil == _addressInfo) {
        
        self.saveButton.hidden = YES;
        self.deleteButton.hidden = YES;
        
         self.setDefaults.selected = NO;
        
        [self.variableButton setTitle:@"增加收货地址" forState:UIControlStateNormal];
    
    } else {
        
        [self.variableButton setHidden:YES];
        
        self.name.text = self.addressInfo.name;
        self.address.text = self.addressInfo.address;
        self.telephone.text = self.addressInfo.telephone;
        self.detailAddress.text = self.addressInfo.detailAddress;
        
        if ([self.addressInfo.isDefault intValue] == 1) {
            
            self.setDefaults.selected = YES;
        }else {
            
            self.setDefaults.selected = NO;
        }

    }
}

#pragma -mark storyBoard - Button Action

- (IBAction)variableAction:(id)sender {
   
    [self.view endEditing:YES];//结束页面所有编辑
    
    if ([self canSendToServer]) {
        NSString *message = nil;
        
        switch ([sender tag]) {
            case 0:
                if ([@"增加收货地址" isEqualToString:self.variableButton.titleLabel.text]) {
                    
                    _subURL = ADDRESS_ADD_URL;
                    _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                               [[UserInfo sharedUserInfo] userID], @"uid",
                               [self.name.text cleanStringEmpty], @"name",
                               [self.address.text cleanStringEmpty], @"qid",
                               [self.detailAddress.text cleanStringEmpty], @"address",
                               [self.telephone.text cleanStringEmpty], @"phone",
                               (self.setDefaults.selected?@"1":@"0"),@"isdefault",
                               nil];
                    
                    message = @"确定增加一个新的收货地址吗？";
               
                } else {
                    
//                    _subURL = ADDRESS_DEF_URL;
//                    _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                               [[UserInfo sharedUserInfo] userID], @"buyerID",
//                               self.addressInfo.ID, @"ID",
//                               [[UserInfo sharedUserInfo] token], @"token",nil];
//                    
//                    message = @"你确定将这个地址设为默认地址吗？";
                }
                break;
                
            case 1:
                _subURL = ADDRESS_DEL_URL;
                _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [[UserInfo sharedUserInfo] userID], @"uid",
                           self.addressInfo.ID, @"id",nil];
                
                message = @"你确定要删除这个地址吗？";
                break;
                
            case 2:
                _subURL = ADDRESS_ALT_URL;
                _params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [[UserInfo sharedUserInfo] userID], @"uid",
                           [self.name.text cleanStringEmpty], @"name",
                           [self.address.text cleanStringEmpty], @"qid",
                           [self.detailAddress.text cleanStringEmpty], @"address",
                          
                           [self.telephone.text cleanStringEmpty], @"phone",
                           self.addressInfo.ID, @"id",
                           (self.setDefaults.selected?@"1":@"0"),@"isdefault",
                           nil];
                
                message = @"你确定修改这个地址吗？";
                
                break;
        }
        
        [self showAlertWithTitle:@"提示" message:message];
    
    } else {
        
        [self showAlertViewWithMessage:@"必填项不能为空" andImage:nil];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self hideCustomIndicator];
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        
        [self showCustomIndicatorWithMessage:UPLOAD_MESSAGE];
            
        _networdRequest = [commentNetwordRequest POST:_subURL withParams:_params success:^(NSDictionary *successDic) {
            
            [self hideCustomIndicator];
           
            [self popToPre:nil];
            
        } failer:^(NSDictionary *failerDic) {
            
            [super showAlertViewWithMessage:[failerDic valueForKey:@"errMsg"] andImage:nil];
            
            [self tokenLogoff:failerDic];
        }];
    }
}

//判断是否可以连接网络
- (BOOL)canSendToServer {
    
    if ([self textIsEmpty]) {
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textIsEmpty {
    if (0 == self.name.text.length || 0 == self.address.text.length || 0 == self.detailAddress.text.length || 0 == self.telephone.text.length) {
        return YES;
    }
    
    return NO;
}

#pragma -mark textView -- delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSUInteger index = [_textFields indexOfObject:textField];
    if (4 != index) {
        
        [_textFields[++index] becomeFirstResponder];
    } else {
        
        [textField endEditing:YES];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    //textFrame = textField.frame;
    
    textFrame = [textField convertRect:textField.frame /* 这个参数不要写错啊。。。血的教训 */ toView:self.myView];//将text的坐标转换为当前view的坐标
    
    if (first) {
//        
        first = NO;
    } else {
//
        
        [self keyboardWillShow:myNotification];
    }
}

//注册键盘弹出事件
- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"AddressEditViewController"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)popToPre:(NSDictionary *)aDic {
    
    if ([ADDRESS_ADD_URL isEqualToString: _subURL]) {//增加
        
        if ([self.addressDelegate respondsToSelector:@selector(addressEditState:andInfo:)]) {
            
            [self.addressDelegate addressEditState:kAddressStateAdd andInfo:nil];
        }
    
    } else if ([ADDRESS_ALT_URL isEqualToString:_subURL]) {//修改

        self.addressInfo.name = _params[@"name"];
        self.addressInfo.address = _params[@"qid"];
        self.addressInfo.detailAddress = _params[@"address"];
        self.addressInfo.telephone = _params[@"phone"];
        self.addressInfo.isDefault = _params[@"isdefault"];
        
        [self.addressDelegate addressEditState:kAddressStateAlt andInfo:self.addressInfo];
        
    } else if ([ADDRESS_DEL_URL isEqualToString:_subURL]){//删除
        
        [self.addressDelegate addressEditState:kAddressStateSub andInfo:self.addressInfo];
   
    } else {//更改默认
        
        [self.addressDelegate addressEditState:kAddressStateDef andInfo:self.addressInfo];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
