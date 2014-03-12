//
//  ViewController.h
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank Account Model.h"
#import "TransactionViewController.h"
#import <Parse/Parse.h>
#import "crittercism.h"

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong,nonatomic) Bank_Account_Model *BAM;
@property (strong,nonatomic) IBOutlet UITextField *amount;
@property (nonatomic) int convert_count;
@property (weak, nonatomic) IBOutlet UILabel *BalanceLabel;
- (IBAction)deposit:(id)sender;
- (IBAction)withdraw:(id)sender;

-(IBAction)Convert:(id)sender;

@property (nonatomic,strong) NSMutableDictionary *recipes;
@property (weak, nonatomic) IBOutlet UIPickerView *Picker;
@property (weak, nonatomic) IBOutlet UILabel *CountryLabel;

@property (nonatomic, strong) NSMutableArray *countrylist;
@property(nonatomic,strong) NSArray *keys;
@property (nonatomic) double exchangeRates;
@end
