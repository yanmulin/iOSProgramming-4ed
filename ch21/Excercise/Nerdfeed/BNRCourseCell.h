//
//  BNRCourseCell.h
//  Nerdfeed
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRCourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
