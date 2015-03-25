//
//  ViewController.h
//  Demo1
//
//  Created by Parth Dobariya on 05/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource>
{

}

@property (nonatomic, weak) IBOutlet UITextField *firstName;
@property (nonatomic, weak) IBOutlet UITextField *lastName;

@property (nonatomic, weak) IBOutlet UIButton *save;
@property (nonatomic, weak) IBOutlet UIButton *cancel;
@property (nonatomic, weak) IBOutlet UIButton *fetch;
@property (nonatomic, weak) IBOutlet UIButton *delete;


@property (nonatomic, weak) IBOutlet UITableView *table;
@end

