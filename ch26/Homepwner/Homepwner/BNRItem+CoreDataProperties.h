//
//  BNRItem+CoreDataProperties.h
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRItem+CoreDataClass.h"
@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nullable, nonatomic, copy) NSString *itemKey;
@property (nullable, nonatomic, copy) NSString *itemName;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, copy) NSString *serialNumber;
@property (nonatomic) NSInteger valueInDollars;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nullable, nonatomic, retain) BNRAssetType *assetType;

@end

NS_ASSUME_NONNULL_END
