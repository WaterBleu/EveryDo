//
//  CreateTodoViewController.h
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;
@protocol TodoProtocol <NSObject>

- (void)retrieveTodoItem:(Todo*) obj;

@end

@interface CreateTodoViewController : UIViewController

@property (nonatomic,strong) id<TodoProtocol> delegate;

@end
