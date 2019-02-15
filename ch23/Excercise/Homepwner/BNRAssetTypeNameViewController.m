//
//  BNRAssetTypeNameViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRAssetTypeNameViewController.h"

@interface BNRAssetTypeNameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *assetTypeNameField;

@end

@implementation BNRAssetTypeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.doneBlock(_assetTypeNameField.text);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
