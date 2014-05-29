//
//  DisplayNetworkViewController.m
//  ip Planner
//
//  Created by Amin on 5/15/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "DisplayNetworkViewController.h"

@interface DisplayNetworkViewController () <UITextFieldDelegate>

@end

@implementation DisplayNetworkViewController

@synthesize NetworkName,currentNetwork,clientNumber,serverNumber,saveButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

///header of static group

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
    
    
    self.NetworkName.layer.cornerRadius=8.0f;
    self.clientNumber.layer.cornerRadius=8.0f;
    self.serverNumber.layer.cornerRadius=8.0f;
    
    self.NetworkName.layer.masksToBounds=YES;
    self.clientNumber.layer.masksToBounds=YES;
    self.serverNumber.layer.masksToBounds=YES;
    
    self.NetworkName.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.clientNumber.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.serverNumber.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    self.NetworkName.layer.borderWidth= 1.5f;
    self.clientNumber.layer.borderWidth= 1.5f;
    self.serverNumber.layer.borderWidth= 1.5f;
    
    self.NetworkName.textColor=[UIColor whiteColor];
    self.clientNumber.textColor=[UIColor whiteColor];
    self.serverNumber.textColor=[UIColor whiteColor];
    
    
    //////////////////////////////
    
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    

    
    
    self.NetworkName.text =[self.currentNetwork NetworkName];
    self.clientNumber.text =[[self.currentNetwork clients]stringValue];
    self.serverNumber.text =[[self.currentNetwork Servers]stringValue];
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
