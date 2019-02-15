//
//  BNRPopoverBackgroundView.h
//  Homepwner
//
//  Created by 颜木林 on 2019/2/9.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRPopoverBackgroundView : UIPopoverBackgroundView <UIPopoverBackgroundViewMethods>

@property (nonatomic, readwrite) CGFloat arrowOffset;
@property(nonatomic, readwrite) UIPopoverArrowDirection arrowDirection;

@end

NS_ASSUME_NONNULL_END
