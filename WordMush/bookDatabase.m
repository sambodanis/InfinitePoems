//
//  bookDatabase.m
//  WordMush
//
//  Created by Sam Bodanis on 02/03/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#include "bookDatabase.h"

@interface bookDatabase()

@property (nonatomic, strong) NSMutableArray *authorList;


@end


@implementation bookDatabase

@synthesize authorList = _authorList;

- (NSMutableArray *)authorList {
    if (!_authorList) {
        _authorList = [[NSMutableArray alloc] init];
    }
    return _authorList;
}

- (NSString *)runTests {
    
//    NSArray *textFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@".txt" inDirectory:@"./"];
    return NULL;
}


// Returns a list of all authors in app directory
// addThisOne is because of a Strange issue with two
// copies of every txt file, these skips every other
// file to avoid duplicate entries.
- (NSArray *)getAuthorList {
    NSArray *textFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@".txt" inDirectory:@"./"];
    for (NSString *filename in textFiles) {
        int beginningOfName = [filename length] - 1;
        while ([filename characterAtIndex:beginningOfName--] != '/');
        NSString *authorName = @"";
        BOOL spaceExists = false;
        for (int i = beginningOfName + 2; i < [filename length] - 4; i++) {
            authorName = [authorName stringByAppendingFormat:@"%c", [filename characterAtIndex:i]];
            if ([filename characterAtIndex:i] == ' ') spaceExists = true;
        }
        
        if (spaceExists) [self.authorList addObject:authorName];
    }
    
    return self.authorList;
}


- (NSString *)getBook:(NSString *)forAuthor {
    NSData *ascii = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:forAuthor ofType:@".txt"]];
    return [[NSString alloc] initWithData:ascii encoding:NSASCIIStringEncoding];

}



@end
