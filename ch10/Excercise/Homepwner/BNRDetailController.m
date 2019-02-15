//
//  BNRDetailController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDetailController.h"
#import "BNRItem.h"
#import "BNRDatePickerViewController.h"

@interface BNRDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       
                                                                                    target:self
                                                                            action:@selector(hideKeyboard:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    
    return self;
}
//
//-(void)loadView {
//    [super loadView];
//
//
//}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

-(void)hideKeyboard:(id)sender {
    if ([self.valueField isFirstResponder]) {
        [self.valueField resignFirstResponder];
    } else if ([self.nameField isFirstResponder]) {
        [self.nameField resignFirstResponder];
    } else if ([self.serialField isFirstResponder]) {
        [self.serialField resignFirstResponder];
    }
}

- (IBAction)changeDate:(id)sender {
    BNRDatePickerViewController *dvc = [[BNRDatePickerViewController alloc] init];
    dvc.item = self.item;
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
