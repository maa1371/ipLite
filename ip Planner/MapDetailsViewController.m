//
//  MapDetailsViewController.m
//  ip Planner
//
//  Created by Amin on 5/20/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "MapDetailsViewController.h"

@interface MapDetailsViewController ()

@end

@implementation MapDetailsViewController

///header of static group

-    (void) tableView : (UITableView*) tableView
willDisplayHeaderView : (UIView*) view
           forSection : (NSInteger) section {
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor whiteColor]];
    //    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont fontWithName:@"System" size:72]];
    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont systemFontOfSize:20]];
    
}
////////////////////////////


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //////////////////////////////
    
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    

  //////////////
    
    [[self clientNumber]setText:[self NSclientNumber]];
    [[self serverNumber]setText:[self NSserverNumber]];
    
    [[self broadCastIP]setText:[self NSbroadCastIP]];
    [[self NetworkIP]setText:[self NSNetworkIP]];
    
    [[self clientIPFrom]setText:[self NSclientIPFrom]];
    [[self clientIPTo]setText:[self NSclientIPTo]];
    
    [[self serverIPFrom]setText:[self NSserverIPFrom]];
    [[self serverIPto]setText:[self NSserverIPto]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
