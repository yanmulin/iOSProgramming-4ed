//
//  AssetType+CoreDataProperties.h
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRAssetType+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BNRAssetType (CoreDataProperties)

+ (NSFetchRequest<BNRAssetType *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *labelString;
@property (nullable, nonatomic, retain) NSSet<BNRItem *> *items;

@end

@interface BNRAssetType (CoreDataGeneratedAccessors)

- (void)addItemsObject:(BNRItem *)value;
- (void)removeItemsObject:(BNRItem *)value;
- (void)addItems:(NSSet<BNRItem *> *)values;
- (void)removeItems:(NSSet<BNRItem *> *)values;

@end

NS_ASSUME_NONNULL_END
