//
//  bookDatabase.m
//  WordMush
//
//  Created by Sam Bodanis on 02/03/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#include "bookDatabase.h"

@interface bookDatabase()

@property (nonatomic, strong) NSArray *authorList;
@property (nonatomic, strong) NSBundle *bookBundle;

@end


@implementation bookDatabase

@synthesize authorList = _authorList;
@synthesize bookBundle = _bookBundle;

- (NSBundle *)bookBundle {
    if (!_bookBundle) {
        _bookBundle = [[NSBundle alloc] initWithPath:@"allBooksBundle.bundle"];
    }
    return _bookBundle;
}

- (NSString *)runTests {
    NSString *hamletPath = [self.bookBundle pathForResource:@"Hamlet" ofType:@".txt"];
    return hamletPath;
//    NSLog(@"Path: %@", hamletPath);
//    NSData *sawyerData = [NSData dataWithContentsOfFile:@"allBooksBundle.bundle/TomSawyer.txt"];
//    return [[NSString alloc] initWithData:sawyerData encoding:NSASCIIStringEncoding];
    
    
//    return @"Tests good";
}


+ (NSArray *)getAuthorList {
 
    
    return NULL;
}


+ (NSString *)getBook:(NSString *)forAuthor {
    
    
    
    return NULL;
}



@end
