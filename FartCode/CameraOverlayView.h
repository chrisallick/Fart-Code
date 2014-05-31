//
//  CameraOverlayView.h
//  Fart Code
//
//  Created by chrisallick on 9/24/13.
//  Copyright (c) 2013 GSP BETA Group. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "NSTimer+Blocks.h"

@protocol CameraOverlayViewDelegate

-(void) loadMeter:(NSMutableArray *)ingredients andProductName:(NSString *)product_name;
-(void) loadInstructions;

@end

@interface CameraOverlayView : UIView {
    UIImageView *overlayImageView;
    UILabel *resultLabel;
    UILabel *progressLabel, *productLabel;
    UIButton *infoButton;
    
    NSString *product_name;
    NSMutableArray *gas_ingredients;
    
    __weak id <CameraOverlayViewDelegate> covd;
}

@property (nonatomic, weak) id <CameraOverlayViewDelegate> covd;
@property (nonatomic, retain) UILabel *productLabel;

-(void)resetView;
-(void)found:(NSString *)upc;

@end
