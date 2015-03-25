//
//  ViewController.m
//  Demo1
//
//  Created by Parth Dobariya on 05/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "Model.h"
static NSString *ide = @"user";

@interface ViewController ()
@property(nonatomic,retain)NSArray *data;
@end

@implementation ViewController

@synthesize save,cancel,firstName,lastName,fetch;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:ide];
    self.table.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

-(IBAction)btnSavePressed:(id)sender
{
    Model *m = [[Model alloc] init];
    m.firstName = self.firstName.text;
    m.lastName = self.lastName.text;
    if ([[DataManager getManager] saveUser:m]) {
        self.firstName.text = @"";
        self.lastName.text = @"";
        [self btnFetchPressed:nil];        
    }

}

-(IBAction)btnCancelPressed:(id)sender{
    self.lastName.text=@"";
    self.firstName.text=@"";
}


-(IBAction)btnFetchPressed:(id)sender{
    self.data = [[DataManager getManager] fetchUserData];
    [self.table reloadData];
}

-(IBAction)delete:(id)sender{
    [[DataManager getManager] deleteUser:[self.data firstObject]];
    [self btnFetchPressed:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ide];
    Model *m = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = m.firstName;
    cell.detailTextLabel.text = m.lastName;
    return cell;
}
@end
