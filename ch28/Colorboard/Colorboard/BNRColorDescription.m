//
//  BNRColorDescription.m
//  Colorboard
//
//  Created by 颜木林 on 2019/2/14.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRColorDescription.h"
#import <UIKit/UIKit.h>

@implementation BNRColorDescription

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.color = [UIColor colorWithRed:0
                                green:0
                                 blue:1
                                alpha:1.0];
        self.name = @"Blue";
    }
    
    return self;
}

@end
