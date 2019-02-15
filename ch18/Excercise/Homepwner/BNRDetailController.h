//
//  BNRDetailController.h
//  Homepwner
//
//  Created by 颜木林 on 2019/1/31.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNRDetailController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic) BNRItem *item;
@property (nonatomic, copy) void(^dismissBlock)(void);

-(instancetype)initForNewItem:(BOOL)isNew;

@end

NS_ASSUME_NONNULL_END
