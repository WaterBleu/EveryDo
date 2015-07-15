//
//  Todo.h
//  EveryDo
//
//  Created by Jeff Huang on 2015-07-15.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

typedef NS_ENUM(NSInteger, Priority){
    Emergency,
    High,
    Medium,
    Low,
    Misc,
};

#define priorityTypeArray @"Emergency", @"High", @"Medium", @"Low", @"Misc", nil

@property (nonatomic) NSString* title;
@property (nonatomic) NSString* todoDescription;
@property (nonatomic) Priority priority;
@property (nonatomic) BOOL isComplete ;

- (instancetype)initWithTitle:(NSString*)title andDescription:(NSString*)description andPriority:(Priority)priority andCompleteStatus:(BOOL)isComplete;

-(NSString*) priorityTypeEnumToString:(Priority)enumVal;

@end
