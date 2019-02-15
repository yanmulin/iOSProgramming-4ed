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

-(void)loadView {
    [super loadView];

    UIImage *backgroundImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundView.frame = [[UIScreen mainScreen] bounds];
    self.tableView.backgroundView = backgroundView;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return [[[BNRItemStore sharedStored] itemsGT50] count];
    else if (section == 1)
        return [[[BNRItemStore sharedStored] itemsLET50] count];
    else return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items;
    if (indexPath.section == 0) {
        items = [[BNRItemStore sharedStored] itemsGT50];
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    } else if (indexPath.section == 1){
        items = [[BNRItemStore sharedStored] itemsLET50];
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    } else cell.textLabel.text = @"no more items!";
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 60;
    } else return 44;
}

@end
