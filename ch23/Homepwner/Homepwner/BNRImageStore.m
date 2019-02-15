//
//  BNRImageStore.m
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRImageStore.h"
#import <UIKit/UIKit.h>

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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)setImage:(UIImage *)image ForKey:(NSString *)key {
    [self.allImages setObject:image forKey:key];
    
    NSString *path = [BNRImageStore imagePathForKey:key];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [imageData writeToFile:path atomically:YES];
    
}

-(UIImage *)ImageForKey:(NSString *)key {
    UIImage *image = [self.allImages objectForKey:key];
    if (!image) {
        NSString *path = [BNRImageStore imagePathForKey:key];
        image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [self.allImages setObject:image forKey:key];
        } else {
            NSLog(@"unable to find %@", path);
        }
    }
    return image;
}

-(void)deleteImageForKey:(NSString *)key {
    [self.allImages removeObjectForKey:key];
    
    NSString *imagePath = [BNRImageStore imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

+(NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

-(void)clearCache:(NSNotification *)note {
    NSLog(@"flushing %lu images out of cache", [self.allImages count]);
    [self.allImages removeAllObjects];
}

@end
