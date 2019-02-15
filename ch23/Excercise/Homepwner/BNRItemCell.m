//
//  BNRItemCell.m
//  Homepwner
//
//  Created by 颜木林 on 2019/2/9.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thumbnailHeightConstraint;

@end

@implementation BNRItemCell

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

-(void)awakeFromNib {
    [super awakeFromNib];
        [self updateFont];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateFont) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    [self.thumbnailView addConstraint: constraint];
    
}

-(void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(void)updateFont {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                 UIContentSizeCategoryExtraSmall:@40,
                                 UIContentSizeCategorySmall:@40,
                                 UIContentSizeCategoryMedium:@40,
                                 UIContentSizeCategoryLarge:@40,
                                 UIContentSizeCategoryExtraLarge:@45,
                                 UIContentSizeCategoryExtraExtraLarge:@55,
                                 UIContentSizeCategoryExtraExtraExtraLarge:@65,
                                 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.thumbnailHeightConstraint.constant = imageSize.floatValue;
    
}
@end
