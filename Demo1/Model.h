//
//  Model.h
//  Demo1
//
//  Created by Mohammad Bharmal on 3/25/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <Foundation/Foundation.h>
#define first_name @"first_name"
#define last_name @"last_name"

@import CoreData;

@interface Model : NSObject{
    NSManagedObject *obj;
}
@property(nonatomic,strong)NSString *firstName;
@property(nonatomic,strong)NSString *lastName;
-(id)initWithManagedObject:(NSManagedObject*)model;
-(NSManagedObject*)getObj;
@end
