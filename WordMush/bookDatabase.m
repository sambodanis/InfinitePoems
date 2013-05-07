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
@property (nonatomic, strong) NSSet *ShakespeareComedy;
@property (nonatomic, strong) NSSet *ShakespeareTragedy;
@property (nonatomic, strong) NSSet *PoetAssortment;
@property (nonatomic, strong) NSSet *DefaultPoems;

@end


@implementation bookDatabase

@synthesize authorList = _authorList;
@synthesize ShakespeareComedy = _ShakespeareComedy;
@synthesize ShakespeareTragedy = _ShakespeareTragedy;
@synthesize PoetAssortment = _PoetAssortment;
@synthesize DefaultPoems = _DefaultPoems;

- (NSSet *)ShakespeareComedy {
    if (!_ShakespeareComedy) {
        _ShakespeareComedy = [[NSSet alloc] initWithObjects:
                              @"All's Well That Ends Well",
                              @"The Comedy of Errors",
                              @"A Midsummer Night's Dream",
                              @"Much Ado About Nothing",
                              @"The Taming of the Shrew",
                              @"The Tempest",
                              @"Twelfth Night",
                              @"The Winter's Tale", nil];
    }
    return _ShakespeareComedy;
}

- (NSSet *)ShakespeareTragedy {
    if (!_ShakespeareTragedy) {
        _ShakespeareTragedy = [[NSSet alloc] initWithObjects:
                               @"Romeo and Juliet",
                               @"Coriolanus",
                               @"Titus Andronicus",
                               @"Julius Caesar",
                               @"Macbeth",
                               @"Hamlet",
                               @"King Lear",
                               @"Othello", nil];
    }
    return _ShakespeareTragedy;
}

- (NSSet *)PoetAssortment {
    if (!_PoetAssortment) {
        _PoetAssortment = [[NSSet alloc] initWithObjects:
                           @"Rudyard Kipling",
                           @"John Keats",
                           @"Elizabeth Browning",
                           @"William Blake",
                           @"Wadsworth",
                           @"Phillis Wheatley",
                           @"Matthew Arnold",
                           @"Lewis Carroll", nil];
    }
    return _PoetAssortment;
}

- (NSSet *)DefaultPoems {
    if (!_DefaultPoems) {
        _DefaultPoems = [[NSSet alloc] initWithObjects:
                         @"Edgar Allen Poe",
                         @"Emily Dickinson",
                         @"Oscar Wilde",
                         @"Pablo Neruda",
                         @"Robert Burns",
                         @"Robert Frost",
                         @"Thomas Hardy",
                         @"Walt Whitman", nil];
    }
    return _DefaultPoems;
}

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

- (BOOL)authorCanBeAdded:(NSString *)Author {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.wordmush.IAP.additionalPoems1"] && [self.ShakespeareComedy containsObject:Author]) {
        return YES;
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.wordmush.IAP.Macbeth"] && [self.ShakespeareTragedy containsObject:Author]) {
        return YES;
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"com.wordmush.IAP.morePoets"] && [self.PoetAssortment containsObject:Author]) {
        return YES;
    } else if ([self.DefaultPoems containsObject:Author]) {
        return YES;
    }
    return NO;
}


// Returns a list of all authors in app directory
// addThisOne is because of a Strange issue with two
// copies of every txt file, these skips every other
// file to avoid duplicate entries.
- (NSArray *)getAuthorList {
    NSArray *textFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@".txt" inDirectory:@"./"];
//    NSLog(@"files: %@", textFiles);
    for (NSString *filename in textFiles) {
        int beginningOfName = [filename length] - 1;
        while ([filename characterAtIndex:beginningOfName--] != '/');
        NSString *authorName = @"";
        BOOL spaceExists = false;
        for (int i = beginningOfName + 2; i < [filename length] - 4; i++) {
            authorName = [authorName stringByAppendingFormat:@"%c", [filename characterAtIndex:i]];
            if ([filename characterAtIndex:i] == ' ') spaceExists = true;
        }
        BOOL authorAvailable = [self authorCanBeAdded:authorName];
        if (spaceExists && authorAvailable) [self.authorList addObject:authorName];
    }
    return self.authorList;
}


- (NSString *)getBook:(NSString *)forAuthor {
    NSData *ascii = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:forAuthor ofType:@".txt"]];
    return [[NSString alloc] initWithData:ascii encoding:NSUTF8StringEncoding];

}



@end
