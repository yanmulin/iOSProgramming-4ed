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

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

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
    
    self.questionLabel.text = self.questions[self.currentIndex];
    self.answerLabel.text = @"???";
    
}

-(IBAction)showAnswer:(id)sender
{
    self.answerLabel.text = self.answers[self.currentIndex];
}



@end
