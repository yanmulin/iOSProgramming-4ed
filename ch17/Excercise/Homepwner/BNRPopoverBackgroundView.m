//
//  BNRPopoverBackgroundView.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/9.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRPopoverBackgroundView.h"


@implementation BNRPopoverBackgroundView

@synthesize arrowOffset = _arrowOffset;
@synthesize arrowDirection = _arrowDirection;

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.arrowOffset = 0;
        self.arrowDirection = UIPopoverArrowDirectionAny;
    }
    return self;
}

+ (CGFloat)arrowBase
{
    return 0;
}

+ (CGFloat)arrowHeight
{
    return 0;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
}

@end
