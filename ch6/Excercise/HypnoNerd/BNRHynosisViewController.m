//
//  BNRHynosisViewController.m
//  HypnoNerd
//
//  Created by 颜木林 on 2019/1/28.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRHynosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHynosisViewController ()

@end

@implementation BNRHynosisViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hynosis";
        UIImage *tabBarIcon = [UIImage imageNamed:@"Hypno@2x"];
        self.tabBarItem.image = tabBarIcon;
    }
    return self;
}

-(void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    BNRHypnosisView *view = [[BNRHypnosisView alloc] initWithFrame:frame];
    self.view = view;
    
    CGRect inputFieldRect = CGRectMake(40, 70, frame.size.width-80, 30);
    UITextField *inputField = [[UITextField alloc] initWithFrame:inputFieldRect];
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:inputField];
    
    UISegmentedControl *colorControl = [[UISegmentedControl alloc] initWithItems:@[@"red", @"green", @"blue"]];
    colorControl.frame = CGRectMake(20, 50, frame.size.width - 40, 20);;
    colorControl.selectedSegmentIndex = 0;
    [colorControl addTarget:view action:@selector(colorChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:colorControl];
}

@end
