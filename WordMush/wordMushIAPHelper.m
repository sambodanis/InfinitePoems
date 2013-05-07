//
//  wordMushIAPHelper.m
//  WordMush
//
//  Created by Sam Bodanis on 06/05/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "wordMushIAPHelper.h"

@implementation wordMushIAPHelper

+ (wordMushIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static wordMushIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.wordmush.IAP.additionalPoems1",
                                      @"com.wordmush.IAP.Macbeth",
                                      @"com.wordmush.IAP.morePoets",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}


@end
