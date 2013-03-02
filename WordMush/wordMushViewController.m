//
//  wordMushViewController.m
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import "wordMushViewController.h"
#import "bookDatabase.h"

@interface wordMushViewController() 

@property (nonatomic, strong) NSString *book;
@property (strong, nonatomic) IBOutlet UIPickerView *bookListPicker;
@property (nonatomic, strong) bookDatabase *allBooks;
@property (nonatomic, strong) NSArray *listOfAuthors;
@end

@implementation wordMushViewController
@synthesize book = _book;
@synthesize allBooks = _allBooks;
@synthesize bookListPicker = _bookListPicker;
@synthesize listOfAuthors = _listOfAuthors;

- (NSArray *)listOfAuthors {
    if (!_listOfAuthors) {
        _listOfAuthors = [self.allBooks getAuthorList];
    }
    return _listOfAuthors;
}

//- (UIPickerView *)bookListPicker {
//    if (!_bookListPicker) {
//        _bookListPicker = [[UIPickerView alloc] init];
//    }
//    return _bookListPicker;
//}

- (bookDatabase *)allBooks {
    if (!_allBooks) {
        _allBooks = [[bookDatabase alloc] init];
    }
    return _allBooks;
}

- (void)setBook:(NSString *)book {
    _book = book;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"bdrSegue"]) {
        [segue.destinationViewController setBookN:self.book];
    }
}

- (IBAction)testCoreData {
    NSArray *authors = [self.allBooks getAuthorList];
//    NSLog(@"%@", [authors objectAtIndex:0]);
    for (NSString *author in authors) {
//        NSLog(@"t %@", author);
    }
    NSLog(@"%@", [self.allBooks getBook:authors[0]]);
    NSData *ascii = [NSData dataWithContentsOfFile:[self.allBooks getBook:authors[0]]];
    self.book = [[NSString alloc] initWithData:ascii encoding:NSASCIIStringEncoding];
    NSLog(@"%@", self.book);
}

- (IBAction)tomSawyer:(UIButton *)sender {
    NSData *ascii = [NSData dataWithContentsOfFile:@"/Users/sambodanis/Dropbox/WordMush/WordMush/Hamlet.txt"];
    self.book = [[NSString alloc] initWithData:ascii encoding:NSASCIIStringEncoding];
    NSLog(@"%@", self.book);
    [self performSegueWithIdentifier:@"bdrSegue" sender:self];
}

#pragma pickerViewMethods
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.allBooks getAuthorList] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.listOfAuthors objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView selectRow:row inComponent:0 animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.bookListPicker = [[UIPickerView alloc] init];
    self.bookListPicker.delegate = self;
    self.bookListPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
