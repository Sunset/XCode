//
//  TransactionViewController.h
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank Account Model.h"
#import "Coder.h"
@interface TransactionViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextView *TextView;
@property (strong, nonatomic) Bank_Account_Model *model;

@property (nonatomic,strong) NSMutableArray *transactions;

@end
