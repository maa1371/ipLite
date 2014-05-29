//
//  customTabViewController.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "customTabViewController.h"
#import "Project.h"
#import "ipNavigationViewController.h"

@implementation customTabViewController

@synthesize ProjectList;

//ProjectList =[[NSMutableArray alloc]init];




-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //  if ([segue.identifier isEqualToString:@"NetworkDetail"]) {
    //    ipNavigationViewController *ipNC =[segue destinationViewController];
    //  ipNC.ProjectList=ProjectList;
    
    
    //}
    //    ipNavigationViewController *ipNC =[segue destinationViewController];
    //   ipNC.ProjectList=ProjectList;
    
    // NSLog(@"tedad dar asl %d",ProjectList.count);
    
    
    
}


@end
