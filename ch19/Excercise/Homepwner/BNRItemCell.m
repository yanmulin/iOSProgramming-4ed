//
//  BNRItemCell.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/9.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
