//
//  AddProjectViewController.m
//  ip Planner
//
//  Created by Amin on 5/15/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "AddProjectViewController.h"

@interface AddProjectViewController ()

@end

@implementation AddProjectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

///header of static group

-    (void) tableView : (UITableView*) tableView
willDisplayHeaderView : (UIView*) view
           forSection : (NSInteger) section {
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor whiteColor]];
//    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont fontWithName:@"System" size:72]];
    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont systemFontOfSize:22]];

}
////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    

    ///text field
    
    
    self.InputProjectName.layer.cornerRadius=8.0f;
    self.InputProjectName.layer.masksToBounds=YES;
    self.InputProjectName.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.InputProjectName.layer.borderWidth= 1.5f;
    self.InputProjectName.textColor=[UIColor whiteColor];
    
    
    
    //////////////////////////////
    
    ////////////////////
    
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    
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
