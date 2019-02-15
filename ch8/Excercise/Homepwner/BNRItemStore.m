//
//  BNRItemStore.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/29.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import <Foundation/Foundation.h>


@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic) NSMutableArray *privateItemsGT50;
@property (nonatomic) NSMutableArray *privateItemsLET50;

@end

@implementation BNRItemStore

+(instancetype)sharedStored{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[BNRItemStore alloc] initPrivate];
    }
    return sharedStore;
}

-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemSotre sharedStore]" userInfo:nil];
    return self;
}

-(instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc] init];
        self.privateItemsLET50 = [[NSMutableArray alloc] init];
        self.privateItemsGT50 = [[NSMutableArray alloc] init];
    }
    return self;
}

-(BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    
    if (item.valueInDollars > 50) {
        [self.privateItemsGT50 addObject:item];
    } else {
        [self.privateItemsLET50 addObject:item];
    }
    
    return item;
}

-(NSArray*)allitems {
    return self.privateItems;
}

-(NSArray*)itemsGT50 {
    return self.privateItemsGT50;
}

-(NSArray*)itemsLET50 {
    return self.privateItemsLET50;
}

@end
