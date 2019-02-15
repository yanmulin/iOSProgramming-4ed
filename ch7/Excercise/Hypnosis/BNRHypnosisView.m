//
//  BNRHypnosis.m
//  Hypnosis
//
//  Created by 阿文 on 2019/1/24.
//  Copyright © 2019 awen. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2;
    center.y = bounds.origin.y + bounds.size.height / 2;
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
//    for (float currentRadius=maxRadius; currentRadius > 0;currentRadius -= 20.0) { }
    for (float currentRadius=maxRadius;currentRadius>0;currentRadius-=20.0) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:2 * M_PI clockwise:YES];
    }

    path.lineWidth = 10;
    [self.circleColor setStroke];
    [path stroke];
    
    CGPoint upMiddle = CGPointMake(center.x, center.y - bounds.size.height / 4);
    CGPoint downLeft = CGPointMake(center.x - bounds.size.width / 4, center.y + bounds.size.height / 4);
    CGPoint downRight = CGPointMake(center.x + bounds.size.width / 4, center.y + bounds.size.height / 4);
    
    path = [[UIBezierPath alloc] init];
    [path moveToPoint:upMiddle];
    [path addLineToPoint:downLeft];
    [path addLineToPoint:downRight];
    [path closePath];
    
    // 获取图形上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    // 保存图形上下文
    CGContextSaveGState(currentContext);
    // 设置渐变效果
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint startPoint = upMiddle;
    CGPoint endPoint = CGPointMake(center.x, center.y + bounds.size.height / 4);
    //    [[UIColor redColor] setFill];
    [path addClip];
    [path fill];
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    
    // 恢复图形上下文
    CGContextRestoreGState(currentContext);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    // 保存图形上下文
    CGContextSaveGState(currentContext);
    // 设置阴影效果
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    // 放置图像
    CGRect imageRect = CGRectMake(
                                  center.x - bounds.size.width / 4 ,
                                  center.y - bounds.size.height / 4,
                                  bounds.size.width / 2,
                                  bounds.size.height / 2
                                  );
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    [image drawInRect:imageRect];
    // 恢复图形上下文
    CGContextRestoreGState(currentContext);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    self.circleColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
