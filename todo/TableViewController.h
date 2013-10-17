//
//  TableViewController.h
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDelegate, UITextFieldDelegate>

- (IBAction)onTap:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gestureRecognizer;

@end
