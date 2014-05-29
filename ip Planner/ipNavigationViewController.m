//
//  ipNavigationViewController.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "ipNavigationViewController.h"
#import "ipViewController.h"
#import "Project.h" 

@interface ipNavigationViewController () <UINavigationBarDelegate>

@end

@implementation ipNavigationViewController
@synthesize ProjectList;




-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

        ipViewController   *ipVC =[segue destinationViewController];
        ipVC.ProjectList=ProjectList;
        
    NSLog(@"Send Data from ip navigation controller into ipview controller %lu",(unsigned long)ProjectList.count);
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
     
     
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
