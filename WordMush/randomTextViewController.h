//
//  randomTextViewController.h
//  WordMush
//
//  Created by Sam Bodanis on 27/01/2013.
//  Copyright (c) 2013 Sam Bodanis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>


@interface randomTextViewController : UIViewController {
    SLComposeViewController *mySLComposerSheet;
}
@property (nonatomic, strong) NSString *bookN;
@property (nonatomic) BOOL specialSpacing;
@end
