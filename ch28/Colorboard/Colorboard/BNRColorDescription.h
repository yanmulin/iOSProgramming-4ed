//
//  BNRColorDescription.h
//  Colorboard
//
//  Created by 颜木林 on 2019/2/14.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

NS_ASSUME_NONNULL_BEGIN

@interface BNRColorDescription : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
