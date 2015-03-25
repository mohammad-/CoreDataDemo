//
//  DataManager.h
//  Demo1
//
//  Created by Mohammad Bharmal on 3/25/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface DataManager : NSObject
+(DataManager*)getManager;
-(BOOL)saveUser:(Model*)model;
-(NSArray*)fetchUserData;
-(void)deleteUser:(Model*)m;
@end
