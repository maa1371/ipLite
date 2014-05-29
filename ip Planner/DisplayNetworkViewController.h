//
//  DisplayNetworkViewController.h
//  ip Planner
//
//  Created by Amin on 5/15/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Netwok.h"
@interface DisplayNetworkViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *NetworkName;
@property (weak, nonatomic) IBOutlet UITextField *clientNumber;
@property (weak, nonatomic) IBOutlet UITextField *serverNumber;

@property (strong,nonatomic) Netwok *currentNetwork;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
