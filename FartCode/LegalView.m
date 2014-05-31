//
//  LegalView.m
//  Fart Code
//
//  Created by chrisallick on 5/6/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import "LegalView.h"

@implementation LegalView

@synthesize lvd;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1]];
        
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"loadlegal" withExtension:@"gif"];
        UIImage *loadingImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        loading = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-loadingImage.size.width/4.0, 110.0, loadingImage.size.width/2.0, loadingImage.size.height/2.0)];
        [loading setImage:loadingImage];
        [self addSubview:loading];
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-584.0/4, 20.0, 584.0/2, 965.0/2)];
        if( !IS_IPHONE_5 ) {
            [webView setFrame:CGRectMake(self.frame.size.width/2.0-584.0/4, 20.0, 584.0/2, 777.0/2)];
        }
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setAlpha:0.0];
        [webView setHidden:YES];
        [webView setDelegate:self];
        
        //NSString *urlAddress = @"http://fartcode.com/toc_mobile.html";
        NSString *urlAddress = @"http://fart:code@fartcode.com/toc_mobile.html";
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webView loadRequest:requestObj];
        
        [self addSubview:webView];
        
        UIImage *legalBackButtonImage = [UIImage imageNamed:@"legalBackButton.png"];
        UIButton *legalBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [legalBackButton setImage:legalBackButtonImage forState:UIControlStateNormal];
        [legalBackButton setAdjustsImageWhenHighlighted:NO];
        
        [legalBackButton setFrame:CGRectMake(self.frame.size.width/2-legalBackButtonImage.size.width/4, self.frame.size.height-legalBackButtonImage.size.height/2, legalBackButtonImage.size.width/2, legalBackButtonImage.size.height/2)];
        if( !IS_IPHONE_5 ) {
            [legalBackButton setFrame:CGRectMake(self.frame.size.width/2-legalBackButtonImage.size.width/4, self.frame.size.height-legalBackButtonImage.size.height/2, legalBackButtonImage.size.width/2, legalBackButtonImage.size.height/2)];
        }
        [legalBackButton setTag:1];
        [legalBackButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [legalBackButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [legalBackButton addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
        [legalBackButton addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:legalBackButton];
    }
    return self;
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
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"hasRun"];
    
    [UIView animateWithDuration: 0.150
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [sender setTransform:CGAffineTransformIdentity];
                     }
                     completion:^(BOOL finished) {
                         if( [sender tag] == 1 ) {
                             [lvd doneWithLegal];
                         }
                     }];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [loading setHidden:YES];
    [webView setAlpha:1.0];
    [NSTimer scheduledTimerWithTimeInterval:0.150 block:^{
        [webView setHidden:NO];
    } repeats:NO];
}

@end
