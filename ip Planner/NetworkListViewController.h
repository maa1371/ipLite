//
//  NetworkListViewController.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Netwok.h"



@interface NetworkListViewController : UITableViewController


@property (strong,nonatomic) Project * currentProject;
@property (strong,nonatomic) NSMutableArray * projectList;

@property (nonatomic, strong) NSString *selectedNation;

-(void)DbAddNetwork:(Netwok *)item;;
-(void)DbDeleteNetwork:(int)index;
-(void)DbUpdateNetwork:(Netwok *)item;


@end
