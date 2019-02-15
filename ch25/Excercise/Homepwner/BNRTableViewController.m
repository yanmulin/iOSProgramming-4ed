//
//  BNRTableViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRTableViewController.h"
#import "BNRItemStore.h"
#import "BNRDetailController.h"
#import "BNRItemCell.h"
//#import "BNRItem.h"
#import "BNRItem+CoreDataClass.h"
#import "BNRImageStore.h"
#import "BNRImageViewController.h"

@interface BNRTableViewController ()

@end

@implementation BNRTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
//        BNRItemStore *itemStore = [BNRItemStore sharedObject];
//        for (int i=0;i<5;i++) {
//            [itemStore createItem];
//        }
        
        self.restorationIdentifier = NSStringFromClass([BNRTableViewController class]);
        self.restorationClass = [self class];
        self.tableView.restorationIdentifier = @"BNRTableViewControllerTableView";
        
        UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCell"];
//        [self.tableView registerClass: [BNRItemCell class] forCellReuseIdentifier:@"BNRItemCell"];
        self.navigationItem.title = NSLocalizedString(@"Homepwner", @"Name of application");
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateTableViewForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
        [nc addObserver:self selector:@selector(localeChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedObject] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    BNRItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BNRItemCell"
                                                             forIndexPath:indexPath];
    
    BNRItem *item = [[BNRItemStore sharedObject] allItems][indexPath.row];
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    
    static NSNumberFormatter *currencyFormatter;
    if (!currencyFormatter) {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    cell.valueLabel.text = [currencyFormatter stringFromNumber:@(item.valueInDollars)];
    
//    cell.valueLabel.text =  [NSString stringWithFormat:@"$%d", item.valueInDollars ];
    cell.thumbnailView.image = item.thumbnail;
    __weak BNRItemCell *weakCell = cell;
    cell.actionBlock = ^{
        BNRItemCell *strongCell = weakCell;
        NSLog(@"Going to show image for %@item", item);
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIImage *image = [[BNRImageStore sharedObject] ImageForKey:item.itemKey];
            
            BNRImageViewController *ivc = [[BNRImageViewController alloc] init];
            
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds toView:self.view];
            ivc.modalPresentationStyle = UIModalPresentationPopover;
            ivc.popoverPresentationController.sourceRect = rect;
            ivc.popoverPresentationController.sourceView = self.view;
            ivc.image = image;
            
            [self presentViewController:ivc animated:YES completion:nil];
        }
    };
    return cell;
}

-(void)addNewItem:(id)sender {
    BNRItemStore *itemStore = [BNRItemStore sharedObject];
    BNRItem *item = [itemStore createItem];
    
    BNRDetailController *detailController = [[BNRDetailController alloc] initForNewItem:YES];
    detailController.item = item;
    detailController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
    
//    NSUInteger row = [[itemStore allItems] indexOfObject:item];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSLog(@"Delete %@", indexPath);
        NSArray *items = [[BNRItemStore sharedObject] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedObject] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedObject] moveItemFrom:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailController *detailController = [[BNRDetailController alloc] initForNewItem:NO];
    NSArray *items = [[BNRItemStore sharedObject] allItems];
    BNRItem *item = items[indexPath.row];
    detailController.item = item;
    [self.navigationController pushViewController:detailController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData];
    [self updateTableViewForDynamicTypeSize];
}

-(void)updateTableViewForDynamicTypeSize {
    static NSDictionary *cellHeightDictionary;
    
    if (!cellHeightDictionary) {
        cellHeightDictionary = @{
                                 UIContentSizeCategoryExtraSmall:@44,
                                 UIContentSizeCategorySmall:@44,
                                 UIContentSizeCategoryMedium:@44,
                                 UIContentSizeCategoryLarge:@44,
                                 UIContentSizeCategoryExtraLarge:@55,
                                 UIContentSizeCategoryExtraExtraLarge:@55,
                                 UIContentSizeCategoryExtraExtraExtraLarge:@75,
                                 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *cellHeight = cellHeightDictionary[userSize];
    [self.tableView setRowHeight:cellHeight.floatValue];
    [self.tableView reloadData];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    return [[BNRTableViewController alloc] init];
}

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.isEditing forKey:@"TableViewIsEditing"];
    
    [super encodeRestorableStateWithCoder:coder];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    self.editing = [coder decodeBoolForKey:@"TableViewIsEditing"];
    
    [super decodeRestorableStateWithCoder:coder];
}

-(NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view {
    NSString *identifier;
    
    if (idx && view) {
        BNRItem *item = [[BNRItemStore sharedObject] allItems][idx.row];
        identifier = item.itemKey;
    }
    
    return identifier;
}

-(NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    NSIndexPath *indexPath = nil;
    if (identifier && view) {
        NSArray *items = [[BNRItemStore sharedObject] allItems];
        for (BNRItem *item in items) {
            if ([item.itemKey isEqualToString: identifier]) {
                NSUInteger row = [items indexOfObject:item];
                indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                break;
            }
        }
    }
    return indexPath;
}

-(void)localeChange:(id)sender {
    [self.tableView reloadData];
}

@end
