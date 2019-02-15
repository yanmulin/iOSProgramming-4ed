//
//  BNRItemCell.h
//  Homepwner
//
//  Created by 颜木林 on 2019/2/9.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, copy) void(^actionBlock)(void);

@end

NS_ASSUME_NONNULL_END
