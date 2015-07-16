//
//  Todo.m
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "Todo.h"

@interface Todo ()

@end

@implementation Todo

- (instancetype)initWithTitle:(NSString*)title andDescription:(NSAttributedString*)description andPriority:(Priority)priority andCompleteStatus:(BOOL)isComplete
{
    self = [super init];
    if (self) {
        self.title = title;
        self.todoDescription = description;
        self.priority = priority;
        self.isComplete = isComplete;
    }
    return self;
}

-(NSString*) priorityTypeEnumToString:(Priority)enumVal
{
    NSArray *imageTypeArray = [[NSArray alloc] initWithObjects:priorityTypeArray];
    return [imageTypeArray objectAtIndex:enumVal];
}

@end
