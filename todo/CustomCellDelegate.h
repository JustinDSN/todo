//
//  CustomCellDelegate.h
//  todo
//
//  Created by Justin Steffen on 10/16/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomCellDelegate <NSObject>

- (void)editTodoItemAtCell:(UITableViewCell *)tableCell withText:(NSString*)text;

@end
