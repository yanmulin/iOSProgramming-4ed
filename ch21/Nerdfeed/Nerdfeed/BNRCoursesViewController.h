//
//  BNRCoursesViewController.h
//  Nerdfeed
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRWebViewController;

NS_ASSUME_NONNULL_BEGIN

@interface BNRCoursesViewController : UITableViewController <NSURLSessionDelegate>

@property (nonatomic, strong) BNRWebViewController *webViewController;

@end

NS_ASSUME_NONNULL_END
