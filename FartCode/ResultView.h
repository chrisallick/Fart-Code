//
//  ResultView.h
//  Fart Code
//
//  Created by chrisallick on 9/24/13.
//  Copyright (c) 2013 GSP BETA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "AFNetworking.h"
#import "UIImage+animatedGIF.h"
#import "NSTimer+Blocks.h"

@protocol ResultViewDelegate

-(void) closeResults:(NSMutableArray *)gas_ingredients andProductName:(NSString *)product_name andFartSound:(NSString *)fartSound;

@end

@interface ResultView : UIView <AVAudioPlayerDelegate> {
    AVAudioPlayer *fart_one, *fart_two, *fart_three, *fart_four, *fart_five;
    
    UIImageView *bg;
    
    NSTimer *fartTimer;

    NSTimer *dismissTimer;
    
    NSDictionary *fartSounds;
    NSString *fartSoundPlayed;
    
    BOOL playing, waiting;
    
    NSString *product_name;
    NSMutableArray *gas_ingredients;
    
    __weak id <ResultViewDelegate> resultViewDelegate;
}

-(void)animateMeter:(NSMutableArray *)gas_ingredients andProductName:(NSString *)product_name;
-(void)resetView;

@property (nonatomic, weak) id <ResultViewDelegate> resultViewDelegate;

@end
