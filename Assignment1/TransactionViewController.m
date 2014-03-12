//
//  TransactionViewController.m
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import "TransactionViewController.h"

//#define TRANSACTION_KEY @"A1743"
@interface TransactionViewController ()
@end

@implementation TransactionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
///
-(NSMutableArray *)transactions
{
    if (_transactions ==Nil)
    {
        _transactions= [[NSMutableArray alloc] init];
    }
    return _transactions;
}




/////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.transactionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    
    cell.textLabel.text = [self.model.transactionList objectAtIndex:indexPath.row];

    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    cell.imageView.image = [UIImage imageNamed:@"card-icon-spade.jpg"];
    return cell;
}
///////////

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //[self.model loadChecklistItems];
    [self.transactions addObject:[[Coder alloc] initWithDate:[NSDate date]]];
    [self.model saveChecklistItems];
     self.TextView.text = self.model.transactionList.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
