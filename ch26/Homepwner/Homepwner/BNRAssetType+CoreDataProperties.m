//
//  AssetType+CoreDataProperties.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRAssetType+CoreDataProperties.h"

@implementation BNRAssetType (CoreDataProperties)

+ (NSFetchRequest<BNRAssetType *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AssetType"];
}

@dynamic labelString;
@dynamic items;

@end
