//
//  Bank Account Model.h
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bank_Account_Model : NSObject
@property (nonatomic) double balance;
@property (nonatomic) double eRate;
@property (strong,nonatomic) NSMutableArray *transactionList;
-(void) insertName:(NSString *)name;
-(void)loadChecklistItems;
-(void)saveChecklistItems;
-(void)setRate:(double)rate;
-(double)getRate;
@end
