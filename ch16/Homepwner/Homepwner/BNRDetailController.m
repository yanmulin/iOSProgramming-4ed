//
//  BNRDetailController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDetailController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation BNRDetailController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:imageView];
    
    self.imageView = imageView;
    
    NSDictionary *views = @{@"imageView":imageView,
                            @"dateLabel":self.dateLabel,
                            @"toolBar":self.toolBar
                            };
    
    NSArray *horizontalConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:views];
    NSArray *verticalConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-8-[imageView]-8-[toolBar]" options:0 metrics:nil views:views];
    
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
    
    [self.view addConstraints: horizontalConstrains];
    [self.view addConstraints: verticalConstrains];
}

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
    
    self.imageView.image = [[BNRImageStore sharedObject] ImageForKey:item.itemKey];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text intValue];
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%@", self.item.itemKey); 
    [[BNRImageStore sharedObject] setImage:image ForKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

-(void)dealloc {
    NSLog(@"dealloc image");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

@end
