//
//  randomiserModel.m
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "randomiserModel.h"

#define MAX_BOOK_LENGTH 1000

@interface randomiserModel()
@property (nonatomic, strong) NSMutableDictionary *stringsAndSubStrings;
@property (nonatomic) BOOL specialSpacing;
@end

@implementation randomiserModel

@synthesize stringsAndSubStrings = _stringsAndSubStrings;
@synthesize specialSpacing = _specialSpacing;

- (NSMutableDictionary *)stringsAndSubStrings {
    if (!_stringsAndSubStrings) {
        _stringsAndSubStrings = [[NSMutableDictionary alloc] init];
    }
    return _stringsAndSubStrings;
}

// 1st degree markov model generation
// For each word in the input book
// find all following words
// record in map(word -> array of all following words)
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
        for (int j = i; [book characterAtIndex:j] != ' '; j++) { // take away second condition
            if (j + 1 >= [book length]) break;
            nextWord = [nextWord stringByAppendingFormat:@"%c", [book characterAtIndex:j]];
        }
        if (nextWords) {
            [nextWords addObject:nextWord];
        } else {
            nextWords = [NSMutableArray arrayWithObject:nextWord];
        }
        [self.stringsAndSubStrings setObject:nextWords forKey:currWord];

        i += [nextWord length] + 1;
        if (i + 4 * [nextWord length] >= [book length]) {
            break;
        }
    }
}

// Starting from a seed, repeatdly query the map to find all
// words following the current seed. Randomly select one of these
// following words and append it to the random text, this following
// word is now the new seed. 
- (NSString *)writeRandomText:(NSString *)seed {
    NSString *result = seed;
    NSString *currentWord = result;
    
    for (int i = 0; i < MAX_BOOK_LENGTH; i++) {
        NSMutableArray *possibleNextWords = [self.stringsAndSubStrings objectForKey:currentWord];
        if (!possibleNextWords) break;
        currentWord = [possibleNextWords objectAtIndex:(arc4random() % [possibleNextWords count])];
        result = [result stringByAppendingFormat:@"%@ ", currentWord];
        
    }
    return result;
}

// Splits the random text file up into paragraph blocks.
// Randomly chooses one to return.
- (NSString *)extractPoemBlock:(NSString *)randomText {
    NSMutableArray *paragraphs = [[NSMutableArray alloc] init];
    NSString *currentString = @"";
    for (int i = 0; i < [randomText length]; i++) {
        if ([randomText characterAtIndex:i] == '\n' &&
            [randomText characterAtIndex:i + 1] == '\n' &&
            ([randomText characterAtIndex:i + 2] == '\n' || !self.specialSpacing)) {
            [paragraphs addObject:currentString];
            currentString = @"";
            i += 1;
        }
        currentString = [currentString stringByAppendingFormat:@"%c", [randomText characterAtIndex:i]];
    }
//    for (NSString *para in paragraphs) {
//        NSLog(@"%@", para);
//    }
//    NSLog(@"%d", [paragraphs count]);
    int randNum = rand() % ([paragraphs count] - 1);
    while ([[paragraphs objectAtIndex:randNum] length] < 100) {
        randNum = rand() % ([paragraphs count] - 1);
    }
    return [paragraphs objectAtIndex:randNum];
}

// Determine seed and return a random paragraph. 
- (NSString *)getRandomTextFromInput:(NSString *)inputBook withSpecialSpacing:(BOOL)spacing {
    self.specialSpacing = spacing;
    [self analyseFrequenciesFromBook:inputBook];
    NSString *seed = @"";
    int maxOccurences = 0;

    /****** Writing to file code for making new model plists ******/
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"testPlist.plist"];
//    NSLog(@"%@", plistPath);
//    [self.stringsAndSubStrings writeToFile:plistPath atomically: YES];
    
    for (NSString *key in self.stringsAndSubStrings) {
    
        int currOccurences = [[self.stringsAndSubStrings objectForKey:key] count];
        if (currOccurences > maxOccurences) seed = key;
    }
    
    NSString *singlePoemBlock = [self extractPoemBlock:[self writeRandomText:seed]];
    return singlePoemBlock;
}


- (NSString *)getRandomTextFromPlist:(NSArray *)inputBooks withSpecialSpacing:(BOOL)spacing {
    self.specialSpacing = spacing;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[inputBooks objectAtIndex:0] ofType:@".plist"];
    NSDictionary *tempDict1 = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *tempDict2 = NULL;
    NSLog(@"Input books: %@", inputBooks);
    if ([inputBooks count] == 2) {
        path = [[NSBundle mainBundle] pathForResource:[inputBooks objectAtIndex:1] ofType:@".plist"];
        tempDict2 = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    self.stringsAndSubStrings = [self mergeDictionaries:tempDict1 and:tempDict2];
    NSLog(@"size: %d", [self.stringsAndSubStrings count]);
    NSString *seed = @"";
    int maxOccurences = 0;
    
    for (NSString *key in self.stringsAndSubStrings) {
        
        int currOccurences = [[self.stringsAndSubStrings objectForKey:key] count];
        if (currOccurences > maxOccurences) seed = key;
    }
    
    NSString *singlePoemBlock = [self extractPoemBlock:[self writeRandomText:seed]];
    return singlePoemBlock;
}

// Merges 2 dictionaries into 1
- (NSMutableDictionary *)mergeDictionaries:(NSDictionary *)dict1 and:(NSDictionary *)dict2 {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString *key in dict1) {
        NSMutableArray *currentFollowingWords = [dict1 objectForKey:key];
        if ([dict2 objectForKey:key]) {
            [currentFollowingWords arrayByAddingObjectsFromArray:[dict2 objectForKey:key]];
        }
        [result setObject:currentFollowingWords forKey:key];
    }
    for (NSString *key in dict2) {
        if (![dict1 objectForKey:key]) {
            [result setObject:[dict2 objectForKey:key] forKey:key];
        }
    }
    return result;
}


@end
