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

@end


@implementation bookDatabase

@synthesize authorList = _authorList;

- (NSString *)runTests {
    
    
    return @"Tests good";
}


+ (NSArray *)getAuthorList {
 
    
    return NULL;
}


+ (NSString *)getBook:(NSString *)forAuthor {
    
    
    
    return NULL;
}



@end
