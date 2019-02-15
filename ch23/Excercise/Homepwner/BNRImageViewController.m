//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@end

@implementation BNRImageViewController

-(void)loadView {
    [super loadView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView *imageView = (UIImageView*)self.view;
    imageView.image = self.image;
}

@end
