//
//  Bank Account Model.m
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import "Bank Account Model.h"
#define TRANSACTION_KEY @"A1743"
#define BALANCE_KEY @"A1742"
#define RATE_KEY @"A1741"

@interface Bank_Account_Model ()

@end

@implementation Bank_Account_Model
-(id)init{

    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])
    {
        [self loadChecklistItems];
    }
    
    else
    {
        self.transactionList = [[NSMutableArray alloc] init];
        self.eRate = 1.0;
    }
    
    return self;
}

// lazy instantiator
-(NSMutableArray *)transactionList
{
    if (_transactionList == Nil) 
    {
        _transactionList = [[NSMutableArray alloc] init];
    }
    
    return _transactionList;
}
-(void)setRate:(double)rate
{
    self.eRate = rate;
}
-(double)getRate
{
    return self.eRate;
}
-(double)getBalance{
    return self.balance;
}

-(void) insertName:(NSString *)name
{
    // we declare as an NSArray publicly so that others don't modify our array
    // however we know that we actually have an NSMutableArray behind the scenes
    [self.transactionList addObject:name];
}

#pragma mark - Path information
- (NSString *)documentsDirectory
{
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"datesList.plist"];
    
}
#pragma mark - Saving and loading methods
- (void)loadChecklistItems
{
    // get our data file path
    NSString *path = [self dataFilePath];
    self.eRate = 1.0;
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // make an unarchiver, and point it to our data
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        // We would like to unarchive the "ChecklistItems" key and get a reference to it
        self.transactionList = [unarchiver decodeObjectForKey:TRANSACTION_KEY];
        self.balance = [unarchiver decodeDoubleForKey:BALANCE_KEY];
        self.eRate = [unarchiver decodeDoubleForKey:RATE_KEY];
        // we've finished choosing keys that we want, unpack them!
        [unarchiver finishDecoding];
    }
}
- (void)saveChecklistItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.transactionList forKey:TRANSACTION_KEY];
    [archiver encodeDouble:self.balance forKey:BALANCE_KEY];
    [archiver encodeDouble:self.eRate forKey:RATE_KEY];
    //archiver won't do an encode until we tell it "finishEncoding"
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

@end
