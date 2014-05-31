//
//  ViewController.m
//  FartCode
//
//  Created by chrisallick on 2/5/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.384 green:0.973 blue:0.702 alpha:1]];
    
    UIImage *background = [UIImage imageNamed:@"background.png"];
    if( !IS_IPHONE_5 ) {
        background = [UIImage imageNamed:@"background_4.png"];
    }
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    [backgroundView setImage:background];
    [self.view addSubview:backgroundView];
    
    cov = [[CameraOverlayView alloc] initWithFrame:self.view.frame];
    [cov setCovd:self];
    
    splash_fart = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"splashfart" ofType:@"m4a"]] error:nil];
    [splash_fart setVolume: 0.8];
    [splash_fart setDelegate:self];
    [splash_fart setNumberOfLoops:0];
    [splash_fart prepareToPlay];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/keepalive", HOST] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"logo" withExtension:@"gif"];
    if( !IS_IPHONE_5 ) {
        filePath = [[NSBundle mainBundle] URLForResource:@"logo_4" withExtension:@"gif"];
    }
    UIImage *logoAnimatedImage = [UIImage animatedImageWithAnimatedGIFURL:filePath];
    [backgroundView setUserInteractionEnabled:YES];
    [backgroundView setImage:logoAnimatedImage];
    
    [NSTimer scheduledTimerWithTimeInterval:1.00 block:^{
        [splash_fart play];
    } repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:1.850 block:^{
        iv = [[InstructionsView alloc] initWithFrame:self.view.frame];
        [iv setIvd:self];
        [iv setAlpha:0.0];
        [self.view addSubview:iv];
 
        if( ![[NSUserDefaults standardUserDefaults] valueForKey:@"hasRun"] ) {
            [UIView animateWithDuration: 0.300
                                  delay: 0.0
                                options: UIViewAnimationCurveEaseInOut
                             animations:^{
                                 [iv setAlpha:1.0];
                             }
                             completion:^(BOOL finished) {
                                 [backgroundView setHidden:YES];
                             }];
        } else {
            [backgroundView setHidden:YES];
            [iv setHidden:YES];
            [self launchScanner];

// testing links load different section of app.

//            [cov.productLabel setText:@"A very very very long string that won't fit"];

//            [self loadMeter:@[@"beans"] andProductName:@"poop"];
//            [self loadMeter:@[@"beans", @"butter"] andProductName:@"poop"];
//            [self loadMeter:@[@"beans", @"butter", @"whey"] andProductName:@"poop"];
//            [self loadMeter:@[@"beans", @"butter", @"whey", @"sugar"] andProductName:@"poop"];
//            [self loadMeter:@[@"beans", @"butter", @"whey", @"sugar", @"carbinat"] andProductName:@"poop"];

//            [self legal];
        }
    } repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) loadMeter:(NSMutableArray *)ingredients andProductName:(NSString *)product_name {
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    if( !rv ) {
        rv = [[ResultView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
        [rv setResultViewDelegate:self];
        [rv setHidden:YES];
        [self.view addSubview:rv];
        [rv animateMeter:ingredients andProductName:product_name];
    } else {
        [rv setHidden:YES];
        [rv resetView];
        [rv animateMeter:ingredients andProductName:product_name];
    }
    
    [UIView animateWithDuration: 0.300
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [iv setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {

                     }];
}

-(void) loadInstructions {
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    [iv setAlpha:0.0];
    [iv resetView];
    [iv setHidden:NO];
    [UIView animateWithDuration: 0.300
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [iv setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(NSString *)hexToString:(NSString *)hex {
    NSScanner *scan = [[NSScanner alloc] initWithString:hex];
    unsigned int val;
    [scan scanHexInt:&val];
    char cc[4];
    cc[3] = (val >> 0) & 0xFF;
    cc[2] = (val >> 8) & 0xFF;
    cc[1] = (val >> 16) & 0xFF;
    cc[0] = (val >> 24) & 0xFF;
    NSString *s = [[NSString alloc]
                   initWithBytes:cc
                   length:4
                   encoding:NSUTF32StringEncoding];
    return s;
}

-(void) sendText:(NSString *)url andProductName:(NSString *)product_name {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        if( [product_name length] > 8 ) {
            product_name = [NSString stringWithFormat:@"%@...",[product_name substringToIndex: MIN(8, [product_name length])]];
        }
        controller.body = [NSString stringWithFormat:@"%@ %@ Hey, check out this interesting fact about eating %@", url, [self hexToString:@"1F4A8"], product_name];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void) doneWithLegal {
    [UIView animateWithDuration: 0.250
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [lv setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         [lv setHidden:YES];
                         [lv setAlpha:0.0];
                     }];
}

-(void) legal {
    if( !lv ) {
        lv = [[LegalView alloc] initWithFrame:self.view.frame];
        [lv setLvd:self];
        [self.view addSubview:lv];
    }

    [lv setAlpha:0.0];
    [lv setHidden:NO];
    [UIView animateWithDuration: 0.300
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [lv setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(void) rescan {
    [sv setHidden:YES];
    [self launchScanner];
}

//-(void) closeResults:(NSMutableArray *)gas_ingredients andProductName:(NSString *)product_name {
-(void) closeResults:(NSMutableArray *)gas_ingredients andProductName:(NSString *)product_name andFartSound:(NSString *)fartSound {
    [rv setHidden:YES];
    if( sv ) {
        [sv setHidden:NO];
    } else {
        sv = [[ShareView alloc] initWithFrame:self.view.frame];
        [sv setShareViewDelegate:self];
        [self.view addSubview:sv];
    }
    
    [sv setInfo:gas_ingredients andProductName:product_name andFartSound:fartSound];
}

-(void) doneWithInstructions {
    [iv setHidden:YES];
    [self launchScanner];
}

-(void) launchScanner {
    if( !reader ) {
        reader = [ZBarReaderViewController new];
    } else {
        NSLog(@"reader already exists");
    }
    
    [cov resetView];
    
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationPortrait);
    [reader setCameraOverlayView:cov];
    [reader setShowsZBarControls:NO];
    [reader setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if( !scanner ) {
        scanner = reader.scanner;
    } else {
        NSLog(@"scanner already exists");
    }
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *)theReader didFinishPickingMediaWithInfo: (NSDictionary*) info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    NSString *result = [NSString stringWithFormat:@"%@",symbol.data];
    [cov found:result];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	switch (result) {
		case MessageComposeResultCancelled: {
			break;
		} case MessageComposeResultFailed: {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fart Code" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			break;
		} case MessageComposeResultSent: {
			break;
		} default: {
			break;
        }
	}
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden { return YES; }

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {}

@end
