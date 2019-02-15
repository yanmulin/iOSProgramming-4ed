//
//  BNRItemStore.h
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedObject;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemFrom:(NSUInteger)fromIndex
            toIndex:(NSUInteger)toIndex;

-(void)saveChanges;

@end

NS_ASSUME_NONNULL_END
