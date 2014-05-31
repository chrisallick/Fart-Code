//
//  InstructionsView.h
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/30/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+animatedGIF.h"

@protocol InstructionsViewDelegate

-(void) doneWithInstructions;

@end

@interface InstructionsView : UIView {
    UIButton *skipButton;

    UIView *instructions;
    UIImageView *instruction_one, *instruction_two, *instruction_three, *dots;

    int count;
    
    NSTimer *timer;
    
    __weak id <InstructionsViewDelegate> givd;
}

@property (nonatomic, weak) id <InstructionsViewDelegate> ivd;
//@property (nonatomic, retain) UIButton *skipButton;

-(void)resetView;
-(void)viewHadLoaded;

@end
