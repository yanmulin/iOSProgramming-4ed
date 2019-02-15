//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by 颜木林 on 2019/2/14.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRColorDescription;

NS_ASSUME_NONNULL_BEGIN

@interface BNRColorViewController : UIViewController

@property (nonatomic, strong) BNRColorDescription *colorDescription;
@property (nonatomic) BOOL isExistingColor;

@end

NS_ASSUME_NONNULL_END
