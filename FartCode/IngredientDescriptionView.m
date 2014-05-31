//
//  IngredientDescriptionView.m
//  Fart Code
//
//  Created by chrisallick on 4/20/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import "IngredientDescriptionView.h"

@implementation IngredientDescriptionView

@synthesize idvd;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1.0]];
        
        UIImage *titleBackgroundImage = [UIImage imageNamed:@"title_bg"];
        UIImageView *titleBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-titleBackgroundImage.size.width/4.0, 16.0, titleBackgroundImage.size.width/2, titleBackgroundImage.size.height/2.0)];
        [titleBackground setImage:titleBackgroundImage];
        [self addSubview:titleBackground];
        
        title = [[THLabel alloc] initWithFrame:CGRectMake(0.0, 60.0, frame.size.width, 34.0)];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setNumberOfLines:0];
        [title setFont:[UIFont fontWithName:@"DCC-Cloud" size:34.0]];
        [title setTextColor:[UIColor colorWithRed:0.992 green:0.529 blue:0.639 alpha:1]];
        [title setStrokeColor:[UIColor blackColor]];
        [title setStrokeSize:2.0];
        [self addSubview:title];
        
        
        
        copy = [[UITextView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-270.0/2.0, 326.0/2.0, 270.0, 630.0/2.0)];
        if( !IS_IPHONE_5 ) {
            [copy setFrame:CGRectMake(self.frame.size.width/2.0-270.0/2.0, 326.0/2.0, 270.0, 450.0/2.0)];
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setLineSpacing: 8.0];
        
        NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName:@"DCC-Cloud" size:20.0], NSParagraphStyleAttributeName: paragraphStyle };
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"strigil" attributes:attributes];
        
        [copy setAttributedText: attributedString];
        
        [copy setTextAlignment:NSTextAlignmentCenter];
        [copy setEditable:NO];
        [copy setScrollEnabled:YES];
        [copy setUserInteractionEnabled:YES];
        [copy setBackgroundColor:[UIColor clearColor]];
        [copy setTextColor:[UIColor blackColor]];
        [self addSubview:copy];
        
        UIImage *backButtonImage = [UIImage imageNamed:@"back"];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:backButtonImage forState:UIControlStateNormal];
        [backButton setAdjustsImageWhenHighlighted:NO];
        [backButton setFrame:CGRectMake(self.frame.size.width/2.0-backButtonImage.size.width/4.0, self.frame.size.height - backButtonImage.size.height/2.0 - 25.0, backButtonImage.size.width/2.0, backButtonImage.size.height/2.0)];
        [backButton setTag:1];
        [backButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [backButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [backButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [backButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:backButton];
    }
    return self;
}

-(void)setTitle:(NSString *)_title andCopy:(NSString *)_copy {
    [title setText:_title];
    [copy setText:_copy];
}

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
    [UIView animateWithDuration: 0.150
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [sender setTransform:CGAffineTransformIdentity];
                     }
                     completion:^(BOOL finished) {
                         [idvd closeDescription];
                     }];
}

@end
