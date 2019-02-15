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

-(void)colorChanged:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.circleColor = [UIColor redColor];
            break;
        case 1:
            self.circleColor = [UIColor greenColor];
            break;
        case 2:
            self.circleColor = [UIColor blueColor];
            break;
    }
}

@end
