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
@property (strong, nonatomic) IBOutlet UIButton *leftPoemButton;
@property (strong, nonatomic) IBOutlet UIButton *rightPoemButton;

@property (nonatomic, strong) bookDatabase *allBooks;

@property (nonatomic, strong) NSArray *listOfAuthors;

@property (strong, nonatomic) IBOutlet UIButton *CreatePoemButton;

@property (nonatomic, strong) NSString *selectedAuthorOne;
@property (nonatomic, strong) NSString *selectedAuthorTwo;

@end

@implementation wordMushViewController

@synthesize book = _book;
@synthesize allBooks = _allBooks;
@synthesize bookListPicker = _bookListPicker;
@synthesize listOfAuthors = _listOfAuthors;
@synthesize selectedAuthorOne = _selectedAuthorOne;
@synthesize selectedAuthorTwo = _selectedAuthorTwo;


- (NSArray *)listOfAuthors {
    if (!_listOfAuthors) {
        _listOfAuthors = [self.allBooks getAuthorList];
//        _listOfAuthors = [[NSArray alloc] init];
    }
    return _listOfAuthors;
}

- (NSString *)selectedAuthorTwo {
    if (!_selectedAuthorTwo) {
        _selectedAuthorTwo = [[NSString alloc] init];
    }
    return _selectedAuthorTwo;
}

- (NSString *)selectedAuthorOne {
    if (!_selectedAuthorOne) {
        _selectedAuthorOne = [[NSString alloc] init];
    }
    return _selectedAuthorOne;
}

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
        BOOL specialSpacing = [self.selectedAuthorOne isEqualToString:@"Robert Frost"] || [self.selectedAuthorTwo isEqualToString:@"Robert Frost"];
        [segue.destinationViewController setBookN:self.book];
        [segue.destinationViewController setSpecialSpacing:specialSpacing];
        [segue.destinationViewController setBookList:[NSArray arrayWithObjects:self.selectedAuthorOne, self.selectedAuthorTwo, nil]];
    } else if ([segue.identifier isEqualToString:@"leftSegue"]) {
        BOOL specialSpacing = [self.selectedAuthorOne isEqualToString:@"Robert Frost"];
        [segue.destinationViewController setBookN:self.book];
        [segue.destinationViewController setSpecialSpacing:specialSpacing];
        [segue.destinationViewController setBookList:[NSArray arrayWithObjects:self.selectedAuthorOne, nil]];
    } else if ([segue.identifier isEqualToString:@"rightSegue"]) {
        BOOL specialSpacing = [self.selectedAuthorTwo isEqualToString:@"Robert Frost"];
        [segue.destinationViewController setBookN:self.book];
        [segue.destinationViewController setSpecialSpacing:specialSpacing];
        [segue.destinationViewController setBookList:[NSArray arrayWithObjects:self.selectedAuthorTwo, nil]];
    }
}

- (IBAction)CreatePoemFromAuthor:(UIButton *)sender {
    
//    self.book = [self.allBooks getBook:self.selectedAuthorOne];
//    self.book = [self.book stringByAppendingString:[self.allBooks getBook:self.selectedAuthorTwo]];
}

- (IBAction)createPoemFromLeftAuthor:(UIButton *)sender {
    self.book = [self.allBooks getBook:self.selectedAuthorOne];
}

- (IBAction)createPoemFromRightAuthor:(UIButton *)sender {
    self.book = [self.allBooks getBook:self.selectedAuthorTwo];
}

#pragma pickerViewMethods
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.listOfAuthors count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.listOfAuthors objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedAuthorOne = [self.listOfAuthors objectAtIndex:row];
        [self.leftPoemButton setTitle:self.selectedAuthorOne forState:UIControlStateNormal];
        [pickerView selectRow:row inComponent:0 animated:YES];
    } else if (component == 1) {
        self.selectedAuthorTwo = [self.listOfAuthors objectAtIndex:row];        
        [self.rightPoemButton setTitle:self.selectedAuthorTwo forState:UIControlStateNormal];
        [pickerView selectRow:row inComponent:1 animated:YES];
    }
    [self.CreatePoemButton setTitle:[self.selectedAuthorOne stringByAppendingFormat:@" + %@", self.selectedAuthorTwo] forState:UIControlStateNormal];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.listOfAuthors = [self.allBooks getAuthorList];
    self.bookListPicker = [[UIPickerView alloc] init];
    self.bookListPicker.delegate = self;
    self.bookListPicker.dataSource = self;
    self.selectedAuthorOne = [self.listOfAuthors objectAtIndex:0];
    self.selectedAuthorTwo = [self.listOfAuthors objectAtIndex:0];
    [self.CreatePoemButton setTitle:self.selectedAuthorOne forState:UIControlStateNormal];
    [self.leftPoemButton setTitle:self.selectedAuthorOne forState:UIControlStateNormal];
    [self.rightPoemButton setTitle:self.selectedAuthorTwo forState:UIControlStateNormal];
    [self.CreatePoemButton setTitle:[self.selectedAuthorOne stringByAppendingFormat:@" + %@", self.selectedAuthorTwo] forState:UIControlStateNormal];
    
}


@end
