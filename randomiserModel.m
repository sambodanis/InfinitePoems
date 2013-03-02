//
//  randomiserModel.m
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "randomiserModel.h"

#define MAX_BOOK_LENGTH 1000
#define TEMP_MARKOV_LENGTH 8

@interface randomiserModel()
@property (nonatomic, strong) NSMutableDictionary *stringsAndSubStrings;
@end

@implementation randomiserModel

@synthesize stringsAndSubStrings = _stringsAndSubStrings;

- (NSMutableDictionary *)stringsAndSubStrings {
    if (!_stringsAndSubStrings) {
        _stringsAndSubStrings = [[NSMutableDictionary alloc] init];
    }
    return _stringsAndSubStrings;
}

- (void)analyseFrequenciesFromBook:(NSString *)book {
    int i = 0;
    NSString *nextWord = @"";
    for (int j = i; [book characterAtIndex:j] != ' '; j++) {
        nextWord = [nextWord stringByAppendingFormat:@"%c", [book characterAtIndex:j]];
    }
    i += [nextWord length] + 1;
    while (true) {
        NSString *currWord = nextWord;
        nextWord = @"";
        NSMutableArray *nextWords = [self.stringsAndSubStrings objectForKey:currWord];
        for (int j = i; [book characterAtIndex:j] != ' '; j++) {
            nextWord = [nextWord stringByAppendingFormat:@"%c", [book characterAtIndex:j]];
        }
        if (nextWords) {
            [nextWords addObject:nextWord];
        } else {
            nextWords = [NSMutableArray arrayWithObject:nextWord];
        }
        [self.stringsAndSubStrings setObject:nextWords forKey:currWord];

        i += [nextWord length] + 1;
        if (i + 4 * [nextWord length] >= [book length]) break;
//        NSLog(@"%@ -> %@", currWord, nextWord);
    }
}

- (NSString *)writeRandomText:(NSString *)seed {
    NSString *result = seed;
    NSString *currentWord = result;

    for (int i = 0; i < MAX_BOOK_LENGTH; i++) {
//        NSString *tempWord = currentWord;
        NSMutableArray *possibleNextWords = [self.stringsAndSubStrings objectForKey:currentWord];
        currentWord = [possibleNextWords objectAtIndex:(arc4random() % [possibleNextWords count])];
        result = [result stringByAppendingFormat:@"%@ ", currentWord];
    }
    
    
//    for (int i = 0; i < MAX_BOOK_LENGTH - TEMP_MARKOV_LENGTH; i++) {
//        NSString *currSubString = @"";
//        for (int j = i; j < i + TEMP_MARKOV_LENGTH; j++) {
//            currSubString = [currSubString stringByAppendingFormat:@"%c", [result characterAtIndex:j]];
//        }
//        NSString *nextChar = [self.stringsAndSubStrings objectForKey:currSubString];
//        int nextIndex = arc4random() % [nextChar length];
//        nextChar = [NSString stringWithFormat:@"%c", [nextChar characterAtIndex:nextIndex]];
//        result = [result stringByAppendingString:nextChar];
//    }
    NSLog(@"%@", result);
    NSLog(@"%u", [self.stringsAndSubStrings count]);
    return result;
}

- (NSString *)getRandomTextFromInput:(NSString *)inputBook {
    // Maybe at this point query NSData to get the specified book.
    [self analyseFrequenciesFromBook:inputBook];
    NSString *seed = @"";
    int maxOccurences = 0;
    for (NSString *key in self.stringsAndSubStrings) {
        int currOccurences = [[self.stringsAndSubStrings objectForKey:key] count];
        if (currOccurences > maxOccurences) seed = key;
//        NSLog(@"%@ : %@", key, [self.stringsAndSubStrings objectForKey:key]);
    }
    return [self writeRandomText:seed];
}

@end
