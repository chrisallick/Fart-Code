//
//  CameraOverlayView.m
//  Fart Code
//
//  Created by chrisallick on 9/24/13.
//  Copyright (c) 2013 GSP BETA Group. All rights reserved.
//

#import "CameraOverlayView.h"

@implementation CameraOverlayView

@synthesize covd, productLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *overlayImage = [UIImage imageNamed:@"overlay.png"];
        if( !IS_IPHONE_5 ) {
            overlayImage = [UIImage imageNamed:@"overlay_4.png"];
        }
        overlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        [overlayImageView setImage:overlayImage];
        [self addSubview:overlayImageView];

        UIImage *infoButtonImage = [UIImage imageNamed:@"infoButton.png"];
        infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [infoButton setImage:infoButtonImage forState:UIControlStateNormal];
        [infoButton setAdjustsImageWhenHighlighted:NO];
        [infoButton setFrame:CGRectMake(0.0, 960.0/2.0, infoButtonImage.size.width/2, infoButtonImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [infoButton setFrame:CGRectMake(0.0, 815.0/2.0, infoButtonImage.size.width/2, infoButtonImage.size.height/2)];
        }
        [infoButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [infoButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [infoButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [infoButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:infoButton];
        
        progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 810.0/2.0, self.frame.size.width, 30.0)];
        if( !IS_IPHONE_5 ) {
            [progressLabel setFrame:CGRectMake(0.0, 693.0/2.0, self.frame.size.width, 30.0)];
        }
        [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:30.0]];
        [progressLabel setTextAlignment:NSTextAlignmentCenter];
        [progressLabel setNumberOfLines:1];
        [progressLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [progressLabel setTextColor:[UIColor colorWithRed:0.051 green:0.051 blue:0.051 alpha:1]];
        [progressLabel setText:@"SCANNING..."];
        [self addSubview:progressLabel];
        
        productLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-550.0/4.0, 850.0/2.0, 550.0/2.0, 60.0)];
        if( !IS_IPHONE_5 ) {
            [productLabel setFrame:CGRectMake(self.frame.size.width/2-550.0/4.0, 764.0/2.0, 550.0/2.0, 60.0)];
        }
        [productLabel setClipsToBounds:YES];
        [productLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:30.0]];
        [productLabel setNumberOfLines:3];
        [productLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [productLabel setTextAlignment:NSTextAlignmentCenter];
        [productLabel setTextColor:[UIColor colorWithRed:0.051 green:0.051 blue:0.051 alpha:1]];
        [productLabel setText:@""];
        [self addSubview:productLabel];
    }
    return self;
}

- (BOOL)prefersStatusBarHidden { return YES; }

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
                         [covd loadInstructions];
                     }];
}

-(void)resetView {
    [progressLabel setFrame:CGRectMake(0.0, 810.0/2.0, self.frame.size.width, 30.0)];
    [progressLabel setNumberOfLines:1];
    [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:30.0]];
    [progressLabel setText:@"SCANNING..."];
    if( !IS_IPHONE_5 ) {
        [progressLabel setFrame:CGRectMake(0.0, 693.0/2.0, self.frame.size.width, 30.0)];
    }
    
    [productLabel setFrame:CGRectMake(self.frame.size.width/2-550.0/4.0, 850.0/2.0, 550.0/2.0, 60.0)];
    if( !IS_IPHONE_5 ) {
        [productLabel setFrame:CGRectMake(self.frame.size.width/2-550.0/4.0, 764.0/2.0, 550.0/2.0, 60.0)];
    }
    [productLabel setText:@""];

    [infoButton setAlpha:1.0];
}

- (CGFloat)heightForText:(NSString *)bodyText {
    UIFont *cellFont = [UIFont systemFontOfSize:17];
    CGSize constraintSize = CGSizeMake(300, MAXFLOAT);
    CGSize labelSize = [bodyText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = labelSize.height + 50;
    
    return height;
}

-(void)found:(NSString *)upc {
    [progressLabel setFrame:CGRectMake(0.0, 810.0/2.0, self.frame.size.width, 30.0)];
    [progressLabel setNumberOfLines:1];
    [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:30.0]];
    [progressLabel setText:@"CALCULATING..."];
    if( !IS_IPHONE_5 ) {
        [progressLabel setFrame:CGRectMake(0.0, 693.0/2.0, self.frame.size.width, 30.0)];
    }
    
    [productLabel setText:@""];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"pw": @"gsp7202014", @"upc": upc};
    [manager GET:[NSString stringWithFormat:@"%@/ingredients", HOST] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        product_name = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"name"]];
        gas_ingredients = [responseObject objectForKey:@"gas_ingredients"];

//        if( [product_name isEqualToString:@"_none"] ) {
//            [progressLabel setFrame:CGRectMake(0.0, 790.0/2.0, self.frame.size.width, 60.0)];
//            [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:28.0]];
//            [progressLabel setNumberOfLines:2];
//            [progressLabel setText:@"NO FOOD FOUND.\nMAYBE DON'T EAT THAT?"];
//            if( !IS_IPHONE_5 ) {
//                [progressLabel setFrame:CGRectMake(0.0, 693.0/2.0, self.frame.size.width, 30.0)];
//            }
//            
//            [UIView beginAnimations:@"animationOn" context:NULL];
//            [UIView setAnimationDuration:.150];
//            [infoButton setAlpha:1.0];
//            [UIView commitAnimations];
//        } else if( [gas_ingredients count] == 0 ) {
        if( [product_name isEqualToString:@"_none"] || [gas_ingredients count] == 0 ) {
            [progressLabel setFrame:CGRectMake(0.0, 790.0/2.0, self.frame.size.width, 60.0)];
            [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:28.0]];
            [progressLabel setNumberOfLines:2];
            [progressLabel setText:@"NO FARTY\nINGREDIENTS FOUND!"];
            if( !IS_IPHONE_5 ) {
                [progressLabel setFrame:CGRectMake(0.0, 693.0/2.0, self.frame.size.width, 30.0)];
            }
            
            [UIView beginAnimations:@"animationOn" context:NULL];
            [UIView setAnimationDuration:.150];
            [infoButton setAlpha:1.0];
            [UIView commitAnimations];
        } else {
            [UIView animateWithDuration: 0.150
                                  delay: 0.0
                                options: UIViewAnimationCurveEaseInOut
                             animations:^{
                                 [infoButton setAlpha:0.0];
                             }
                             completion:^(BOOL finished) {
                                 [progressLabel setFrame:CGRectMake(0.0, 774.0/2.0, self.frame.size.width, 28.0)];
                                 [progressLabel setNumberOfLines:1];
                                 [progressLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:28.0]];
                                 [progressLabel setText:@"FOUND"];
                                 if( !IS_IPHONE_5 ) {
                                     [progressLabel setFrame:CGRectMake(0.0, 683.0/2.0, self.frame.size.width, 30.0)];
                                 }
                                 
                                 [productLabel setText:product_name];

                                 [NSTimer scheduledTimerWithTimeInterval:2.0 block:^{
                                     [covd loadMeter:gas_ingredients andProductName:product_name];
                                 } repeats:NO];
                             }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
