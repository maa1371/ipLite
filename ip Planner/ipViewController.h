//
//  ipViewViewController.h
//  ip Planner
//
//  Created by Amin on 5/15/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Project.h"

@interface ipViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property NSMutableArray * ProjectList;
@property Project * currentProject;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *MapButton;
@property (weak, nonatomic) IBOutlet UIButton *MapButton;

-(NSNumber *)clientCount:(Project *)iProject;
-(void)UpdateIP:(NSMutableArray *)IP;
-(NSMutableArray *)loadIP;
@end
