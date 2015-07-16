//
//  MasterViewController.m
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"
#import "CreateTodoViewController.h"

@interface MasterViewController () <TodoProtocol>

@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    NSAttributedString *d1 = [[NSAttributedString alloc] initWithString:@"in todo1"];
    NSAttributedString *d2 = [[NSAttributedString alloc] initWithString:@"in todo2"];
    NSAttributedString *d3 = [[NSAttributedString alloc] initWithString:@"in todo3"];
    
    Todo *todo1 = [[Todo alloc] initWithTitle:@"todo1" andDescription:d1 andPriority:Emergency andCompleteStatus:NO];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"todo2" andDescription:d2 andPriority:High andCompleteStatus:YES];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"todo3" andDescription:d3 andPriority:Misc andCompleteStatus:NO];
    
    [self initDatasource];
    [self insertToDoItem:todo1];
    [self insertToDoItem:todo2];
    [self insertToDoItem:todo3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"newTodo" sender:self];
}

//-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.objects[indexPath.section][indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    if ([[segue identifier] isEqualToString:@"newTodo"]) {
        CreateTodoViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *arr = self.objects[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Todo *object = self.objects[indexPath.section][indexPath.row];
    [cell setCell:object];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.objects[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Custom Function

- (void)initDatasource{
    self.objects = [[NSMutableArray alloc] initWithCapacity:2];
    self.objects[0] = [[NSMutableArray alloc] init];
    self.objects[1] = [[NSMutableArray alloc] init];
}

- (void)insertToDoItem:(Todo*)obj{
    if(obj.isComplete){
        [self.objects[0] insertObject:obj atIndex:0];
    }
    else
        [self.objects[1] insertObject:obj atIndex:0];
}

- (void)retrieveTodoItem:(Todo*) obj{
    [self insertToDoItem:obj];
    NSIndexPath *indexPath;
    if (obj.isComplete) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else
        indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
