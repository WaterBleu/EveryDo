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

@property (weak, nonatomic) IBOutlet UILabel *labelPriority;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIImageView *ivPriority;

@end

@implementation TodoTableViewCell

- (void)awakeFromNib {
    // Initialization code
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
    
    //Create strike through attributed text
    NSRange descriptionRange = NSMakeRange(0, object.todoDescription.length);
    NSMutableAttributedString *todoDescriptionStrikethrough = [[NSMutableAttributedString alloc] initWithString:object.todoDescription];
    [todoDescriptionStrikethrough addAttribute:NSStrikethroughStyleAttributeName value:@2 range:descriptionRange];

    //Set text depending on isComplete
    if(object.isComplete){
        self.labelDescription.attributedText = todoDescriptionStrikethrough;
    }
    else{
        self.labelDescription.text = object.todoDescription;
    }
}

@end
