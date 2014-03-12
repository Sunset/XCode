//
//  Coder.h
//  Assignment1
//
//  Created by ahsia1 on 2/19/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Coder : NSObject <NSCoding>

@property(nonatomic,strong) NSDate *date;

-(id)initWithDate:(NSDate *)date;
@end