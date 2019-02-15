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

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *labels;

@end

@implementation BNRHynosisViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.restorationIdentifier = NSStringFromClass(self.class);
        self.restorationClass = self.class;
        
        self.labels = [[NSMutableArray alloc] init];
        
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
    
    CGRect inputFieldRect = CGRectMake(40, 70, frame.size.width-80, 30);
    UITextField *inputField = [[UITextField alloc] initWithFrame:inputFieldRect];
    inputField.returnKeyType = UIReturnKeyDone;
    inputField.placeholder = @"Hypnotise me";
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    inputField.delegate = self;
    
    self.textField = inputField;
    
    [self.view addSubview:inputField];
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
        label.restorationIdentifier = [NSString stringWithFormat:@"UILabel%d", i];
        [label sizeToFit];
        int xrange = (int)(self.view.bounds.size.width - label.bounds.size.width);
        int x = arc4random() % xrange;
        
        int yrange = (int)(self.view.bounds.size.height - label.bounds.size.height);
        int y = arc4random() % yrange;
        
        CGRect labelFrame = label.frame;
        labelFrame.origin = CGPointMake(x, y);
        label.frame = labelFrame;
        
        [self.view addSubview:label];
        [self.labels addObject:label];
    }
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    return ((UITabBarController *)([UIApplication sharedApplication].delegate.window.rootViewController)).viewControllers[0];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.textField.text forKey:@"fieldText"];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:NO];
    [archiver encodeObject:self.labels forKey:@"subviews"];
    [archiver finishEncoding];
    
    [coder encodeDataObject:data];
    
    [super encodeRestorableStateWithCoder:coder];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    self.textField.text = [coder decodeObjectForKey:@"fieldText"];
    
    NSData * subviewsData = [coder decodeDataObject];
    
    NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:subviewsData];
    NSArray *subviews = [archiver decodeObjectForKey:@"subviews"];
    [archiver finishDecoding];
    
    for(UIView *view in subviews)
    {
        [self.view addSubview:view];
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
