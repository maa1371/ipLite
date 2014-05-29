//
//  ip.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "ip.h"

@implementation ip

@synthesize ip1,ip2,ip3,ip4,SubnetMask;

-(void)setIP:(NSNumber *)part1 next2:(NSNumber *)part2 next3:(NSNumber *)part3 next4:(NSNumber *)part4 subnet:(NSNumber *)subnet{

    ip1=part1;
    ip2=part2;
    ip3=part3;
    ip4=part4;
    SubnetMask=subnet;
    
}
-(void)setSub:(NSNumber *)sub{
    SubnetMask=sub;
}

@end
