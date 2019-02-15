//
//  BNRAssetTypesViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRAssetTypesViewController.h"
#import "BNRItemStore.h"
#import "BNRItem+CoreDataClass.h"
#import "BNRAssetTypeNameViewController.h"
#import "BNRAssetType+CoreDataClass.h"

@interface BNRAssetTypesViewController ()

@end

@implementation BNRAssetTypesViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        UIBarButtonItem *addAssetTypeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self action:@selector(addAssetType:)];
        self.navigationItem.rightBarButtonItem = addAssetTypeButton;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return [[[BNRItemStore sharedObject] allAssetTypes] count];
    else
        return [[[self.item assetType] items] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Asset Types";
    } else {
        return @"related items";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        NSArray *assetTypes = [[BNRItemStore sharedObject] allAssetTypes];
        cell.textLabel.text = [assetTypes[indexPath.row] valueForKey:@"labelString"];
        
        if (assetTypes[indexPath.row] == self.item.assetType) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        NSArray *items = [[[self.item assetType] items] allObjects];
        cell.textLabel.text = [items[indexPath.row] itemName];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *assetTypes = [[BNRItemStore sharedObject] allAssetTypes];
        BNRAssetType *assetType = assetTypes[indexPath.row];
        self.item.assetType = assetType;
        
        for (int i=0;i<[tableView numberOfRowsInSection:indexPath.section];i++) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:idxPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:self.updateAssetTypeBlock];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)addAssetType:(id)sender {
    BNRAssetTypeNameViewController *avc = [[BNRAssetTypeNameViewController alloc] init];
    avc.doneBlock = ^(NSString *assetTypeName) {
        NSUInteger row = [[[BNRItemStore sharedObject] allAssetTypes] count];
        [[BNRItemStore sharedObject] addAssetType:assetTypeName];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    };
    avc.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:avc animated:YES completion:nil];
}

@end
