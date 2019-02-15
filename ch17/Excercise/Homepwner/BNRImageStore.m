//
//  BNRImageStore.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic) NSMutableDictionary *allImages;

@end

@implementation BNRImageStore

+(instancetype)sharedObject {
    static BNRImageStore *sharedObject = nil;
//    if (!sharedObject) {
//        sharedObject = [[BNRImageStore alloc] initPrivate];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[BNRImageStore alloc] initPrivate];
    });
    return sharedObject;
}

-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedObject]" userInfo:nil];
    return self;
}

-(instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.allImages = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage *)image ForKey:(NSString *)key {
    [self.allImages setObject:image forKey:key];
}

-(UIImage *)ImageForKey:(NSString *)key {
    UIImage *image = [self.allImages objectForKey:key];
    return image;
}

-(void)deleteImageForKey:(NSString *)key {
    [self.allImages removeObjectForKey:key];
}

@end
