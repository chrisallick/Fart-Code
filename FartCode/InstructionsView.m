//
//  GameInstructionsView.m
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/30/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import "InstructionsView.h"

@implementation InstructionsView

@synthesize ivd;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        count = 0;

        [self setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1]];
        
        instructions = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width*3.0, self.frame.size.height)];
        [self addSubview:instructions];
        
        // instructions one
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"instruction_one" withExtension:@"gif"];
        UIImage *instructionImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        instruction_one = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 50.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        if( !IS_IPHONE_5 ) {
            [instruction_one setFrame:CGRectMake(0.0, 29.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        }
        [instruction_one setImage:instructionImage];
        [instruction_one setUserInteractionEnabled:YES];
        [instructions addSubview:instruction_one];

        // instructions two
        filePath = [[NSBundle mainBundle] URLForResource:@"instruction_two" withExtension:@"gif"];
        instructionImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        instruction_two = [[UIImageView alloc] initWithFrame:CGRectMake(640.0, 50.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        if( !IS_IPHONE_5 ) {
            [instruction_two setFrame:CGRectMake(640.0, 31.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        }
        [instruction_two setImage:instructionImage];
        [instruction_two setUserInteractionEnabled:YES];
        [instructions addSubview:instruction_two];

        // instructions three
        filePath = [[NSBundle mainBundle] URLForResource:@"instruction_three" withExtension:@"gif"];
        instructionImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        instruction_three = [[UIImageView alloc] initWithFrame:CGRectMake(1280.0, 69.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        if( !IS_IPHONE_5 ) {
            [instruction_three setFrame:CGRectMake(1280.0, 47.0, instructionImage.size.width/2.0, instructionImage.size.height/2.0)];
        }
        [instruction_three setImage:instructionImage];
        [instruction_three setUserInteractionEnabled:YES];
        [instructions addSubview:instruction_three];
        
        // Add swipeGestures
        UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(oneFingerSwipeLeft:)];
        [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:oneFingerSwipeLeft];

        UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(oneFingerSwipeRight:)];
        [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:oneFingerSwipeRight];
        
        // dots one
        UIImage *dotsImage = [UIImage imageNamed:@"dotsOne.png"];
        dots = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-dotsImage.size.width/4.0, 790.0/2.0, dotsImage.size.width/2.0, dotsImage.size.height/2.0)];
        if( !IS_IPHONE_5 ) {
            [dots setFrame:CGRectMake(self.frame.size.width/2.0-dotsImage.size.width/4.0, 693.0/2.0, dotsImage.size.width/2.0, dotsImage.size.height/2.0)];
        }
        [dots setImage:dotsImage];
        [self addSubview:dots];
        
        // begin button
        UIImage *skipButtonImage = [UIImage imageNamed:@"skipButton.png"];
        skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 966.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
        if( !IS_IPHONE_5 ) {
            [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 815.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
        }
        [skipButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
        [skipButton setAdjustsImageWhenHighlighted:NO];
        [skipButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [skipButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [skipButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [skipButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [skipButton setUserInteractionEnabled:YES];
        [skipButton setTag:1];
        [self addSubview:skipButton];
        
        timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                 target: self
                                               selector: @selector(onTick:)
                                               userInfo: nil
                                                repeats: YES];
    }
    return self;
}

-(void)resetView {
    count = 0;
    
    if( timer ) {
        [timer invalidate];
    }

    [instructions setFrame:CGRectMake(0.0, 0.0, instructions.frame.size.width, instructions.frame.size.height)];
    [dots setImage:[UIImage imageNamed:@"dotsOne.png"]];
    
    // skip
    UIImage *skipButtonImage = [UIImage imageNamed:@"skipButton.png"];
    [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 966.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
    if( !IS_IPHONE_5 ) {
        [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 815.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
    }
    [skipButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                             target: self
                                           selector: @selector(onTick:)
                                           userInfo: nil
                                            repeats: YES];
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    [timer invalidate];
    
    count++;

    if( count > 2 ) {
        count = 2;
    } else if( count == 1 ) {
        [self loadTwo];
    } else if( count == 2 ) {
        [self loadThree];
    }
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    [timer invalidate];
    
    count--;
    
    if( count < 0 ) {
        count = 0;
    } else if( count == 0 ) {
        [self loadOne];
    } else if( count == 1 ) {
        [self loadTwo];
    }
}

-(void) onTick:(NSTimer *)t {
    count++;

    if( count > 2 ) {
        count = 0;
    }
    
    if( count == 0 ) {
        [self loadOne];
    } else if( count == 1 ) {
        [self loadTwo];
    } else if( count == 2 ) {
        [self loadThree];
    }
}

-(void)loadOne {
    [UIView animateWithDuration: 0.300
                          delay: 0.00
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [instructions setFrame:CGRectMake(0.0, 0.0, instructions.frame.size.width, instructions.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [dots setImage:[UIImage imageNamed:@"dotsOne.png"]];
                         
                         // skip
                         UIImage *skipButtonImage = [UIImage imageNamed:@"skipButton.png"];
                         [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 966.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         if( !IS_IPHONE_5 ) {
                             [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 815.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         }
                         [skipButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
                     }];
}

-(void)loadTwo {
    [UIView animateWithDuration: 0.300
                          delay: 0.00
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [instructions setFrame:CGRectMake(-640.0, 0.0, instructions.frame.size.width, instructions.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [dots setImage:[UIImage imageNamed:@"dotsTwo.png"]];
                         
                         // skip
                         UIImage *skipButtonImage = [UIImage imageNamed:@"skipButton.png"];
                         [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 966.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         if( !IS_IPHONE_5 ) {
                             [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 815.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         }
                         [skipButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
                     }];
}

-(void)loadThree {
    [UIView animateWithDuration: 0.300
                          delay: 0.00
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [instructions setFrame:CGRectMake(-1280.0, 0.0, instructions.frame.size.width, instructions.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [dots setImage:[UIImage imageNamed:@"dotsThree.png"]];

                         // letsgo
                         UIImage *skipButtonImage = [UIImage imageNamed:@"letsGoButton.png"];
                         [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 975.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         if( !IS_IPHONE_5 ) {
                             [skipButton setFrame:CGRectMake(self.frame.size.width/2-skipButtonImage.size.width/4.0, 820.0/2.0, skipButtonImage.size.width/2, skipButtonImage.size.height/2.0)];
                         }
                         [skipButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
                     }];
    ;}

-(void)onTouchUp:(UIButton *)sender {
    [UIView beginAnimations:@"animationOn" context:NULL];
    [UIView setAnimationDuration:.150];
    [sender setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}

-(void)onTouchDown:(UIButton *)sender {
    [UIView beginAnimations:@"animationOn" context:NULL];
    [UIView setAnimationDuration:.150];
    [sender setTransform:CGAffineTransformMakeScale(0.85, 0.85)];
    [UIView commitAnimations];
}

-(void)onTap:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"hasRun"];
    
    [UIView animateWithDuration: 0.150
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [sender setTransform:CGAffineTransformIdentity];
                     }
                     completion:^(BOOL finished) {
                         if( [sender tag] == 1 ) {
                             [ivd doneWithInstructions];
                         }
                     }];
}

@end
