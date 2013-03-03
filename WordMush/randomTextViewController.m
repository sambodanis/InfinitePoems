//
//  randomTextViewController.m
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "randomTextViewController.h"
#import "randomiserModel.h"

@interface randomTextViewController ()
@property (strong, nonatomic) IBOutlet UITextView *randomTextView;
@property (strong, nonatomic) randomiserModel *bookRandomiser;
@end

@implementation randomTextViewController
@synthesize bookN = _bookN;
@synthesize specialSpacing = _specialSpacing;

- (void)setSpecialSpacing:(BOOL)specialSpacing {
    _specialSpacing = specialSpacing;
}


- (randomiserModel *)bookRandomiser {
    if (!_bookRandomiser) {
        _bookRandomiser = [[randomiserModel alloc] init];
    }
    return _bookRandomiser;
}

- (void)setBookN:(NSString *)bookN {
    _bookN = bookN;
}

- (NSString *)randomiseTextWithInputBook:(NSString *)book {
    NSString *result = book;
    
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.randomTextView.text = [self.bookRandomiser getRandomTextFromInput:self.bookN withSpecialSpacing:self.specialSpacing];
}

@end
