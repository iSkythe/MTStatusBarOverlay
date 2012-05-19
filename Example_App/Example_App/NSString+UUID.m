//
//  NSString+UUID.m
//  Camera Prime
//
//  Created by Riley on 3/19/11.
//  Copyright 2011 Testut Tech. All rights reserved.
//

#import "NSString+UUID.h"


@implementation NSString (NSString_UUID)

+(NSString *)randomUUID {
    NSMutableString *uuid = nil;
    CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
    if (theUUID) {
        uuid = (__bridge_transfer NSMutableString *)CFUUIDCreateString(kCFAllocatorDefault, theUUID);
    }
    else {
        CFUUIDRef theSecondUUID = CFUUIDCreate(kCFAllocatorDefault); 
        if (theSecondUUID) {
            uuid = (__bridge_transfer NSMutableString *)CFUUIDCreateString(kCFAllocatorDefault, theSecondUUID);
        }
        else {
            NSLog(@"Ok, we have a problem here. Reverting to dates");
            NSString *string = [[NSString alloc] initWithFormat:@"%@", [NSDate date]];
            uuid = (NSMutableString *)string;
        }
        CFRelease(theSecondUUID);
    }
    CFRelease(theUUID);
    return uuid;
}

@end
