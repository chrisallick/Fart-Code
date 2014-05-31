//
//  LegalView.h
//  Fart Code
//
//  Created by chrisallick on 5/6/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSTimer+Blocks.h"
#import "UIImage+animatedGIF.h"

@protocol LegalViewDelegate

-(void) doneWithLegal;

@end

@interface LegalView : UIView <UIWebViewDelegate> {
    
    UIImageView *loading;
    
    __weak id <LegalViewDelegate> lvd;
}

@property (nonatomic, weak) id <LegalViewDelegate> lvd;

@end
