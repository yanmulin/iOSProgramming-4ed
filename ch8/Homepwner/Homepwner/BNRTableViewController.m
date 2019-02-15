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

@end
