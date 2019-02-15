//
//  BNRItem.h
//  RandomItems
//
//  Created by John Gallagher on 1/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRItem : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSString *itemKey;
@property(class, readonly) BOOL supportsSecureCoding;
@property (nonatomic, strong) UIImage *thumbnail;

+ (instancetype)randomItem;

// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

-(void)setThumbnail:(UIImage *)image;

@end
