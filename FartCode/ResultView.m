//
//  ResultView.m
//  Fart Code
//
//  Created by chrisallick on 9/24/13.
//  Copyright (c) 2013 GSP BETA Group. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

@synthesize resultViewDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1]];
        
        playing = waiting = false;
        
        fartSounds = @{@"one": @[[[NSBundle mainBundle] pathForResource:@"fart_one_one" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_one_two" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_one_three" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_one_four" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_one_five" ofType:@"m4a"]],

                       @"two": @[[[NSBundle mainBundle] pathForResource:@"fart_two_one" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_two_two" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_two_three" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_two_four" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_two_five" ofType:@"m4a"]],

                       @"three": @[[[NSBundle mainBundle] pathForResource:@"fart_three_one" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_three_two" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_three_three" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_three_four" ofType:@"m4a"],
                                 [[NSBundle mainBundle] pathForResource:@"fart_three_five" ofType:@"m4a"]],

                       @"four": @[[[NSBundle mainBundle] pathForResource:@"fart_four_one" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_four_two" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_four_three" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_four_four" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_four_five" ofType:@"m4a"]],

                       @"five": @[[[NSBundle mainBundle] pathForResource:@"fart_five_one" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_five_two" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_five_three" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_five_four" ofType:@"m4a"],
                                   [[NSBundle mainBundle] pathForResource:@"fart_five_five" ofType:@"m4a"]]
                       };
        
        fartSoundPlayed = @"";
        
        NSUInteger randomIndex = arc4random() % [[fartSounds objectForKey:@"one"] count];
        NSString *fartURL = [[fartSounds objectForKey:@"one"] objectAtIndex:randomIndex];
        fart_one = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
        [fart_one setVolume: 0.8];
        [fart_one setDelegate:self];
        [fart_one setNumberOfLoops:0];
        [fart_one prepareToPlay];
        
        randomIndex = arc4random() % [[fartSounds objectForKey:@"two"] count];
        fartURL = [[fartSounds objectForKey:@"two"] objectAtIndex:randomIndex];
        fart_two = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
        [fart_two setVolume: 0.8];
        [fart_two setDelegate:self];
        [fart_two setNumberOfLoops:0];
        [fart_two prepareToPlay];
        
        randomIndex = arc4random() % [[fartSounds objectForKey:@"three"] count];
        fartURL = [[fartSounds objectForKey:@"three"] objectAtIndex:randomIndex];
        fart_three = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
        [fart_three setVolume: 0.8];
        [fart_three setNumberOfLoops:0];
        [fart_three setDelegate:self];
        [fart_three prepareToPlay];
        
        randomIndex = arc4random() % [[fartSounds objectForKey:@"four"] count];
        fartURL = [[fartSounds objectForKey:@"four"] objectAtIndex:randomIndex];
        fart_four = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
        [fart_four setVolume: 0.8];
        [fart_four setNumberOfLoops:0];
        [fart_four setDelegate:self];
        [fart_four prepareToPlay];
        
        randomIndex = arc4random() % [[fartSounds objectForKey:@"five"] count];
        fartURL = [[fartSounds objectForKey:@"five"] objectAtIndex:randomIndex];
        fart_five = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fartURL] error:nil];
        [fart_five setVolume: 0.8];
        [fart_five setDelegate:self];
        [fart_five setNumberOfLoops:0];
        [fart_five prepareToPlay];
        
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_bg_full" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_bg_full_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        bg = [[UIImageView alloc] initWithFrame:frame];
        [bg setImage:meter_bg];
        [self addSubview:bg];
    }
    return self;
}

- (void)dismissView:(NSTimer *)timer {
    if( playing ) {
        waiting = true;
    } else {
//        [resultViewDelegate closeResults:gas_ingredients andProductName:product_name];
        [resultViewDelegate closeResults:gas_ingredients andProductName:product_name andFartSound:fartSoundPlayed];
    }

}

-(void) animateMeter:(NSMutableArray *)_gas_ingredients andProductName:(NSString *)_product_name {
    gas_ingredients = _gas_ingredients;
    product_name = _product_name;
    [self setHidden:NO];

    int ingredients_count = (int)[gas_ingredients count];
    
    if ( ingredients_count == 1 ) {
        fartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playFart:) userInfo:@"one" repeats:NO];
    } else if ( ingredients_count == 2 ) {
        fartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playFart:) userInfo:@"two" repeats:NO];
    } else if ( ingredients_count == 3 ) {
        fartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playFart:) userInfo:@"three" repeats:NO];
    } else if ( ingredients_count == 4 ) {
        fartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playFart:) userInfo:@"four" repeats:NO];
    } else if ( ingredients_count >= 5 ) {
        fartTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playFart:) userInfo:@"five" repeats:NO];
    }
}

