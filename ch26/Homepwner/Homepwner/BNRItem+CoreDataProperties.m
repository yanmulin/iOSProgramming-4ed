//
//  BNRItem+CoreDataProperties.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRItem+CoreDataProperties.h"
#import <UIKit/UIKit.h>

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

-(void)setThumbnailFromImage:(UIImage *)image {
    CGSize origImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    UIGraphicsEndImageContext();
}

@end
