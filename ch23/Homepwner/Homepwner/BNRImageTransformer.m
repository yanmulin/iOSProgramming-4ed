//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/12.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation BNRImageTransformer

+(Class)transformedValueClass {
    return [NSData class];
}

-(id)transformedValue:(id)value {
    if (!value) return nil;
    if ([value isKindOfClass:[NSData class]])
        return value;
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}

@end
