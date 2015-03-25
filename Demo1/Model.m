//
//  Model.m
//  Demo1
//
//  Created by Mohammad Bharmal on 3/25/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "Model.h"


@implementation Model
-(id)initWithManagedObject:(NSManagedObject*)model{
    if ([super init]) {
        self.firstName = [model valueForKey:first_name];
        self.lastName = [model valueForKey:last_name];
        obj = model;
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"%@ -- %@",self.firstName, self.lastName];
}
-(NSManagedObject*)getObj{
    return obj;
}
@end
