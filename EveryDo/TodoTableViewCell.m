//
//  TodoTableViewCell.m
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "TodoTableViewCell.h"
#import "Todo.h"

@interface TodoTableViewCell ()

@property (nonatomic) Todo* currentTodo;
@property (weak, nonatomic) IBOutlet UILabel *labelPriority;
@property (nonatomic) Priority priority;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (nonatomic) BOOL isComplete;

@property (nonatomic) UISwipeGestureRecognizer *swipeGesture;

@end

@implementation TodoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(completeTodo:)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(Todo*)object{
    self.labelPriority.layer.cornerRadius = 10;
    self.labelPriority.layer.masksToBounds = YES;
    
    switch (object.priority) {
        case Emergency:
            self.labelPriority.backgroundColor = [UIColor redColor];
            break;
        case High:
            self.labelPriority.backgroundColor = [UIColor orangeColor];
            break;
        case Medium:
            self.labelPriority.backgroundColor = [UIColor yellowColor];
            break;
        case Low:
            self.labelPriority.backgroundColor = [UIColor greenColor];
            break;
        case Misc:
            self.labelPriority.backgroundColor = [UIColor grayColor];
            break;
        default:
            break;
    }
    
    self.labelTitle.text = object.title;
    self.isComplete = object.isComplete;
    self.priority = object.priority;
    
    //Create strike through attributed text
    NSRange descriptionRange = NSMakeRange(0, object.todoDescription.length);
    NSMutableAttributedString *todoDescriptionStrikethrough = [object.todoDescription mutableCopy];
    [todoDescriptionStrikethrough addAttribute:NSStrikethroughStyleAttributeName value:@2 range:descriptionRange];

    //Set text depending on isComplete
    if(self.isComplete){
        self.labelDescription.attributedText = todoDescriptionStrikethrough;
    }
    else{
        self.labelDescription.attributedText = object.todoDescription;
    }
    [self.contentView addGestureRecognizer:self.swipeGesture];
}

- (void)completeTodo:(id)sender{
    UISwipeGestureRecognizer *swipeGuesture = (UISwipeGestureRecognizer*)sender;
    self.currentTodo = [[Todo alloc] initWithTitle:self.labelTitle.text andDescription:self.labelDescription.attributedText  andPriority:self.priority andCompleteStatus:self.isComplete];
    if (swipeGuesture.state == UIGestureRecognizerStateEnded) {
        self.isComplete = YES;
        
        NSRange descriptionRange = NSMakeRange(0, self.labelDescription.attributedText.length);
        NSMutableAttributedString *todoDescriptionStrikethrough = [self.labelDescription.attributedText mutableCopy];
        [todoDescriptionStrikethrough addAttribute:NSStrikethroughStyleAttributeName value:@2 range:descriptionRange];
        self.labelDescription.attributedText = todoDescriptionStrikethrough;
    }
}


@end
