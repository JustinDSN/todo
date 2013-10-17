//
//  TableViewController.m
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"

@interface TableViewController () {
    NSMutableArray *todos;
}
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTodoItems];
    
    UINib *customNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib: customNib forCellReuseIdentifier:@"CustomCell"];
 
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
}

-(void) loadTodoItems {
    todos = [NSMutableArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", nil];
}

-(void) addItem {
    [todos addObject:@"New Item"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textField.text = [todos objectAtIndex:[indexPath row]];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleting item at position %i", [indexPath row]);
        [todos removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"todos.count %i", todos.count);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"Before moving: %@", todos);
    id item = [todos objectAtIndex: [fromIndexPath row]];
    [todos removeObjectAtIndex: [fromIndexPath row]];
    [todos insertObject:item atIndex: [toIndexPath row]];
    NSLog(@"After moving: %@", todos);
}

- (void)editTodoItemAtCell:(UITableViewCell *)tableCell withText:(NSString*)text
{
    NSIndexPath *idxPath = [self.tableView indexPathForCell:tableCell];
    int index = [idxPath indexAtPosition:[idxPath length] - 1];
    [todos setObject:text atIndexedSubscript:index];
}

- (IBAction)onTap:(id)sender
{
    NSLog(@"onTap called");
    [self.view endEditing:YES];
}
@end
