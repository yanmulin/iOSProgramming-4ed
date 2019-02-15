//
//  BNRImageStore.h
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject

+(instancetype)sharedObject;

-(void)setImage:(UIImage *)image ForKey:(NSString *)key;
-(UIImage *)ImageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
