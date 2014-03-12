//
//  Coder.m
//  Assignment1
//
//  Created by ahsia1 on 2/19/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import "Coder.h"

#define DATE_KEY @"date"

@implementation Coder

-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSDate *theDate =[aDecoder decodeObjectForKey:DATE_KEY];
    return [self initWithDate:theDate];
}

-(id)init
{
    return [self initWithDate:[NSDate date]];
}

-(id)initWithDate:(NSDate *)date
{
    if(self = [super init])
    {
        self.date = date;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.date forKey:DATE_KEY];
    
}

-(NSString *)description
{
    //look into NSDateFormatter if you want to change the way in which things are printed
    return [self.date description];
}

@end