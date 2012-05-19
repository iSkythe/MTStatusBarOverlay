//
//  ViewController.h
//  Example_App
//
//  Created by Riley Testut on 12/23/11.
//  Copyright (c) 2011 Richardson High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStatusBarOverlay.h"

@interface ViewController : UIViewController <MTStatusBarOverlayDelegate>
@property (strong, nonatomic) IBOutlet UIView *portrait;
@property (strong, nonatomic) IBOutlet UIView *landscape;
- (IBAction)changeStatusBarStyle:(id)sender;
- (IBAction)postMessage:(id)sender;
- (IBAction)postProgressMessage:(id)sender;
- (IBAction)postErrorMessage:(id)sender;
- (IBAction)postFinishedMessage:(id)sender;
@end
