//
//  wordMushViewController.m
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "wordMushViewController.h"
#import "bookDatabase.h"

@interface wordMushViewController ()
@property (nonatomic, strong) NSString *book;
@property (nonatomic, strong) bookDatabase *allBooks;
@end

@implementation wordMushViewController
@synthesize book = _book;
@synthesize allBooks = _allBooks;

- (void)setBook:(NSString *)book {
    _book = book;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"bdrSegue"]) {
        [segue.destinationViewController setBookN:self.book];
    }
}
- (IBAction)testCoreData {
    NSLog(@"Testing Core Data %@", self.allBooks.runTests);
}

- (IBAction)tomSawyer:(UIButton *)sender {
    NSData *ascii = [NSData dataWithContentsOfFile:@"/Users/sambodanis/Dropbox/WordMush/WordMush/Hamlet.txt"];
    NSString *temp = [[NSString alloc] initWithData:ascii encoding:NSASCIIStringEncoding];
    self.book = temp;
//    NSLog(@"%@", self.book);
    [self performSegueWithIdentifier:@"bdrSegue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
