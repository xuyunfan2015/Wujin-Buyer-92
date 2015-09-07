//
//  MemberInforViewController.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/7.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "UserInfo.h"
#import "EaseMob.h"
#import "RegisterViewController.h"
#import "EnterViewController.h"
#import "NicknameViewController.h"

@interface MemberInfoViewController () <UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *memberImage;
@property (weak, nonatomic) IBOutlet UILabel *memberName;

//线条
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;
@property (weak, nonatomic) IBOutlet UIImageView *line5;
@end

@implementation MemberInfoViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"MemberInfoViewController"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"MemberInfoViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.line1.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line2.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line3.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line4.transform = CGAffineTransformMakeScale(1, 0.5f);
    self.line5.transform = CGAffineTransformMakeScale(1, 0.5f);
    
    [self layoutNavigationBarWithString:@"个人信息"];
  //  [self initUnreadView];
    self.navigationBar.rightButton.hidden = YES;
    
    [self loadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserInfo {
    UserInfo *_user = [UserInfo sharedUserInfo];
    
    self.memberName.text = _user.userName;
    
    if (_portrait) {
        
        [self.memberImage setBackgroundImage:_portrait forState:UIControlStateNormal];
        
        self.memberImage.layer.cornerRadius = 25;//半径为25
        self.memberImage.layer.masksToBounds = YES;
    }
}

- (IBAction)quitEnter:(UIButton *)sender {
    
    [[[UIAlertView alloc] initWithTitle:@"警告" message:@"你确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

#pragma -mark UIAlertView - delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"enterInfo"];
        [UserInfo quitEnter];
        
        if ([self.quitDelegate respondsToSelector:@selector(quitEnter)]) {
                
            [self.quitDelegate quitEnter];
        }
    }
}

- (IBAction)alterPortrait:(id)sender {
    
    UIActionSheet *_sheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        _sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", @"拍照", nil];
    } else {
        
        _sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", nil];
    }
    
    _sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;

    _sheet.tag = 250;
    
    [_sheet showInView:self.view];
}

#pragma -mark UIActionSheetDelegate 代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (250 == actionSheet.tag) {
        
        UIImagePickerControllerSourceType sourceType = 0;//代表取消了。。
        
        BOOL isCancel = NO;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                default:
                    isCancel = YES;
                    break;
            }
        } else {
            
            if (0 == buttonIndex) {
                
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            } else {
                
                isCancel = YES;
            }
        }
        
        if (NO == isCancel) {
            
            UIImagePickerController *_pickerController = [[UIImagePickerController alloc] init];
            
            _pickerController.delegate = self;
            _pickerController.sourceType = sourceType;
            _pickerController.allowsEditing = YES;
            
            [self presentViewController:_pickerController animated:YES completion:^{}];
        }
            
    }
}

#pragma -mark UIImagePickerControllerDelegate代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *_pickerImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self uploadImage:_pickerImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image {
    [self showCustomIndicatorWithMessage:UPLOAD_MESSAGE];
    
    NSData *_imageData = UIImagePNGRepresentation(image);
    
    AFHTTPRequestOperationManager *_httpManager = [[AFHTTPRequestOperationManager alloc] init];
    
    _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *path = [NSString stringWithFormat:@"%@%@", hostUrl, UPDATE_AVATAR];
    
    [_httpManager POST:path parameters:@{@"uid":[[UserInfo sharedUserInfo] userID]} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:_imageData name:@"img" fileName:@"img.png" mimeType:@"image/png"];
   
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [CommentResponse parseServerData:responseObject success:^(NSDictionary *successDic) {
            
            [self.memberImage setBackgroundImage:image forState:UIControlStateNormal];
           
            [[UserInfo sharedUserInfo] setImage:successDic[@"heading"]];
            [[UserInfo sharedUserInfo]save];
            
            
            [self showAlertViewWithMessage:@"上传图片成功" andImage:[UIImage imageNamed:@"rightAlertImage"]];
        } fail:^(NSDictionary *failDic) {
            
            [self showAlertViewWithMessage:ERROR_DATA andImage:nil];
            
            [self tokenLogoff:failDic];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showAlertViewWithMessage:ERROR_SERVER andImage:nil];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([@"ToNickname" isEqualToString:segue.identifier]) {
        
        if ([segue.destinationViewController isKindOfClass:[NicknameViewController class]]) {
            
            NicknameViewController *nickname = segue.destinationViewController;
            
            nickname.defaultName = self.memberName;
        }
    }
}
@end
