//
//  BNRPaletteViewControllerTableViewController.m
//  Colorboard
//
//  Created by 颜木林 on 2019/2/14.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRPaletteViewController.h"
#import "BNRColorDescription.h"
#import "BNRColorViewController.h"

@interface BNRPaletteViewController ()

@property (nonatomic, strong) NSMutableArray *privateColors;

@end

@implementation BNRPaletteViewController

-(NSArray *)colors {
    if (!self.privateColors) {
        self.privateColors = [[NSMutableArray alloc] init];
    }
    return [self.privateColors copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self.tableView registerClass:UITableViewCell.class
//           forCellReuseIdentifier:@"UITableViewCell"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.colors count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *colors = self.colors;
    BNRColorDescription *colorDescription = colors[indexPath.row];
    cell.textLabel.text = colorDescription.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        UINavigationController *nc = (UINavigationController*) segue.destinationViewController;
        BNRColorViewController *cvc = (BNRColorViewController*)nc.topViewController;
        BNRColorDescription *newColor = [[BNRColorDescription alloc] init];
        cvc.colorDescription = newColor;
        [self.privateColors addObject:newColor];
    } else {

        BNRColorViewController *cvc = (BNRColorViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        BNRColorDescription *color = self.colors[indexPath.row];
        cvc.colorDescription = color;
        cvc.isExistingColor = YES;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
