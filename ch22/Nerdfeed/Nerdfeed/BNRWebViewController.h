//
//  BNRWebViewController.h
//  Nerdfeed
//
//  Created by 颜木林 on 2019/2/10.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRWebViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic) NSURL *url;

@end

NS_ASSUME_NONNULL_END
