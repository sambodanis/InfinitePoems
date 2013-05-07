//
//  productDescriptionViewController.m
//  WordMush
//
//  Created by Sam Bodanis on 07/05/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "productDescriptionViewController.h"

@interface productDescriptionViewController ()
@property (strong, nonatomic) IBOutlet UITextView *scrollableTextView;

@end

@implementation productDescriptionViewController

@synthesize mainText = _mainText;

- (void)setMainText:(NSString *)mainText {
    _mainText = mainText;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollableTextView.text = self.mainText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
