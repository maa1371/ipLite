//
//  ipViewViewController.m
//  ip Planner
//
//  Created by Amin on 5/15/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "ipViewController.h"
#import "Project.h"
#import "NetworkMapViewController.h"
#import "mapNavViewController.h"
#import "MapDetailsViewController.h"
#import "mapNavigationViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ipViewController ()

@end

@implementation ipViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize ProjectList ,currentProject;

NSMutableArray *binarryIP;
int ip1,ip2,ip3,ip4,subnet1,subnet2,subnet3,subnet4,subnet;
NSMutableArray *ipAval;
NSArray *fetchedObjects;
NSManagedObject *selectedObject;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"NetworkMap"]) {
        //   mapNavViewController *MNVC=[segue destinationViewController];
        //  NetworkMapViewController *NMVC=[MNVC.viewControllers objectAtIndex:0];
        mapNavigationViewController  *mapnav=[segue destinationViewController];
        
        NetworkMapViewController *NMVC=[[mapnav viewControllers]objectAtIndex:0];
        
        NMVC.currentProject=currentProject;
        NSNumber *ip11=[NSNumber numberWithInt:ip1];
        NSNumber *ip22=[NSNumber numberWithInt:ip2];
        NSNumber *ip33=[NSNumber numberWithInt:ip3];
        NSNumber *ip44=[NSNumber numberWithInt:ip4];
        NSNumber *subnet55=[NSNumber numberWithInt:subnet];
        
        ipAval=[[NSMutableArray alloc]initWithObjects:ip11,ip22,ip33,ip44,subnet55 ,nil];
        
        NMVC.IPaval=ipAval;
      
        NSMutableArray *iIP=[[NSMutableArray alloc]initWithObjects:
                             [[currentProject NetworkIp]ip1],
                             [[currentProject NetworkIp]ip2],
                             [[currentProject NetworkIp]ip3],
                             [[currentProject NetworkIp]ip4],
                             [[currentProject NetworkIp]SubnetMask]
                             , nil];
        
        [self UpdateIP:iIP];
        
        
      //  NSLog(@"here %d,%d,%d,%d",[ip11 intValue],[ip22 intValue],[ip33 intValue],[ip44 intValue]);
        
    }
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 5;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    
    if (component==4) {
        return 33;
        
    }
    return 256;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    NSNumber *number =[NSNumber numberWithInt:(int)row];
    NSString *item=[number stringValue];
    return item;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
    
    switch (component) {
        case 0:
            [[currentProject NetworkIp]setIp1:[NSNumber numberWithInt:(int)row]];
            break;
        case 1:
            [[currentProject NetworkIp]setIp2:[NSNumber numberWithInt:(int)row]];
            break;
        case 2:
            [[currentProject NetworkIp]setIp3:[NSNumber numberWithInt:(int)row]];
            break;
        case 3:
            [[currentProject NetworkIp]setIp4:[NSNumber numberWithInt:(int)row]];
            break;
        case 4:
            [[currentProject NetworkIp]setSubnetMask:[NSNumber numberWithInt:(int)row]];
            break;
            
    }
    
    
    subnet=[[[currentProject NetworkIp] SubnetMask]intValue];
    
    

    
    if (subnet<=32 && 24<subnet) {
        NSLog(@"it is there");
        subnet1=256-[self power:2 to:(1*(32-subnet))];
        subnet2=255;
        subnet3=255;
        subnet4=255;
    }else if (subnet<=24 && 16<subnet){
        subnet1=0;
        subnet2=256-[self power:2 to:(1*(24-subnet))];
        subnet3=255;
        subnet4=255;
    }else if (subnet<=16 && 8<subnet){
        subnet1=0;
        subnet2=0;
        subnet3=256-[self power:2 to:(1*(16-subnet))];
        subnet4=255;
    }else if (subnet<=8 && 0<subnet){
        subnet1=0;
        subnet2=0;
        subnet3=0;
        subnet4=256-[self power:2 to:(8-subnet)];
    }
    else {
        subnet1=0;
        subnet2=0;
        subnet3=0;
        subnet4=0;
        
    }
    ip1=[[[currentProject NetworkIp] ip1]intValue];
    ip2=[[[currentProject NetworkIp] ip2]intValue];
    ip3=[[[currentProject NetworkIp] ip3]intValue];
    ip4=[[[currentProject NetworkIp] ip4]intValue];
    
    ip1=ip1 & subnet4;
    ip2=ip2 & subnet3;
    ip3=ip3 & subnet2;
    ip4=ip4 & subnet1;
    
    
    NSNumber *clientCounter=[self clientCount:currentProject];
 
    int ipNumber = [self power:2 to:(32-subnet)];
    
    if( [clientCounter intValue] <= ipNumber)
    {
        self.MapButton.enabled = YES;
        self.MapButton.tintColor=[UIColor grayColor];
        
    }else
    {
        self.MapButton.enabled = NO;
        self.MapButton.tintColor=[UIColor whiteColor];

        
    }
    
    NSLog(@"client number::%d",[clientCounter intValue]);
    NSLog(@"ip number::%d",ipNumber);
    NSLog(@"ip aval shabake:: %d/%d/%d/%d",ip1,ip2,ip3,ip4);
    NSLog(@"subnet:: %d/%d/%d/%d",subnet4,subnet3,subnet2,subnet1);
    
    
}

-(int)power:(int)item1 to:(int)item2{
    int value=1;
    for (int index=0; index<item2; index++) {
        value=value*item1;
    }
    return value;
}


