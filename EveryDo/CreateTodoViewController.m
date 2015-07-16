//
//  CreateTodoViewController.m
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//


#import "CreateTodoViewController.h"
#import "Todo.h"

@interface CreateTodoViewController () <UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textFieldDescsription;
@property (nonatomic) IBOutlet UIPickerView *pickerPriority;
@property (nonatomic) Priority priority;

@property (nonatomic) NSArray* priorityArr;

@end

@implementation CreateTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.priorityArr = [[NSArray alloc] initWithObjects:priorityTypeArray];
    self.pickerPriority.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.priorityArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
        case 0:
            self.priority = Emergency;
            break;
        case 1:
            self.priority = High;
            break;
        case 2:
            self.priority = Medium;
            break;
        case 3:
            self.priority = Low;
            break;
        case 4:
            self.priority = Misc;
            break;
    }
}

- (IBAction)sumbitTodo:(UIButton *)sender {
    Todo *newTodo = [[Todo alloc] initWithTitle:self.textFieldTitle.text andDescription:self.textFieldDescsription.attributedText andPriority:self.priority andCompleteStatus:NO];

    [self.delegate retrieveTodoItem:newTodo];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}





@end
