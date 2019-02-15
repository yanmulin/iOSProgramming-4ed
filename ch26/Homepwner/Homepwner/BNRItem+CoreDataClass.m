//
//  BNRItem+CoreDataClass.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//
//

#import "BNRItem+CoreDataClass.h"

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

@end
