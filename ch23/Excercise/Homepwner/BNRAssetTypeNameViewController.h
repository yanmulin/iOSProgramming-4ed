//
//  BNRAssetTypeNameViewController.h
//  Homepwner
//
//  Created by 颜木林 on 2019/2/13.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRAssetTypeNameViewController : UIViewController

@property (nonatomic, copy) void (^doneBlock)(NSString *assetTypeName);

@end

NS_ASSUME_NONNULL_END
