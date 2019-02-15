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
        self.webView.navigationDelegate = self;
        self.view = self.webView;
        
        UIBarButtonItem *backwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.webView action:@selector(goBack)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.webView action:@selector(goForward)];
        self.toolbarItems = @[backwardButton, flexibleSpace, forwardButton];
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

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.toolbarItems.firstObject setEnabled:self.webView.canGoBack];
    [self.toolbarItems.lastObject setEnabled:self.webView.canGoForward];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

@end
