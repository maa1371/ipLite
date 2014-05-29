//
//  ip.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ip : NSObject

@property (strong,nonatomic) NSNumber   *ip1,*ip2,*ip3,*ip4,*SubnetMask;
-(void)setSub:(NSNumber *)sub;

-(void) setIP: (NSNumber *) part1 next2:(NSNumber *) part2 next3:(NSNumber *) part3 next4:(NSNumber *) part4 subnet:(NSNumber *) subnet;


@end
