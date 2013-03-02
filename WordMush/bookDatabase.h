//
//  bookDatabase.h
//  WordMush
//
//  Created by Sam Bodanis on 02/03/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookDatabase : NSObject

- (NSString *)runTests;

+ (NSArray *)getAuthorList;
+ (NSString *)getBook:(NSString *)forAuthor;

@end
