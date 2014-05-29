//
//  addNetworkViewController.m
//  ip Planner
//
//  Created by Amin on 5/13/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "addNetworkViewController.h"

@interface addNetworkViewController () <UITextFieldDelegate>

@end


@implementation addNetworkViewController

@synthesize saveButton,networkName,clientNumber,serverNumber;

-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.delegate = self;
    int Enable=0;
    Enable = [[clientNumber text]intValue]+[[serverNumber text]intValue];
    
    if ( Enable==0  ) {
        saveButton.enabled=NO;
        
    }else
    {
        saveButton.enabled=YES;
        
    }
    
    [textField resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.delegate = self;
    int Enable=0;
    Enable = [[clientNumber text]intValue]+[[serverNumber text]intValue];
    
    if ( Enable==0  ) {
        saveButton.enabled=NO;
        
    }else
    {
        saveButton.enabled=YES;
        
    }
    
    [textField resignFirstResponder];
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//header of static group

-    (void) tableView : (UITableView*) tableView
willDisplayHeaderView : (UIView*) view
           forSection : (NSInteger) section {
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor whiteColor]];
    //    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont fontWithName:@"System" size:72]];
    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont systemFontOfSize:24]];
    
}
////////////////////////////



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///text field
    
    
    self.networkName.layer.cornerRadius=8.0f;
    self.clientNumber.layer.cornerRadius=8.0f;
    self.serverNumber.layer.cornerRadius=8.0f;
    
    self.networkName.layer.masksToBounds=YES;
    self.clientNumber.layer.masksToBounds=YES;
    self.serverNumber.layer.masksToBounds=YES;
    
    self.networkName.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.clientNumber.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.serverNumber.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.networkName.layer.borderWidth= 1.5f;
    self.clientNumber.layer.borderWidth= 1.5f;
    self.serverNumber.layer.borderWidth= 1.5f;
    
    self.networkName.textColor=[UIColor whiteColor];
    self.clientNumber.textColor=[UIColor whiteColor];
    self.serverNumber.textColor=[UIColor whiteColor];
    
    
    //////////////////////////////
    
    
    
    ///////////
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    
 ////////////////////
    
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    /////////
    
    
    saveButton.enabled=NO;
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
