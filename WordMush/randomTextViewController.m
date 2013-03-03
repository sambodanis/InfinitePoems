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
- (IBAction)postToFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:[@"Check out this great poem I made with WordMush\n" stringByAppendingString:self.randomTextView.text]];
        
        //        [mySLComposerSheet addImage:[UIImage imageNamed:@"action-location.png" ]];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
        
    }
    
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        
        NSString *output = [[NSString alloc] init];
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Post Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
                break;
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paperBackground"]]];
    UIColor *colour = [[UIColor alloc] initWithRed: 1.0 green: 0.0 blue: 0.0 alpha: 1.0];
    [[self view] setBackgroundColor:colour];

//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paperBackground.png"]];
    self.randomTextView.text = [self.bookRandomiser getRandomTextFromInput:self.bookN withSpecialSpacing:self.specialSpacing];
}

@end
