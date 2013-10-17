//
//  CustomCell.m
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate editTodoItemAtCell:self withText:textField.text];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.selectedTextRange = [textField textRangeFromPosition:[textField beginningOfDocument] toPosition:[textField endOfDocument]];
}

@end
