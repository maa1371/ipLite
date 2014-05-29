//
//  addNetworkViewController.h
//  ip Planner
//
//  Created by Amin on 5/13/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNetworkViewController :UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *networkName;
@property (weak, nonatomic) IBOutlet UITextField *clientNumber;
@property (weak, nonatomic) IBOutlet UITextField *serverNumber;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;




@end
