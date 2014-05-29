//
//  Netwok.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ip.h"
@interface Netwok : NSObject


@property (strong,nonatomic) NSString *NetworkName;
@property (strong,nonatomic) NSNumber *clients;
@property  (strong,nonatomic) NSNumber *Servers;
@property (strong,nonatomic) ip * eachNetworkIP;
@property (strong,nonatomic) NSNumber * NetworkID;
@property (strong,nonatomic) NSNumber * fromThisProjectID;



//-(void) ShowNetworkMap;

@end
