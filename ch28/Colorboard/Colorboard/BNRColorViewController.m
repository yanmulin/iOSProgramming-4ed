//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by 颜木林 on 2019/2/14.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRColorViewController.h"
#import "BNRColorDescription.h"
#import <UIKit/UIKit.h>

@interface BNRColorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation BNRColorViewController

-(void)loadView {
    [super loadView];
    
    if (self.isExistingColor) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)viewDidLoad {
    CGFloat red, green, blue;
    
    [self.colorDescription.color getRed:&red
                                  green:&green
                                   blue:&blue
                                  alpha:nil];
    
    self.view.backgroundColor = self.colorDescription.color;
    
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    self.textField.text = self.colorDescription.name;
}

-(void)viewWillDisappear:(BOOL)animated {
    self.colorDescription.color = self.view.backgroundColor;
    self.colorDescription.name = self.textField.text;
}

-(IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changColor:(id)sender {
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    
    UIColor *color = [UIColor colorWithRed:red
                                     green:green
                                      blue:blue
                                     alpha:1.0];
    self.view.backgroundColor = color;
}

@end
