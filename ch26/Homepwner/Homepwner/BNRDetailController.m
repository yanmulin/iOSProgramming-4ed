//
//  BNRDetailController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDetailController.h"
#import "BNRItem+CoreDataClass.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"
#import "BNRAssetTypesViewController.h"
#import "BNRAssetType+CoreDataClass.h"
#import "AppDelegate.h"

@interface BNRDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;

@end

@implementation BNRDetailController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}

-(instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = self.class;
        
        if (isNew) {
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelButton;
            
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneButton;
        }
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateFont) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

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
    self.valueField.text = [NSString stringWithFormat:@"%ld", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    self.imageView.image = [[BNRImageStore sharedObject] ImageForKey:item.itemKey];
    
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareForInterfaceOrientation:currentOrientation];
    
    [self updateFont];
    
    BNRAssetType *assetType = item.assetType;
    if (!assetType) {
        self.assetTypeButton.title = NSLocalizedString(@"None", @"Type label None");
    } else {
        self.assetTypeButton.title = [NSString stringWithFormat:NSLocalizedString(@"Type: %@", @"Asset type button"), assetType.labelString];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSInteger newValue = [self.valueField.text intValue];
    
    if (newValue != self.item.valueInDollars) {
        self.item.valueInDollars = newValue;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:newValue forKey:BNRNextItemValuePrefsKey];
    }
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        imagePicker.modalPresentationStyle = UIModalPresentationPopover;
        imagePicker.popoverPresentationController.barButtonItem = sender;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[BNRImageStore sharedObject] setImage:image ForKey:self.item.itemKey];
    
    self.imageView.image = image;
    self.item.thumbnail = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareForInterfaceOrientation:currentOrientation];
}

-(void)prepareForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return ;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

-(void)cancel:(id)sender {
    [[BNRItemStore sharedObject] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)save:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)updateFont {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialLabel.font = font;
    self.valueLabel.font = font;
    self.nameField.font = font;
    self.serialField.font = font;
    self.valueField.font = font;
    self.dateLabel.font = font;
}

- (IBAction)showAssetTypes:(id)sender {
    BNRAssetTypesViewController *avc = [[BNRAssetTypesViewController alloc] init];
    avc.item = self.item;
    [self.navigationController pushViewController:avc animated:YES];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    BOOL isNew = NO;
    if ([identifierComponents count] == 3) {
        isNew = YES;
    }
    return [[BNRDetailController alloc] initForNewItem:isNew];
}

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.item.itemKey forKey:@"itemKey"];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
    
    [[BNRItemStore sharedObject] saveChanges];
    
    [super encodeRestorableStateWithCoder:coder];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSString *itemKey = [coder decodeObjectForKey:@"itemKey"];
    
    NSArray *items = [[BNRItemStore sharedObject] allItems];
    for (BNRItem *item in items) {
        if ([item.itemKey isEqualToString:itemKey]) {
            self.item = item;
            break;
        }
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
