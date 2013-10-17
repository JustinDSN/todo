//
//  CustomCell.h
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellDelegate.h"

@interface CustomCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (weak, nonatomic) id<CustomCellDelegate> delegate;

@end
