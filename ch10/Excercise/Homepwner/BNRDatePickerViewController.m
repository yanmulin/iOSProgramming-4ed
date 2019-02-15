//
//  BNRDatePickerViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/15.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDatePickerViewController.h"
#import "BNRItem.h"

@interface BNRDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDatePickerViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.datePicker.date = self.item.dateCreated;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    self.item.dateCreated = self.datePicker.date;
}

-(void)done:(id)sender {
    self.item.dateCreated = self.datePicker.date;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
