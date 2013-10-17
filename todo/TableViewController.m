//
//  TableViewController.m
//  todo
//
//  Created by Justin Steffen on 10/15/13.
//  Copyright (c) 2013 Justin Steffen. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"

@interface TableViewController ()
    @property (nonatomic, strong) NSMutableArray *todos;
@end

@implementation TableViewController

@synthesize todos;

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
    self.todos = [[NSMutableArray alloc] init];
}

-(void) addItem {
    [self.todos addObject:@""];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (IBAction)onTap:(id)sender
{
    NSLog(@"onTap called");
    [self.view endEditing:YES];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    if(editing) {
        self.gestureRecognizer.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else {
        self.gestureRecognizer.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textField.text = [self.todos objectAtIndex:[indexPath row]];
    cell.textField.delegate = self;
    [cell.textField becomeFirstResponder];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleting item at position %i", [indexPath row]);
        [self.todos removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"todos.count %i", self.todos.count);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"Before moving: %@", self.todos);
    id item = [self.todos objectAtIndex: [fromIndexPath row]];
    [self.todos removeObjectAtIndex: [fromIndexPath row]];
    [self.todos insertObject:item atIndex: [toIndexPath row]];
    NSLog(@"After moving: %@", self.todos);
}

- (void)editTodoItemAtCell:(UITableViewCell *)tableCell withText:(NSString*)text
{
    NSLog(@"Editing cell %i withText %@", [[self.tableView indexPathForCell:tableCell ] row], text);
    NSLog(@"Before editing: %@", self.todos);
    NSIndexPath *idxPath = [self.tableView indexPathForCell:tableCell];
    int index = [idxPath indexAtPosition:[idxPath length] - 1];
    [self.todos setObject:text atIndexedSubscript:index];
    NSLog(@"After editing: %@", self.todos);
}

#pragma mark - UITextFieldDelegate methods
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    UITableViewCell * tableCell = (UITableViewCell *) textField.superview;
    NSLog(@"Editing cell %i withText %@", [[self.tableView indexPathForCell:tableCell ] row], textField.text);
    NSLog(@"Before editing: %@", self.todos);
    NSIndexPath *idxPath = [self.tableView indexPathForCell:tableCell];
    int index = [idxPath indexAtPosition:[idxPath length] - 1];
    [self.todos setObject:textField.text atIndexedSubscript:index];
    NSLog(@"After editing: %@", self.todos);
}
@end
