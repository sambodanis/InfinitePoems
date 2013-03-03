//
//  randomiserModel.h
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface randomiserModel : NSObject

//- (NSString *)getRandomTextFromInput:(NSString *)inputBook;
- (NSString *)getRandomTextFromInput:(NSString *)inputBook withSpecialSpacing:(BOOL)spacing;

@end
