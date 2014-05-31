//
//  ShareView.h
//  Fart Code
//
//  Created by chrisallick on 2/10/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "IngredientsScrollView.h"
#import "IngredientDescriptionView.h"

#import "UIImage+animatedGIF.h"
#import "AFNetworking.h"

@protocol ShareViewDelegate

-(void) sendText:(NSString *)url andProductName:(NSString *)product_name;
-(void) rescan;
-(void) legal;

@end

@interface ShareView : UIView <IngredientsScrollViewDelegate, IngredientsDescriptionViewDelegate, AVAudioPlayerDelegate> {
    NSString *product_name;
    NSMutableArray *gas_ingredients;
    
    AVAudioPlayer *the_fart;
    
    IngredientsScrollView *isv;
    
    IngredientDescriptionView *idv;
    
    UIButton *textFart;
    
    NSString *fart_url;

    __weak id <ShareViewDelegate> shareViewDelegate;
}

@property (nonatomic, weak) id <ShareViewDelegate> shareViewDelegate;

-(void) setInfo:(NSMutableArray *)gas_ingredients andProductName:(NSString *)product_name andFartSound:(NSString *)fartSound;

@end
