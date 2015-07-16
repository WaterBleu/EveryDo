//
//  DetailViewController.m
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "DetailViewController.h"
#import "Todo.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *detailViewNav;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Todo *object = self.detailItem;
        self.detailDescriptionLabel.attributedText = object.todoDescription;
        self.detailViewNav.title = [NSString stringWithFormat:@"%@ - %@",[object priorityTypeEnumToString:object.priority] , object.title];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
