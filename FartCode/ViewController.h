//
//  ViewController.h
//  FartCode
//
//  Created by chrisallick on 2/5/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>

#import "ZBarSDK.h"
#import "AFNetworking.h"
#import "NSTimer+Blocks.h"

#import "CameraOverlayView.h"
#import "ResultView.h"
#import "InstructionsView.h"
#import "ShareView.h"
#import "LegalView.h"

@interface ViewController : UIViewController <ZBarReaderDelegate, CameraOverlayViewDelegate, ResultViewDelegate, InstructionsViewDelegate, ShareViewDelegate, MFMessageComposeViewControllerDelegate, LegalViewDelegate, AVAudioPlayerDelegate> {
    ZBarReaderViewController *reader;
    ZBarImageScanner *scanner;

    CameraOverlayView *cov;

    ResultView *rv;
    
    InstructionsView *iv;
    
    ShareView *sv;
    
    LegalView *lv;
    
    AVAudioPlayer *splash_fart;
}

@end