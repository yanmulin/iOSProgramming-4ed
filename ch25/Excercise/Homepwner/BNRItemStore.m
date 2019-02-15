//
//  BNRItemStore.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem+CoreDataClass.h"
#import "BNRAssetType+CoreDataClass.h"

@interface BNRItemStore () {
    NSMutableArray *_allAssetTypes;
}

@property (nonatomic) NSMutableArray *privateItems;

@property (nonatomic) NSManagedObjectModel *model;
@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation BNRItemStore

+(instancetype)sharedObject {
    static BNRItemStore *sharedObject = nil;
//    if (!sharedObject) {
//        sharedObject = [[BNRItemStore alloc] initPrivate];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[BNRItemStore alloc] initPrivate];
    });
    return sharedObject;
}

-(instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        NSString *path = [BNRItemStore archivePath];
        NSURL *storeUrl = [NSURL fileURLWithPath:path];
        NSError *error;
        [psc addPersistentStoreWithType:NSSQLiteStoreType
                          configuration:nil
                                    URL:storeUrl
                                options:nil
                                  error:&error];
        if (error) {
            @throw [NSException exceptionWithName:@"Open failed"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    
    return self;
}

-(void)loadAllItems {
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Item"
                                             inManagedObjectContext:self.context];
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request
                                                 error:&error];
        if (error) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

-(NSArray *)allAssetTypes {
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"AssetType"
                                             inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request
                                                      error:&error];
        if (error) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        _allAssetTypes = [[NSMutableArray alloc] initWithArray:result];
    }
    
    if ([_allAssetTypes count] == 0) {
        BNRAssetType *assetType = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                                                inManagedObjectContext:self.context];
        assetType.labelString = @"Furniture";
        [_allAssetTypes addObject:assetType];
        
        assetType = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                                  inManagedObjectContext:self.context];
        assetType.labelString = @"Jewelry";
        [_allAssetTypes addObject:assetType];
        
        assetType = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType"
                                                  inManagedObjectContext:self.context];
        assetType.labelString = @"Electronics";
        [_allAssetTypes addObject:assetType];
    }
    return _allAssetTypes;
}

-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRitemStore sharedObject]" userInfo:nil];
    return self;
}

-(BNRItem *)createItem {
//    BNRItem *newItem = [BNRItem randomItem];
//    [self.privateItems addObject:newItem];
//    return newItem;
    
    double order;
    
    if ([self.privateItems count] == 0) {
        order = 1.0;
    } else  {
        order = [[self.privateItems lastObject] orderingValue] + 1.0;
    }
    
    BNRItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.context];
    item.orderingValue = order;
    
    [self.privateItems addObject:item];
    
    return item;
}

-(void)removeItem:(BNRItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
    [[BNRImageStore sharedObject] deleteImageForKey:item.itemKey];
    [self.context deleteObject:item];
}

-(NSArray *)allItems {
    return self.privateItems;
}

-(void)moveItemFrom:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    NSMutableArray *items = self.privateItems;
    BNRItem *item = [items objectAtIndex:fromIndex];
    [items removeObjectAtIndex:fromIndex];
    [items insertObject:item atIndex:toIndex];
    
    double lowerbound = 0.0;
    
    if (toIndex == 0) {
        lowerbound = [items[1] orderingValue] - 2.0;
    } else {
        lowerbound = [items[toIndex-1] orderingValue];
    }
    
    double upperbound = 0.0;
    
    if (toIndex == [items count] - 1) {
        upperbound = [items[toIndex] orderingValue] + 2.0;
    } else {
        upperbound = [items[toIndex + 1] orderingValue];
    }
    
    double newOrderingValue = (lowerbound + upperbound) / 2.0;
    
    item.orderingValue = newOrderingValue;
}

+(NSString *)archivePath {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *ducumentPath = [documentPaths firstObject];
    return [ducumentPath stringByAppendingPathComponent:@"data.store"];
}

-(void)saveChanges {
//    NSString *savePath = [BNRItemStore archivePath];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_privateItems requiringSecureCoding:NO error:nil];
//    [data writeToFile:savePath atomically:YES];
    
    NSError *error;
    [self.context save: &error];
    
    if (error) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    } else {
        NSLog(@"Save changes");
    }
}

@end
