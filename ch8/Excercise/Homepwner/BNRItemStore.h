//
//  BNRItemStore.h
//  Homepwner
//
//  Created by 颜木林 on 2019/1/29.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allitems;
@property (nonatomic, readonly) NSArray *itemsGT50;
@property (nonatomic, readonly) NSArray *itemsLET50;

+(instancetype)sharedStored;
-(BNRItem *)createItem;


@end

NS_ASSUME_NONNULL_END
