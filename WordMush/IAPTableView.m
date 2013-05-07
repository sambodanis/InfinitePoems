#import "IAPTableView.h"
#import "wordMushIAPHelper.h"
#import <StoreKit/StoreKit.h>


@interface IAPTableView () {
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
}
@end

@implementation IAPTableView


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"productDescriptionSegue"]) {
        SKProduct * product = (SKProduct *) _products[        self.tableView.indexPathForSelectedRow
.row];
        NSString *noteAboutRestarting = @"Note, for this download to take effect you must restart the app after the purchase is made.";
        NSString *description = NULL;
        if ([[product localizedTitle] isEqualToString:@"Shakespeare - Tragedies"]) {
            description = [NSString stringWithFormat:@"Contains:\n\nRomeo and Juliet\nCoriolanus\nTitus Andronicus\nJulius Caesar\nMacbeth \nHamlet\nKing Lear\nOthello"];
        } else if ([[product localizedTitle] isEqualToString:@"Shakespeare - Comedies"]) {
            description = [NSString stringWithFormat:@"Contains:\n\nAll's Well That Ends Well\nThe Comedy of Errors\nA Midsummer Night's Dream\nMuch Ado About Nothing\nThe Taming of the Shrew\nThe Tempest\nTwelfth Night\nThe Winter's Tale"];
        } else if ([[product localizedTitle] isEqualToString:@"More Poets"]) {
            description = [NSString stringWithFormat:@"Contains:\n\nLewis Carroll\nWilliam Blake\nRudyard Kipling\nJohn Keats\nElizabeth Browning\nWadsworth\nPhillis Wheatley\nMatthew Arnold"];
        }
        description = [description stringByAppendingFormat:@"\n\n%@", noteAboutRestarting];
        NSLog(@"Description: %@", description);
        [segue.destinationViewController setMainText:description];
//        [segue.destinationViewController setMainText:@"Test"];
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"More Poems";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];

}

- (void)restoreTapped:(id)sender {
    [[wordMushIAPHelper sharedInstance] restoreCompletedTransactions];
}

// 4
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[wordMushIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];

    cell.textLabel.text = product.localizedTitle;
    [_priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    if ([[wordMushIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else {
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
    }

    return cell;
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[wordMushIAPHelper sharedInstance] buyProduct:product];
    
}


@end
