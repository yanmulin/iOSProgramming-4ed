//
//  BNRItem+CoreDataProperties.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRItem+CoreDataProperties.h"

@implementation BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Item"];
}

@dynamic dateCreated;
@dynamic itemKey;
@dynamic itemName;
@dynamic orderingValue;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic thumbnail;
@dynamic assetType;

@end
