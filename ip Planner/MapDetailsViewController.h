//
//  MapDetailsViewController.h
//  ip Planner
//
//  Created by Amin on 5/20/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Netwok.h"

@interface MapDetailsViewController : UITableViewController

@property (nonatomic,strong) Netwok *currentNetwork;
@property (nonatomic,strong) NSMutableArray * IPaval;

@property (weak, nonatomic) IBOutlet UILabel *clientNumber;
@property (weak, nonatomic) IBOutlet UILabel *serverNumber;
@property (weak, nonatomic) IBOutlet UILabel *broadCastIP;
@property (weak, nonatomic) IBOutlet UILabel *NetworkIP;
@property (weak, nonatomic) IBOutlet UILabel *clientIPFrom;
@property (weak, nonatomic) IBOutlet UILabel *clientIPTo;
@property (weak, nonatomic) IBOutlet UILabel *serverIPFrom;
@property (weak, nonatomic) IBOutlet UILabel *serverIPto;

@property (strong, nonatomic) NSString  *NSclientNumber;
@property (strong, nonatomic) NSString  *NSserverNumber;
@property (strong, nonatomic) NSString  *NSbroadCastIP;
@property (strong, nonatomic) NSString  *NSNetworkIP;
@property (strong, nonatomic) NSString  *NSclientIPFrom;
@property (strong, nonatomic) NSString  *NSclientIPTo;
@property (strong, nonatomic) NSString  *NSserverIPFrom;
@property (strong, nonatomic) NSString  *NSserverIPto;







@end
