//
//  ViewController.m
//  Example_App
//
//  Created by Riley Testut on 12/23/11.
//  Copyright (c) 2011 Richardson High School. All rights reserved.
//

#import "ViewController.h"
#import "MTStatusBarOverlay.h"
#import "NSString+UUID.h"
#import "NSTimer+Blocks.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)

@implementation ViewController
@synthesize portrait;
@synthesize landscape;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedOverlay];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    overlay.detailViewMode = MTDetailViewModeHistory;
    overlay.delegate = self;
    overlay.mainProgress = 0.0;
    overlay.historyEnabled = YES;
    self.wantsFullScreenLayout = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLandscape:nil];
    [self setPortrait:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        self.view.bounds = CGRectMake(0, 0, 300.0, 480.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0, 0, 460.0, 320.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(180));
        self.view.bounds = CGRectMake(0, 0, 300.0, 480.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0, 0, 460.0, 320.0);
    }
}

- (IBAction)changeStatusBarStyle:(id)sender {
    NSInteger selectionIndex = [(UISegmentedControl *)sender selectedSegmentIndex];
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    switch (selectionIndex) {
        case 0:
            style = UIStatusBarStyleDefault;
            break;
        case 1:
            style = UIStatusBarStyleBlackOpaque;
            break;
        case 2:
            style = UIStatusBarStyleBlackTranslucent;
            break;
            
        default:
            break;
    }
    
    [UIApplication sharedApplication].statusBarStyle = style;
}

- (IBAction)postMessage:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *message = @"Posted a normal message!";
    NSString *key = [NSString randomUUID];//This generates new random key for each message. Depending on how you use MTStatusBarOverlay, you may want to have a constant string for each message.
        
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"Disappear"]) {
        [[MTStatusBarOverlay sharedOverlay] postMessage:message key:key duration:2.0];
    }
    else [[MTStatusBarOverlay sharedOverlay] postMessage:message key:key];
        
}

- (IBAction)postProgressMessage:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *message = @"Posted a progress message!";
    NSString *key = [NSString randomUUID];//This generates new random key for each message. Depending on how you use MTStatusBarOverlay, you may want to have a constant string for each message.
    
    [[MTStatusBarOverlay sharedOverlay] postMessage:message key:key];
    
    __block double progress = 0.00;
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:.1 block:^{
        [[MTStatusBarOverlay sharedOverlay] setProgress:progress key:key];
        progress = progress + .01;
        if (progress > 1.05) {//To show that even though you may put in a value higher than 1, it will never show more than 100%
            [timer invalidate];
            if ([[button titleForState:UIControlStateNormal] isEqualToString:@"Disappear"]) {
                [[MTStatusBarOverlay sharedOverlay] removeMessageFromHistoryForKey:key];
            }
        }
    } repeats:YES];
}

- (IBAction)postErrorMessage:(id)sender {
    NSString *message = @"Posted an error message!";
    NSString *key = [NSString randomUUID];//This generates new random key for each message. Depending on how you use MTStatusBarOverlay, you may want to have a constant string for each message.
    
    [[MTStatusBarOverlay sharedOverlay] postErrorMessage:message key:key duration:5.0];
}

- (IBAction)postFinishedMessage:(id)sender {
    NSString *message = @"Posted a finish message!";
    NSString *key = [NSString randomUUID];//This generates new random key for each message. Depending on how you use MTStatusBarOverlay, you may want to have a constant string for each message.
    
    [[MTStatusBarOverlay sharedOverlay] postFinishMessage:message key:key duration:5.0];
}
@end
