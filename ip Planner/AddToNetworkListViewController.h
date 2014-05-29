//
//  AddToNetworkListViewController.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToNetworkListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *networkName;
@property (weak, nonatomic) IBOutlet UITextField *clientNumber;
@property (weak, nonatomic) IBOutlet UITextField *serverNumber;
- (IBAction)saveNewNetwork:(id)sender;

@end
