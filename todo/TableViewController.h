//
//  TableViewController.h
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellDelegate.h"


@interface TableViewController : UITableViewController <CustomCellDelegate>

- (IBAction)onTap:(id)sender;

@end
