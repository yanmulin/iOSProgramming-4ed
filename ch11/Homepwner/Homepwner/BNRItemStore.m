//
//  BNRItemStore.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedObject {
    static BNRItemStore *sharedObject = nil;
    if (!sharedObject) {
        sharedObject = [[BNRItemStore alloc] initPrivate];
    }
    return sharedObject;
}

-(instancetype)initPrivate {
    self = [super init];
    self.privateItems = [[NSMutableArray alloc] init];
    return self;
}

-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRitemStore sharedObject]" userInfo:nil];
    return self;
}

-(BNRItem *)createItem {
    BNRItem *newItem = [BNRItem randomItem];
    [self.privateItems addObject:newItem];
    return newItem;
}

-(void)removeItem:(BNRItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
    [[BNRImageStore sharedObject] deleteImageForKey:item.itemKey];
}

-(NSArray *)allItems {
    return self.privateItems;
}

-(void)moveItemFrom:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    NSMutableArray *items = self.privateItems;
    BNRItem *item = [items objectAtIndex:fromIndex];
    [items removeObjectAtIndex:fromIndex];
    [items insertObject:item atIndex:toIndex];
}

@end
