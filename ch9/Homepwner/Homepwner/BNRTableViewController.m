//
//  BNRTableViewController.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/29.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRTableViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRTableViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        for (int i=0;i<5;i++)
            [[BNRItemStore sharedStored] createItem];
    }
    return self;
}

-(instancetype)init {
    self = [self initWithStyle:UITableViewStylePlain];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView setTableHeaderView:self.headerView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStored] allitems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStored] allitems];
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}

-(UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

-(IBAction)toggleEditingMode:(id)sender {
//    NSLog(@"toggleEditingMode");
    if (self.isEditing) {
        [self setEditing:NO animated:YES];
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    } else {
        [self setEditing:YES animated:YES];
        [sender setTitle:@"Done" forState:UIControlStateNormal];
    }
}

-(IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStored] createItem];
    NSInteger newRow = [[[BNRItemStore sharedStored] allitems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStored] allitems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStored] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStored] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

@end
