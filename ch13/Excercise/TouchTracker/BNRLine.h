//
//  BNRLine.h
//  TouchTracker
//
//  Created by 颜木林 on 2019/2/1.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRLine : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) NSDate *beignDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) float lineWidth;

@end

NS_ASSUME_NONNULL_END
