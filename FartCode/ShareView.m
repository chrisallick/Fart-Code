//
//  ShareView.m
//  Fart Code
//
//  Created by chrisallick on 2/10/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

@synthesize shareViewDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1]];
        
        
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"shareBackground" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"shareBackground_4" withExtension:@"gif"];
        }
        UIImage *bgImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
        [bg setImage:bgImage];
        [self addSubview:bg];
        
        filePath = [[NSBundle mainBundle] URLForResource:@"textFartLoading" withExtension:@"gif"];
        UIImage *textFartImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        textFart = [UIButton buttonWithType:UIButtonTypeCustom];
        [textFart setImage:textFartImage forState:UIControlStateNormal];
        [textFart setAdjustsImageWhenHighlighted:NO];
        [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 779.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 638.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
        }
        [textFart setTag:0];
        [textFart addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [textFart addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [textFart addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [textFart addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:textFart];
        
        UIImage *rescanFartImage = [UIImage imageNamed:@"rescanFartButton.png"];
        UIButton *rescanFart = [UIButton buttonWithType:UIButtonTypeCustom];
        [rescanFart setImage:rescanFartImage forState:UIControlStateNormal];
        [rescanFart setAdjustsImageWhenHighlighted:NO];
        [rescanFart setFrame:CGRectMake(self.frame.size.width/2.0 - rescanFartImage.size.width/4.0, 925.0/2.0, rescanFartImage.size.width/2, rescanFartImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [rescanFart setFrame:CGRectMake(self.frame.size.width/2.0 - rescanFartImage.size.width/4.0, 780.0/2.0, rescanFartImage.size.width/2, rescanFartImage.size.height/2)];
        }
        [rescanFart setTag:1];
        [rescanFart addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [rescanFart addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [rescanFart addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [rescanFart addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:rescanFart];
        
        UIImage *legalButtonImage = [UIImage imageNamed:@"legalButton.png"];
        UIButton *legalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [legalButton setImage:legalButtonImage forState:UIControlStateNormal];
        [legalButton setAdjustsImageWhenHighlighted:NO];
        [legalButton setFrame:CGRectMake(self.frame.size.width-legalButtonImage.size.width/2.0, self.frame.size.height-legalButtonImage.size.height/2.0, legalButtonImage.size.width/2, legalButtonImage.size.height/2)];
        [legalButton setTag:2];
        [legalButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [legalButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [legalButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [legalButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:legalButton];
        
        
        UIImage *replayFartButtonImage = [UIImage imageNamed:@"replayFartButton.png"];
        UIButton *replayFartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [replayFartButton setImage:replayFartButtonImage forState:UIControlStateNormal];
        [replayFartButton setAdjustsImageWhenHighlighted:NO];
        [replayFartButton setFrame:CGRectMake(self.frame.size.width/2-replayFartButtonImage.size.width/4, self.frame.size.height-(replayFartButtonImage.size.height/2.0)-(14.0/2.0), replayFartButtonImage.size.width/2, replayFartButtonImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [replayFartButton setFrame:CGRectMake(14.0/2.0, self.frame.size.height-(replayFartButtonImage.size.height/2.0)-(14.0/2.0), replayFartButtonImage.size.width/2.0, replayFartButtonImage.size.height/2.0)];
        }
        [replayFartButton setTag:3];
        [replayFartButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [replayFartButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [replayFartButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [replayFartButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:replayFartButton];
        
        idv = [[IngredientDescriptionView alloc] initWithFrame:frame];
        [idv setIdvd:self];
        [idv setHidden:YES];
        [self addSubview:idv];
    }
    return self;
}

-(void) launchDescriptionViewWithTitle:(NSString *)title andCopy:(NSString *)copy {
    [idv setTitle:title andCopy:copy];
    [idv setAlpha:0.0];
    [idv setHidden:NO];
    [self bringSubviewToFront:idv];
    
    [UIView beginAnimations:@"animationOn" context:NULL];
    [UIView setAnimationDuration:.150];
    [idv setAlpha:1.0];
    [UIView commitAnimations];
}

-(void) closeDescription {
    [UIView animateWithDuration: 0.150
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [idv setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         [idv setHidden:YES];
                     }];
}

-(void) setInfo:(NSMutableArray *)_gas_ingredients andProductName:(NSString *)_product_name andFartSound:(NSString *)fartSound {
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"textFartLoading" withExtension:@"gif"];
    UIImage *textFartImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
    [textFart setImage:textFartImage forState:UIControlStateNormal];
    [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 779.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
    if( !IS_IPHONE_5 ) {
        [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 638.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
    }
    
    

    NSString *fartURL = [[NSBundle mainBundle] pathForResource:fartSound ofType:@"m4a"];
    the_fart = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
    [the_fart setVolume: 0.8];
    [the_fart setDelegate:self];
    [the_fart setNumberOfLoops:0];
    [the_fart prepareToPlay];

    product_name = _product_name;
    gas_ingredients = _gas_ingredients;

    [isv removeFromSuperview];
    isv = [[IngredientsScrollView alloc] initWithFrame:CGRectMake(0.0, 286.0/2.0, self.frame.size.width, 380.0/2.0)];
    [isv setIsvd:self];
    if( !IS_IPHONE_5 ) {
        [isv setFrame:CGRectMake(0.0, 196.0/2.0, self.frame.size.width, 380.0/2.0)];
    }
    [isv loadIngredients:gas_ingredients];
    [self addSubview:isv];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/new", HOST] parameters:@{@"title":product_name, @"sound":fartSound, @"count":[@([gas_ingredients count]) stringValue]} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *fart_id = [[responseObject objectForKey:@"msg"] objectForKey:@"id"];

        fart_url = [[NSString alloc] initWithFormat:@"fartco.de/f/%@",fart_id];

        UIImage *textFartImage = [UIImage imageNamed:@"shareFartButton.png"];
        [textFart setImage:textFartImage forState:UIControlStateNormal];
        [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 779.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [textFart setFrame:CGRectMake(self.frame.size.width/2.0-textFartImage.size.width/4.0, 638.0/2.0, textFartImage.size.width/2, textFartImage.size.height/2)];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    [UIView beginAnimations:@"animationOn" context:NULL];
    [UIView setAnimationDuration:.150];
    [sender setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
    
    if( [sender tag] == 0 ) {
        [shareViewDelegate sendText:fart_url andProductName:product_name];
    } else if( [sender tag] == 1 ) {
        [shareViewDelegate rescan];
    } else if( [sender tag] == 2 ) {
        [shareViewDelegate legal];
    } else if( [sender tag] == 3 ) {
        [the_fart play];
    }
}

@end
