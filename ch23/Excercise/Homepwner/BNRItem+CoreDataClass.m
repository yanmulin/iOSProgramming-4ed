//
//  BNRItem+CoreDataClass.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRItem+CoreDataClass.h"
#import <UIKit/UIKit.h>

@implementation BNRItem

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    self.itemKey = uuidString;
    
    static NSArray *randomAdjectiveList;
    
    if (!randomAdjectiveList)
        randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    static NSArray *randomNounList;
    
    if (!randomNounList)
        randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    self.itemName = randomName;
    self.serialNumber = randomSerialNumber;
    self.valueInDollars = randomValue;
    
}

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