-(void) resetView {
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_bg_full" withExtension:@"gif"];
    if( !IS_IPHONE_5 ) {
        filePath = [[NSBundle mainBundle] URLForResource:@"meter_bg_full_4" withExtension:@"gif"];
    }
    UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
    [bg setImage:meter_bg];
}

- (void)playFart:(NSTimer *)timer {
    float wait = 2;
    if( [timer.userInfo isEqualToString:@"one"] ) {
        fartSoundPlayed = [[[fart_one.url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            playing = true;
            [fart_one play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        } repeats:NO];

        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_one" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_one_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        [bg setImage:meter_bg];
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_one_loop" withExtension:@"gif"];
            if( !IS_IPHONE_5 ) {
                filePath = [[NSBundle mainBundle] URLForResource:@"meter_one_loop_4" withExtension:@"gif"];
            }
            UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
            [bg setImage:meter_bg];
        } repeats:NO];
        wait = 1;
    } else if( [timer.userInfo isEqualToString:@"two"] ) {
        fartSoundPlayed = [[[fart_two.url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            playing = true;
            [fart_two play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        } repeats:NO];

        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_two" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_two_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        [bg setImage:meter_bg];
        [NSTimer scheduledTimerWithTimeInterval:1.45 block:^{
            NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_two_loop" withExtension:@"gif"];
            if( !IS_IPHONE_5 ) {
                filePath = [[NSBundle mainBundle] URLForResource:@"meter_two_loop_4" withExtension:@"gif"];
            }
            UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
            [bg setImage:meter_bg];
        } repeats:NO];
        wait = 1.8;
    } else if( [timer.userInfo isEqualToString:@"three"] ) {
        fartSoundPlayed = [[[fart_three.url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            playing = true;
            [fart_three play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        } repeats:NO];

        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_three" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_three_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        [bg setImage:meter_bg];
        [NSTimer scheduledTimerWithTimeInterval:1.5 block:^{
            NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_three_loop" withExtension:@"gif"];
            if( !IS_IPHONE_5 ) {
                filePath = [[NSBundle mainBundle] URLForResource:@"meter_three_loop_4" withExtension:@"gif"];
            }
            UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
            [bg setImage:meter_bg];
        } repeats:NO];
        wait = 2.1;
    } else if( [timer.userInfo isEqualToString:@"four"] ) {
        fartSoundPlayed = [[[fart_four.url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            playing = true;
            [fart_four play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        } repeats:NO];

        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_four" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_four_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        [bg setImage:meter_bg];
        [NSTimer scheduledTimerWithTimeInterval:2.1 block:^{
            NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_four_loop" withExtension:@"gif"];
            if( !IS_IPHONE_5 ) {
                filePath = [[NSBundle mainBundle] URLForResource:@"meter_four_loop_4" withExtension:@"gif"];
            }
            UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
            [bg setImage:meter_bg];
        } repeats:NO];
        wait = 2.6;
    } else if( [timer.userInfo isEqualToString:@"five"] ) {
        fartSoundPlayed = [[[fart_five.url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        
        [NSTimer scheduledTimerWithTimeInterval:0.45 block:^{
            playing = true;
            [fart_five play];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        } repeats:NO];

        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_five" withExtension:@"gif"];
        if( !IS_IPHONE_5 ) {
            filePath = [[NSBundle mainBundle] URLForResource:@"meter_five_4" withExtension:@"gif"];
        }
        UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
        [bg setImage:meter_bg];
        [NSTimer scheduledTimerWithTimeInterval:2.55 block:^{
            NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"meter_five_loop" withExtension:@"gif"];
            if( !IS_IPHONE_5 ) {
                filePath = [[NSBundle mainBundle] URLForResource:@"meter_five_loop_4" withExtension:@"gif"];
            }
            UIImage *meter_bg = [UIImage animatedImageWithAnimatedGIFURL:filePath];
            [bg setImage:meter_bg];
        } repeats:NO];
        wait = 3.2;
    }

    dismissTimer = [NSTimer scheduledTimerWithTimeInterval:wait target:self selector:@selector(dismissView:) userInfo:nil repeats:NO];
}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    playing = false;
    if( waiting ) {
        waiting = false;
        [NSTimer scheduledTimerWithTimeInterval:0.150 block:^{
            [resultViewDelegate closeResults:gas_ingredients andProductName:product_name andFartSound:fartSoundPlayed];
        } repeats:NO];
    }
}
@end
