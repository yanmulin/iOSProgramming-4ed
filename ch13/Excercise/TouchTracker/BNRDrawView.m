//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by 颜木林 on 2019/2/1.
//  Copyright © 2019 yanmulin. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () {
    NSDate *date;
}

@property (nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) NSMutableArray *finishedLines;
@property (nonatomic) BNRLine *selectedLine;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic) IBOutlet UIView *colorPadView;
@property (nonatomic) UIColor *selectedColor;

@end

@implementation BNRDrawView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.numberOfTapsRequired = 1;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressRecognizer];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        panRecognizer.delegate = self;
        panRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panRecognizer];
        self.panGestureRecognizer = panRecognizer;
        
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(showColorPad:)];
        // 在模拟器上无法模拟三指扫动的手势
        swipeRecognizer.numberOfTouchesRequired = 2;
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        swipeRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:swipeRecognizer];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [self.selectedColor set];
    for (BNRLine *line in self.finishedLines)
        [self drawLine:line];
    [[UIColor redColor] set];
    for (BNRLine *line in [self.linesInProgress allValues])
        [self drawLine:line];
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self drawLine:self.selectedLine];
    }
    
    for (int i=0;i<1000000;i++) {
        sin(sin(sin(sin(time(NULL) + 1.0))));
    }
}

-(void)drawLine:(BNRLine*)line {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = line.lineWidth;
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
        line.beignDate = [NSDate date];
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
        float timeInterval = [[NSDate date] timeIntervalSinceDate:line.beignDate];
        line.lineWidth = sqrtf(timeInterval) + 5;
        line.end = location;
    }

    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        float timeInterval = [[NSDate date] timeIntervalSinceDate:line.beignDate];
        line.lineWidth = sqrtf(timeInterval) + 5;
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void)doubleTap:(UITapGestureRecognizer *)gr {
    NSLog(@"Double tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    if (self.selectedLine) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

-(void)tap:(UITapGestureRecognizer *)gr {
    NSLog(@"Tap");
    
    CGPoint tapPoint = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:tapPoint];
    
    if (self.selectedLine) {
        [self becomeFirstResponder];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(tapPoint.x, tapPoint.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];

    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

-(BNRLine*)lineAtPoint:(CGPoint)p {
    for (BNRLine *line in self.finishedLines) {
        CGPoint lineMidPoint = CGPointMake((line.begin.x + line.end.x) / 2, (line.begin.y + line.end.y) / 2);
        float distanceP2Mid = hypotf(p.x - lineMidPoint.x, p.y - lineMidPoint.y);
        float lineLen = hypotf(line.begin.x - line.end.x, line.begin.y - line.end.y);
        if (distanceP2Mid > lineLen / 2 + 20) continue;
        float k = (line.end.y - line.begin.y) / (line.end.x - line.begin.x);
        float b = line.begin.y - k * line.begin.x;
        float distance = ABS(k * p.x - p.y + b) / hypotf(k, 1);
        if (distance < 20)
            return line;
    }
    return nil;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)deleteLine:(id)sender {
    assert(self.selectedLine);
    [self.finishedLines removeObject:self.selectedLine];
    self.selectedLine = nil;
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [self setNeedsDisplay];
}

-(void)longPress:(UILongPressGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:tapPoint];
        if (self.selectedLine)
            [self.linesInProgress removeAllObjects];
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer)
        return YES;
    else return NO;
}

-(void)moveLine:(UIPanGestureRecognizer*)gr {
//    NSLog(@"Move line");
    if (!self.selectedLine) {
        static NSDate *date;
        if (gr.state == UIGestureRecognizerStateBegan) {
            date = [NSDate date];
        } else if (gr.state == UIGestureRecognizerStateEnded) {
            NSLog(@"%f", [[NSDate date] timeIntervalSinceDate:date]);
        }
    }else {
        if (gr.state == UIGestureRecognizerStateBegan) {
            CGPoint tapPoint = [gr locationInView:self];
            BNRLine *tapLine = [self lineAtPoint:tapPoint];
            if (self.selectedLine != tapLine) {
                self.selectedLine = nil;
                [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
            }
        } else if (gr.state == UIGestureRecognizerStateChanged) {
            NSLog(@"UIPanGestureRecognizer state changed");
            CGPoint translation = [gr translationInView:self];
            CGPoint begin = self.selectedLine.begin;
            CGPoint end = self.selectedLine.end;
            begin.x += translation.x;
            begin.y += translation.y;
            end.x += translation.x;
            end.y += translation.y;
            self.selectedLine.begin = begin;
            self.selectedLine.end = end;
        }
        
        [self setNeedsDisplay];
        [gr setTranslation:CGPointZero inView:self];
    }
}

-(void)showColorPad:(UISwipeGestureRecognizer *)gr {
    NSLog(@"Swipe");
    
    [[NSBundle mainBundle] loadNibNamed:@"ColorPadView" owner:self options:nil];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, screenRect.size.height - 60, screenRect.size.width, 60);
    self.colorPadView.frame = frame;
    self.colorPadView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.colorPadView];
    
    [self setNeedsDisplay];
}
- (IBAction)selectColor:(UIButton *)sender {
    self.selectedColor = sender.backgroundColor;
    [self.colorPadView removeFromSuperview];
    [self setNeedsDisplay];
}

@end
