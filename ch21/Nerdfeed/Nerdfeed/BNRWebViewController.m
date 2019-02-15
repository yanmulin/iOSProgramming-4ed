//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRWebViewController.h"
#import <WebKit/WebKit.h>

@interface BNRWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation BNRWebViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.webView = [[WKWebView alloc] init];
        self.view = self.webView;
    }
    return self;
}

-(void)setUrl:(NSURL *)url {
    _url = url;
    if (url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:req];
    }
}

@end
