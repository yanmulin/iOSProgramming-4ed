//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by 阿文 on 2019/1/24.
//  Copyright © 2019 awen. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;
@property (nonatomic) int currentIndex;

@property (nonatomic, strong) UILabel *oldQuestionLabel;
@property (nonatomic, strong) UILabel *oldAnswerLabel;

@end

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.questions = @[@"What is 7+7?", @"What is the capital of vermont", @"From what is cognac made"];
        self.answers = @[@"14", @"Montpelier", @"Grapes"];
        self.currentIndex = -1;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)showQuestion:(id)sender
{
    self.currentIndex ++;
    
    if (self.currentIndex == [self.questions count])
        self.currentIndex = 0;
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenFrame.size.width;
    CGFloat screenHeight = screenFrame.size.height;
    
    UILabel *questionLabel = [[UILabel alloc] init];
//    self.QuestionLabel.alpha = 0.0;
    questionLabel.text = self.questions[self.currentIndex];
    CGRect questionFrame = CGRectMake(-240, 100, 240, 30);
    questionLabel.frame = questionFrame;
    questionLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:questionLabel];
    
    if (self.oldQuestionLabel) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.oldQuestionLabel.alpha = 0.0;
                             self.oldQuestionLabel.center = CGPointMake(screenWidth, self.oldQuestionLabel.center.y);
                         }
                         completion:^(BOOL finished) {
                             [self.view willRemoveSubview:self.oldQuestionLabel];
                             self.oldQuestionLabel = nil;
                         }];
    }

    if (self.oldAnswerLabel) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.oldAnswerLabel.alpha = 0.0;
                             self.oldAnswerLabel.center = CGPointMake(screenWidth, self.oldAnswerLabel.center.y);
                         }
                         completion:^(BOOL finished) {
                             [self.view willRemoveSubview:self.oldAnswerLabel];
                             self.oldAnswerLabel = nil;
                         }];
    }

    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         questionLabel.alpha = 1.0;
                         questionLabel.center = CGPointMake(screenWidth / 2.0, questionLabel.center.y);
                     }
                     completion:^(BOOL finished) {
                         self.oldQuestionLabel = questionLabel;

                     }];
    
}

-(IBAction)showAnswer:(id)sender
{
    if (self.currentIndex < 0) return ;
    
    UILabel *answerLabel = [[UILabel alloc] init];
    CGRect answerFrame = CGRectMake(-240, 450, 240, 30);
    answerLabel.frame = answerFrame;
    answerLabel.textAlignment = NSTextAlignmentCenter;
    answerLabel.alpha = 0.0;
    answerLabel.text = self.answers[self.currentIndex];
    
    [self.view addSubview: answerLabel];
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenFrame.size.width;
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         answerLabel.alpha = 1.0;
                         answerLabel.center = CGPointMake(screenWidth / 2.0, answerLabel.center.y);
                     }
                     completion:^(BOOL finished) {
                         self.oldAnswerLabel = answerLabel;
                     }];
}



@end
