//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by 颜木林 on 2019/2/1.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawViewController ()

@property (nonatomic) BNRDrawView *drawView;

@end

@implementation BNRDrawViewController

-(void)loadView {
    self.drawView = [[BNRDrawView alloc] initWithFrame:CGRectZero];
    self.view = self.drawView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.drawView loadLines];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"Disapper");
    [self.drawView saveLines];
}

@end
