//
//  ProjectList.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/25/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Netwok.h"
#import "ip.h"

@interface Project : NSObject

@property (strong,nonatomic) NSString  * ProjectName;
@property (strong,nonatomic) NSMutableArray * NetworkList ;
@property (strong,nonatomic) ip * NetworkIp;
@property (strong,nonatomic) NSNumber *projectID;






@end
