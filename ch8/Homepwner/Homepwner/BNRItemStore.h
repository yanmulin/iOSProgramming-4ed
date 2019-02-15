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

+(instancetype)sharedStored;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex
               toIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
