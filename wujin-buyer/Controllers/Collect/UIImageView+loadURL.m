//
//  UIImageView+loadURL.m
//  wujin-buyer
//
//  Created by wujin  on 15/1/13.
//  Copyright (c) 2015年 wujin. All rights reserved.
//

#import "UIImageView+loadURL.h"

@implementation UIImageView (loadURL)

- (void)loadURL:(NSString *)subURL {
    
    NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", hostUrl,subURL]];
    
    NSURLRequest *_urlReq = [[NSURLRequest alloc] initWithURL:_url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.f];
    
    [NSURLConnection sendAsynchronousRequest:_urlReq queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError && nil != data) {
            
            UIImage *_image = [UIImage imageWithData:data];
            
            [self performSelectorOnMainThread:@selector(loadImage:) withObject:_image waitUntilDone:NO];
        } else {
            
  //          NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
   //         NSLog(@"error--%@", connectionError.localizedDescription);
        }
    }];

}

- (void)loadImage:(UIImage *)image {
    
    if (nil != image) {
        
        self.image = image;
    }
}
@end
