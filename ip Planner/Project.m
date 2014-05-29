//
//  ProjectList.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/25/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "Project.h"

@implementation Project
@synthesize ProjectName,NetworkList,NetworkIp  ;

- (id)init
{
    self = [super init];
    if (self) {
        NetworkList=[[NSMutableArray alloc]init];
        NetworkIp=[[ip alloc]init];
    }
    return self;
}

@end
