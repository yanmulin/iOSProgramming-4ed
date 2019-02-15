//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by 颜木林 on 2019/2/1.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) NSMutableArray *finishedLines;

@end

@implementation BNRDrawView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines)
        [self drawLine:line];
    [[UIColor redColor] set];
    for (BNRLine *line in [self.linesInProgress allValues])
        [self drawLine:line];
}

-(void)drawLine:(BNRLine*)line {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = location;
    }

    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}



@end
