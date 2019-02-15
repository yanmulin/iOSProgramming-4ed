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
    }
    return self;
}

-(BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(NSArray*)allitems {
    return self.privateItems;
}

-(void)removeItem:(BNRItem *)item {
    [self.privateItems removeObject:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;
    BNRItem *item = [self.privateItems objectAtIndex:fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
