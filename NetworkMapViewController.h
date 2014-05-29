//
//  NetworkMapViewController.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface NetworkMapViewController : UITableViewController

@property (nonatomic,strong) Project *currentProject;
@property (nonatomic,strong) NSMutableArray * IPaval;
- (IBAction)exitAction:(id)sender;

@end
