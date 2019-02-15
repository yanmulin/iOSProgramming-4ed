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

-(void)drawHypnosisMessage:(NSString*)text;

@property (nonatomic) UITextField *inputField;

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
    self.view = [[BNRHypnosisView alloc] initWithFrame:frame];
    
//    CGRect inputFieldRect = CGRectMake(40, 70, frame.size.width-80, 30);
    CGRect inputFieldRect = CGRectMake(40, -20, 240, 30);
    UITextField *inputField = [[UITextField alloc] initWithFrame:inputFieldRect];
    inputField.returnKeyType = UIReturnKeyDone;
    inputField.placeholder = @"Hypnotise me";
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    inputField.delegate = self;
    
    self.inputField = inputField;
    
    [self.view addSubview:inputField];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 70, 240, 30);
                         self.inputField.frame = frame;
                     }
                     completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    [self drawHypnosisMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

-(void)drawHypnosisMessage:(NSString *)text
{
    for (int i=0;i<20;i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        int xrange = (int)(self.view.bounds.size.width - label.bounds.size.width);
        int x = arc4random() % xrange;
        
        int yrange = (int)(self.view.bounds.size.height - label.bounds.size.height);
        int y = arc4random() % yrange;
        
        CGRect labelFrame = label.frame;
        labelFrame.origin = CGPointMake(x, y);
        label.frame = labelFrame;
        
        [self.view addSubview:label];
        
        label.alpha = 0.0;
        
        [UIView animateWithDuration:1.0
                              delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             label.alpha = 1.0;
                         } completion:nil];
        
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.2
                                                                    animations:^{
                                                                        label.center = self.view.center;
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.2
                                                              relativeDuration:0.8
                                                                    animations:^{
                                                                        int x = arc4random() % xrange;
                                                                        int y = arc4random() % yrange;
                                                                        label.center = CGPointMake(x, y);
                                                                    }];
                                  } completion:^(BOOL finished){
                                      NSLog(@"Animation done");
                                  }];
        
    }
}

@end
