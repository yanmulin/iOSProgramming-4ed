//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation BNRImageViewController


// Gold Challenge
-(void)loadView {
    [super loadView];
    CGRect frame = CGRectMake(0, 0, 600, 600);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    [scrollView addSubview:imageView];
    imageView.frame = frame;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    scrollView.contentSize = self.image.size;
    
    CGFloat zoomScale = MAX(frame.size.width / imageView.bounds.size.width, frame.size.height / imageView.bounds.size.height);
    
    NSLog(@"%f", zoomScale);
    
    scrollView.maximumZoomScale = 5.0;
    scrollView.minimumZoomScale = zoomScale;
    scrollView.zoomScale = zoomScale;
    scrollView.delegate = self;
    
    self.view = scrollView;
    self.scrollView = scrollView;
    self.imageView = imageView;
}

-(void)viewWillAppear:(BOOL)animated {
//    self.imageView.image = self.image;
//    self.scrollView.contentMode =
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"scale: %f", scale);
}



@end