-(NSNumber *)clientCount:(Project *)iProject{
    int indexPath=(int)[[iProject NetworkList]count];
    int convertor=0;
    int counter=0;
    for (int i=0; i<indexPath; i++) {
        
        convertor= [[[[iProject NetworkList]objectAtIndex:i] clients]intValue]+ [[[[iProject NetworkList]objectAtIndex:i] Servers]intValue];
        counter=counter+[self round:convertor];
        NSLog(@"client number :: %d to %d",convertor,counter);
    }
    
    NSNumber *returnNumber=[NSNumber numberWithInt:counter];
    
    
    return returnNumber ;
}


-(int)round:(int)item{
    
    int counter=0;
    
    item=item+2;
    
    int temp=1;
    
    int pow=1;
    
    while (temp==1) {
        
        counter++;
        
        pow=[self power:2 to:counter];

        if (pow>=item) {
            temp=0;
        
        }
        
        
    }
    
    NSLog(@"me %d",pow);
    
    return pow;
    
}
///header of static group

-    (void) tableView : (UITableView*) tableView
willDisplayHeaderView : (UIView*) view
           forSection : (NSInteger) section {
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor whiteColor]];
    //    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont fontWithName:@"System" size:72]];
    [[((UITableViewHeaderFooterView*) view) textLabel] setFont:[UIFont systemFontOfSize:16]];
    
}
////////////////////////////



- (void)viewDidLoad
{
    [super viewDidLoad];
    ipAval=[self loadIP];
    
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    ///tab bar
    
    self.tabBarController.tabBar.barTintColor=[UIColor blackColor];
    self.tabBarController.tabBar.tintColor=[UIColor whiteColor];
    /////////////
    
    
    
    int item1,item2,item3,item4,sub=0;
    
    
    item4=[[[currentProject NetworkIp]ip4]intValue];
    item3=[[[currentProject NetworkIp]ip3]intValue];
    item2=[[[currentProject NetworkIp]ip2]intValue];
    item1=[[[currentProject NetworkIp]ip1]intValue];
    sub=[[[currentProject NetworkIp]SubnetMask]intValue];
    
    
    [self.picker selectRow:item1 inComponent:0 animated:YES];
    [self.picker selectRow:item2 inComponent:1 animated:YES];
    [self.picker selectRow:item3 inComponent:2 animated:YES];
    [self.picker selectRow:item4 inComponent:3 animated:YES];
    [self.picker selectRow:sub inComponent:4 animated:YES];
    
    
    self.MapButton.enabled = NO;
    NSNumber *clientCounter=[self clientCount:currentProject];
    int ipNumber = [self power:2 to:(32-sub)];
    
    if( [clientCounter intValue] <= ipNumber)
    {
        self.MapButton.enabled = YES;
        
    }else
    {
        self.MapButton.enabled = NO;

        
    }
    
    self.MapButton.layer.cornerRadius=8.0f;
    self.MapButton.layer.masksToBounds=YES;
    self.MapButton.layer.borderColor=[[UIColor blackColor]CGColor];
    self.MapButton.layer.borderWidth= 2.5f;

    self.MapButton.tintColor=[UIColor redColor];

    // [self.MapButton setTitleTextAttributes:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) exitAction:(UIStoryboardSegue*) segue{
   // NetworkMapViewController   *i=[[NetworkMapViewController alloc ]init];
   // [i dismissViewControllerAnimated:YES completion: nil];

//[UIView]
}

-(NSMutableArray *)loadIP{
    int index=0;
    int end=0;
    for (int i=0;end==0;i++ ) {
        
        if ([[ProjectList objectAtIndex:i] isEqual:currentProject]) {
            end=1;
            index=i;
        }
    }
    
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Project" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSError *error;
        fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        
        
        
        
            NSManagedObject *obj=[ fetchedObjects objectAtIndex:index];
    
   // int ip1,ip2,ip3,ip4,sub;
    
            ip1=[[obj valueForKey:@"ip1"]intValue];
            ip2=[[obj valueForKey:@"ip2"]intValue];
            ip3=[[obj valueForKey:@"ip3"]intValue];
            ip4=[[obj valueForKey:@"ip4"]intValue];
            subnet=[[obj valueForKey:@"sub"]intValue];

    return    [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:ip1],
                                                      [NSNumber numberWithInt:ip1],
                                                      [NSNumber numberWithInt:ip1],
                                                      [NSNumber numberWithInt:ip1],
                                                      [NSNumber numberWithInt:subnet], nil];
}

-(void)UpdateIP:(NSMutableArray *)IP{
    
    int index=0;
    int end=0;
    
    for (int i=0;end==0;i++ ) {
        
        if ([[ProjectList objectAtIndex:i] isEqual:currentProject]) {
            end=1;
            index=i;
        }
    }
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSMutableArray *devices;
    
    NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Project"];
    
    devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    
    NSManagedObject *selectedDevice=[devices objectAtIndex:index];
    
    
    if (selectedDevice) {
        
        
        
        
        
        
        [selectedDevice setValue:[IP objectAtIndex:0] forKey:@"ip1"];
        [selectedDevice setValue:[IP objectAtIndex:1] forKey:@"ip2"];
        [selectedDevice setValue:[IP objectAtIndex:2] forKey:@"ip3"];
        [selectedDevice setValue:[IP objectAtIndex:3] forKey:@"ip4"];
        [selectedDevice setValue:[IP objectAtIndex:4] forKey:@"sub"];
        
        
    }
    
    
    
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error:%@", error);
    }
    NSLog(@"Data saved");
    
    
}

@end
