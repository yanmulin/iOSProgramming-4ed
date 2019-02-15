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

@interface BNRAssetTypesViewController ()

@end

@implementation BNRAssetTypesViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"Asset Type", @"BNRAssetTypesViewController title");
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedObject] allAssetTypes] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *assetTypes = [[BNRItemStore sharedObject] allAssetTypes];
    cell.textLabel.text = [assetTypes[indexPath.row] valueForKey:@"labelString"];
    
    if (assetTypes[indexPath.row] == self.item.assetType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
