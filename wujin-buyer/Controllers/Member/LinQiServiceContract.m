//
//  LinQiServiceContract.m
//  wujin-seller
//
//  Created by wujin  on 15/3/16.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "LinQiServiceContract.h"

@interface LinQiServiceContract ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LinQiServiceContract

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"LinQiServiceContract"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"LinQiServiceContract"];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setting];
    
    [self loadHTML];
}

#pragma mark 加载本地html文件
- (void)loadHTML
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"service.html" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
}

- (void)setting {
    
    [self layoutNavigationBarWithString:@"林琦服务协议"];
    self.navigationBar.rightView.hidden = YES;
}

- (void)loadFileData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LinQi_Service_Contract.doc" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    //NSLog(@"%@", [self mimeType:url]);
    
    //webview加载本地文件，可以使用加载数据的方式
    //第一个诶参数是一个NSData， 本地文件对应的数据
    //第二个参数是MIMEType
    //第三个参数是编码格式
    //相对地址，一般加载本地文件不使用，可以在指定的baseURL中查找相关文件。
    
    //以二进制数据的形式加载沙箱中的文件，
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    
//    [self.webView loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
    [self.webView loadRequest:urlRequest];
}

@end
