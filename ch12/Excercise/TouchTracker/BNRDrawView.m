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
@property (nonatomic) NSMutableDictionary *circlesInProgress;
@property (nonatomic) NSMutableArray *finishedLines;
@property (nonatomic) NSMutableArray *finishedCircles;
@property (nonatomic) BOOL isCircle;

@end

@implementation BNRDrawView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedCircles = [[NSMutableArray alloc] init];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
//    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [line.color set];
        [self drawLine:line];
    }
    [[UIColor redColor] set];
    for (BNRLine *line in [self.linesInProgress allValues])
        [self drawLine:line];
    
    [[UIColor blackColor] set];
    for (NSArray *circlePoints in self.finishedCircles) {
        [self drawCircle:circlePoints];
    }
    
    [[UIColor redColor] set];
    if (self.circlesInProgress) {
        NSArray *circlePoints = [self.circlesInProgress allValues];
        [self drawCircle:circlePoints];
    }
    
        
}

-(void)drawLine:(BNRLine*)line {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:line.begin];
    [path addLineToPoint:line.end];
    [path stroke];
}
    
-(void)drawCircle:(NSArray*)circlePoints {
    assert(circlePoints.count == 2);
    BNRLine *line1 = circlePoints[0];
    BNRLine *line2 = circlePoints[1];
    CGPoint p1 = line1.end;
    CGPoint p2 = line2.end;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineCapStyle = kCGLineCapRound;
    
    CGPoint center = CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
    float deltaX = p2.x - center.x;
    float deltaY = p2.y - center.y;
    float radius = sqrtf(deltaX * deltaX + deltaY * deltaY);
    
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:2 * M_PI clockwise:YES];
    [path stroke];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 高级练习
    if (touches.count == 2) {
        self.isCircle = YES;
        NSArray *alltouches = [touches allObjects];
        CGPoint loc1 = [alltouches[0] locationInView:self];
        CGPoint loc2 = [alltouches[1] locationInView:self];
        
        BNRLine *line1 = [[BNRLine alloc] init];
        line1.begin = loc1;
        line1.end = loc1;
        BNRLine *line2 = [[BNRLine alloc] init];
        line2.begin = loc2;
        line2.end = loc2;
        
        self.circlesInProgress = [[NSMutableDictionary alloc] init];
        NSValue *key = [NSValue valueWithNonretainedObject:alltouches[0]];
        self.circlesInProgress[key] = line1;
        key = [NSValue valueWithNonretainedObject:alltouches[1]];
        self.circlesInProgress[key] = line2;
        
    }else {
//        self.isCircle = NO;
        for (UITouch *t in touches) {
            CGPoint location = [t locationInView:self];
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            self.linesInProgress[key] = line;
        }
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 2 && self.isCircle == YES) {
        NSArray *alltouches = [touches allObjects];
        CGPoint loc1 = [alltouches[0] locationInView:self];
        CGPoint loc2 = [alltouches[1] locationInView:self];
        
        BNRLine *line;
        NSValue *key = [NSValue valueWithNonretainedObject:alltouches[0]];
        line = self.circlesInProgress[key];
        line.end = loc1;
        key = [NSValue valueWithNonretainedObject:alltouches[1]];
        line = self.circlesInProgress[key];
        line.end = loc2;
        
    } else {
        if (self.isCircle == YES) {
            [self.linesInProgress addEntriesFromDictionary:self.circlesInProgress];
        }
        for (UITouch *t in touches) {
            CGPoint location = [t locationInView:self];
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            BNRLine *line = self.linesInProgress[key];
            line.end = location;
        }
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.count == 2 && self.isCircle == YES) {
        NSArray *alltouches = [touches allObjects];

        NSValue *key = [NSValue valueWithNonretainedObject:alltouches[0]];
        BNRLine *line1 = self.circlesInProgress[key];
        key = [NSValue valueWithNonretainedObject:alltouches[1]];
        BNRLine *line2 = self.circlesInProgress[key];
        [self.finishedCircles addObject:@[line1, line2]];
        [self.circlesInProgress removeAllObjects];
        self.circlesInProgress = nil;
        
    } else {
        if (self.isCircle == YES) {
            [self.linesInProgress addEntriesFromDictionary:self.circlesInProgress];
        }
        for (UITouch *t in touches) {
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            BNRLine *line = self.linesInProgress[key];
            [self.finishedLines addObject:line];
            [self.linesInProgress removeObjectForKey:key];
            
            // 中级练习
            float deltaX = line.end.x - line.begin.x;
            float deltaY = line.end.y - line.begin.y;
            float angle = atan2f(deltaY, deltaX);
            NSLog(@"%f", angle * 180 / M_PI);
            if (angle < -1 * M_PI / 3) {
                line.color = [UIColor blueColor];
            } else if (angle < M_PI / 3) {
                line.color = [UIColor greenColor];
            } else {
                line.color = [UIColor yellowColor];
            }
        }
    }
    
    self.isCircle = NO;

    [self setNeedsDisplay];
}

// 初级练习
-(void)saveLines {
    NSMutableArray *lineToSave = [[NSMutableArray alloc] init];
    for (BNRLine *line in self.finishedLines) {
        [lineToSave addObject:[NSNumber numberWithFloat:line.begin.x]];
        [lineToSave addObject:[NSNumber numberWithFloat:line.begin.y]];
        [lineToSave addObject:[NSNumber numberWithFloat:line.end.x]];
        [lineToSave addObject:[NSNumber numberWithFloat:line.end.y]];
    }
    [lineToSave writeToFile:@"./" atomically:YES];
    NSLog(@"save %lu lines in file", lineToSave.count);
}

-(void)loadLines {
    NSMutableArray *lineLoaded = [[NSMutableArray alloc] initWithContentsOfFile:@"./"];
    if (lineLoaded.count < 4) {
        NSLog(@"load %lu entries in file", lineLoaded.count);
        return;
    }
    for (int i =0;i<lineLoaded.count;i+=4) {
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = CGPointMake([lineLoaded[i] floatValue], [lineLoaded[i+1] floatValue]);
        line.end = CGPointMake([lineLoaded[i+2] floatValue], [lineLoaded[i+3] floatValue]);
    }
    NSLog(@"load %lu lines in file", lineLoaded.count);
}

@end
