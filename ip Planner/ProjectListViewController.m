//
//  ProjectViewController.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/25/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ipViewController.h"
#import "AddProjectViewController.h"
#import "Project.h"
#import "ipViewController.h"
#import "customtabViewController.h"
#import "ipNavigationViewController.h"
#import "Netwok.h"
#import "NetworkListViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


//#import "Netwok.h"

@interface ProjectListViewController () 

@end

@implementation ProjectListViewController

@synthesize ProjectList ,currentIndex;

NSArray *fetchedObjects;
NSManagedObject *selectedObject;

bool    replace;
bool edithEnable;
bool clickProper;
NSMutableArray *cellSelected;
UIBarButtonItem *deleteButton,*renameButton,*editButton,*addButton;
int  myindex;


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return YES;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(edithEnable)
        {
            [[collectionView cellForItemAtIndexPath:indexPath]viewWithTag:100].hidden=YES;

            [cellSelected addObject:[ProjectList objectAtIndex:indexPath.row]];
            NSLog(@"counter1::%lu",(unsigned long)[cellSelected count]);
            if ([cellSelected count]==0) {
                deleteButton.enabled=NO;
            }else{
                deleteButton.enabled=YES;
            }
           
            if ([cellSelected count]==1) {
                
                
                renameButton.enabled=YES;
            } else{
                renameButton.enabled=NO;
            }
            
        }
    
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(edithEnable)
    {
        [[collectionView cellForItemAtIndexPath:indexPath]viewWithTag:100].hidden=NO;

        [cellSelected removeObject:[ProjectList objectAtIndex:indexPath.row]];
        NSLog(@"counter2::%lu",(unsigned long)[cellSelected count]);

        if ([cellSelected count]==1) {
         //   myindex=indexPath.row;
            renameButton.enabled=YES;
        } else{
            renameButton.enabled=NO;
            }
        
        if ([cellSelected count]==0) {
            deleteButton.enabled=NO;
        }else{
            deleteButton.enabled=YES;
        }
        
    }
    
    
}

-(void)addAction:(id)sender
{
    [self performSegueWithIdentifier:@"add" sender:sender];
}

-(void)deleteAction:(id)sender{
    
    for (int i=0; i<cellSelected.count; i++) {
       
        int index=0;
        int end=0;
        for (int j=0;end==0 ; j++) {
            
            if ([[ProjectList objectAtIndex:j]isEqual:[cellSelected objectAtIndex:i]]) {
                end=1;
            }
            
            index=j;
        }
        
        [self deleteProject:index];
        [ProjectList removeObject:[cellSelected objectAtIndex:i]];
    }
    
    deleteButton.enabled=NO;
    renameButton.enabled=NO;
    [cellSelected removeAllObjects];
    [self.collectionView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        [[ProjectList objectAtIndex:myindex]setProjectName:alertTextField.text];
        
        [self renameProject:[ProjectList objectAtIndex:myindex]];
        
        [self.collectionView reloadData];
        

    }else{
        [self.collectionView reloadData];

    }
    
    // do whatever you want to do with this UITextField.
}

-(void)renameAction:(id)sender{
    NSLog(@"index::%d",myindex);
    
    for (int i=0; i<[ProjectList count]; i++) {
        if ([ProjectList objectAtIndex:i]==[cellSelected objectAtIndex:0]) {
            myindex=i;
            NSLog(@"%d",myindex);
        }
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Edit Project Name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
   
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0]setText:[[ProjectList objectAtIndex:myindex]ProjectName]];
    [alertView show];
    
   // [[ProjectList objectAtIndex:myindex]setProjectName:@"rename"];
    [cellSelected removeAllObjects];
    deleteButton.enabled=NO;
    renameButton.enabled=NO;
    
    
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ProjectList =[[NSMutableArray alloc]init];


    UIImage *image = [UIImage imageNamed:@"back.png"];
    
    
    
        self.collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
    //
    
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;

    

    
    
    
    
    /////
    deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction:)];
    
    
    renameButton = [[UIBarButtonItem alloc] initWithTitle:(@"rename") style:UIBarButtonItemStyleBordered target:self action:@selector(renameAction:)];
    
    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:(@"edit") style:UIBarButtonItemStyleBordered target:self action:@selector(editAction:)];

    
    
    
    
    
    deleteButton.enabled=NO;
    renameButton.enabled=NO;
   
    currentIndex=[[NSIndexPath alloc]init];
    edithEnable=NO;
    cellSelected=[[NSMutableArray alloc]init];

    
    [self loadData];

   // Do any additional setup after loading the view.
    
}






- (IBAction)editAction:(id)sender {
    
    if (edithEnable) {
        
        NSLog(@"HERE");
        self.navigationItem.leftBarButtonItems = @[addButton];

        // Deselect all selected items
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
       
        
        // Change the sharing mode to NO
        self.collectionView.allowsMultipleSelection = NO;
        

        // Remove all items from selectedRecipes array
        [cellSelected removeAllObjects];
        
       
        self.editButton.title = @"Edit";
        
        self.plusHidden.enabled=YES;

        edithEnable = NO;
        
        [self.collectionView reloadData];
        
    } else {
        // Change shareEnabled to YES and change the button text to DONE

        [cellSelected removeAllObjects];
        
        deleteButton.enabled=NO;
        renameButton.enabled=NO;
        self.navigationItem.leftBarButtonItems = @[deleteButton,renameButton];
        
        
        replace=YES;
        edithEnable = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.plusHidden.enabled=NO;
        self.editButton.title = @"Done";
        [self.collectionView reloadData];
      //  [self.editButton setStyle:UIBarButtonItemStylePlain];
        
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (edithEnable) {
        return NO;
    } else {
        return YES;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
    if ([[segue identifier] isEqualToString:@"add"])
    {
    }
    
    if ([segue.identifier isEqualToString:@"NetworkDetails"]) {
        
        customtabViewController *cvc=[segue destinationViewController];
        cvc.selectedIndex=0;
        
        ipNavigationViewController *IPNVC=[cvc.viewControllers objectAtIndex:0];
        
        
        NetworkListViewController  *NLVC=[[IPNVC viewControllers]objectAtIndex:0];
       
        IPNVC=[cvc.viewControllers objectAtIndex:1];

        ipViewController *IPVC=[[IPNVC viewControllers]objectAtIndex:0];
        
        
        currentIndex =[[self.collectionView indexPathsForSelectedItems]objectAtIndex:0];
       
        NLVC.ProjectList=ProjectList;
        NLVC.currentProject=[ProjectList objectAtIndex:[currentIndex row]];
        
        IPVC.ProjectList=ProjectList;
        IPVC.currentProject=[ProjectList objectAtIndex:[currentIndex row]];
        
        
        
    }

}

-(IBAction) AddNewProject:(UIStoryboardSegue*) segue{
    
   
    AddProjectViewController * APVC =[segue sourceViewController];
    
    int ID=0;
    if ([ProjectList count]==0) {
        ID=1;
    }else{
        int i=[ProjectList count];
        i--;
        ID=[[[ProjectList objectAtIndex:i]projectID]intValue];
        ID++;
    }
    
    Project *newProject =[[Project alloc]init];
    
    if ([[[APVC InputProjectName ]text ]isEqualToString:@""]) {
     
        [newProject setProjectName:@"unnamed Project"];
        [newProject setProjectID:[NSNumber numberWithInt:ID]];
        [ProjectList addObject:newProject];
    }
    else{
        [newProject setProjectName:[[APVC InputProjectName ]text]];
        [newProject setProjectID:[NSNumber numberWithInt:ID]];
        [ProjectList addObject:newProject];
    }

    [[newProject NetworkIp]setIp4:[NSNumber numberWithInt:0]];
    [[newProject NetworkIp]setIp3:[NSNumber numberWithInt:200]];
    [[newProject NetworkIp]setIp2:[NSNumber numberWithInt:200]];
    [[newProject NetworkIp]setIp1:[NSNumber numberWithInt:200]];
    [[newProject NetworkIp]setSubnetMask:[NSNumber numberWithInt:24]];
    
    [self AddProject:newProject];
    
    [self.collectionView  reloadData ]   ;
    
    
}


-(IBAction) returnFromipViewController:(UIStoryboardSegue*) segue{
    
    
    ipViewController    * TVC =[segue sourceViewController];
    
    ProjectList=TVC.ProjectList;
    
    
    
    [self.collectionView  reloadData ]   ;
    
    
}
-(IBAction) returnFromNetworkListViewController:(UIStoryboardSegue*) segue{
    
    
    NetworkListViewController    * NLVC =[segue sourceViewController];
    
    ProjectList=NLVC.projectList;
    
    
    
    [self.collectionView  reloadData ]   ;
    
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ProjectList count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";

    
    
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"back.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
//    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    
    
    //that is icon image that show in first page
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:@"proj-icon.png"];

    UIImageView *hoverImage = (UIImageView *)[cell viewWithTag:110];
    hoverImage.image=[UIImage imageNamed:@"delete.png"];
    
    //show the project name under project icon in collection
    Project *currentProject=[[Project alloc]init];
   
    UITextField *label300=(UITextField *)[cell viewWithTag:300];
    UITextView *label200=(UITextView *)[cell viewWithTag:200];

    label300.hidden=YES;
    [currentProject setProjectName:[[ProjectList objectAtIndex:indexPath.row] ProjectName]];
    label200.text =[currentProject ProjectName];
    if (/*edithEnable*/1) {
//        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete.png"]];
        if ((cell.selected==YES) ) {
            recipeImageView.hidden=YES;
        }else{
            recipeImageView.hidden=NO;
        }
        
        
          }
    
  //


    return cell;
}

-(void)AddProject:(Project *)item{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSManagedObject *dataRecord = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Project"
                                   inManagedObjectContext:context];
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Project" inManagedObjectContext:context];
//   
//    [fetchRequest setEntity:entity];
//    NSError *error1;
//    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error1];
//    
    
    
    
    
    [dataRecord setValue:[item projectID] forKey:@"projectID"];
    [dataRecord setValue:item.ProjectName forKey:@"name"];
    [dataRecord setValue:[[item NetworkIp] ip1] forKey:@"ip1"];
    [dataRecord setValue:[[item NetworkIp] ip2] forKey:@"ip2"];
    [dataRecord setValue:[[item NetworkIp] ip3] forKey:@"ip3"];
    [dataRecord setValue:[[item NetworkIp] ip4] forKey:@"ip4"];
    [dataRecord setValue:[[item NetworkIp] SubnetMask] forKey:@"sub"];

    
     NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error:%@", error);
    }
    NSLog(@"Data saved");
}

-(void)loadDataNet:(int) projectID this:(int)indexID{
   
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Network" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *obj in fetchedObjects) {
        
        if ([[obj valueForKey:@"projectID"]intValue]==projectID) {
        
            Netwok *newNetwork=[[Netwok alloc]init];
         
            
            [newNetwork setNetworkID:[obj valueForKey:@"networkID"]];
            [newNetwork setFromThisProjectID:[obj valueForKey:@"projectID"]];
            [newNetwork setNetworkName:[obj valueForKey:@"name"]];
            [newNetwork setClients:[obj valueForKey:@"clients"]];
            [newNetwork setServers:[obj valueForKey:@"servers"]];
            

            
            
            [[[ProjectList objectAtIndex:indexID]NetworkList]addObject:newNetwork];

            
        }
        
    }
    

}


-(void)loadData{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Project" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    

    
    
    for (NSManagedObject *obj in fetchedObjects) {

        Project *newProject=[[Project alloc]init];
        
        [newProject setProjectID:[obj valueForKey:@"projectID"]];
        [newProject setProjectName:[obj valueForKey:@"name"]];
        [[newProject NetworkIp]setIp1:[obj valueForKey:@"ip1"]];
        [[newProject NetworkIp]setIp2:[obj valueForKey:@"ip2"]];
        [[newProject NetworkIp]setIp3:[obj valueForKey:@"ip3"]];
        [[newProject NetworkIp]setIp4:[obj valueForKey:@"ip4"]];
        [[newProject NetworkIp]setSubnetMask:[obj valueForKey:@"sub"]];
        
        int amin=0;
        
        
        amin=[ProjectList count];
        
        [ProjectList addObject:newProject];

        [self loadDataNet:[newProject.projectID intValue] this:amin];
        
        
        
        
        

       // NSLog(@"id %d",[[obj valueForKey:@"projectID"] integerValue]);
       
        }
    
    
 }

-(void)deleteDataNet:(int) projectID {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Network" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    
    NSMutableArray *devices;
    
    NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Network"];
    
    devices = [[managedObjectContext executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    
    NSLog(@"main project ID %d",projectID+1);

    
    int realIndex=0;
    for (NSManagedObject *obj in fetchedObjects) {
        NSLog(@"project ID %d",[[obj valueForKey:@"projectID"]intValue]);
       
        
      if ([[obj valueForKey:@"projectID"]intValue]==projectID+1) {
            
            int index=0;
            
           // index=[[obj valueForKey:@"networkID"]integerValue];
          
          
          
            [context deleteObject:[devices objectAtIndex:realIndex]];
           
            NSLog(@"delte network index  %d of project ID :: %d",index,projectID+1);
        
        }
        
        realIndex++;
        
    }
    
    
}



-(void)deleteProject:(int )index{
    
    
  //  index=[ProjectList count]-index;
    NSLog(@"index::%d",index);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
   // NSManagedObjectContext *context = [delegate managedObjectContext];
   
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSMutableArray *devices;
    
    NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Project"];
    
    devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    
    
        // Delete object from database
        [context deleteObject:[devices objectAtIndex:index]];
    
    [self deleteDataNet:index];
    
    
    
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
}

-(void)renameProject:(Project *)item{
    
    int index=0;
    
    
    for (int i=0; i<[ProjectList count]; i++) {
        if ([[ProjectList objectAtIndex:i]isEqual:item]==YES) {
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
        
        

       

        
        [selectedDevice setValue:[item ProjectName] forKey:@"name"];
        [selectedDevice setValue:[[item NetworkIp] ip4] forKey:@"ip1"];
        [selectedDevice setValue:[[item NetworkIp] ip3] forKey:@"ip2"];
        [selectedDevice setValue:[[item NetworkIp] ip2] forKey:@"ip3"];
        [selectedDevice setValue:[[item NetworkIp] ip1] forKey:@"ip4"];
    
        
    }
    
    
    
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error:%@", error);
    }
    NSLog(@"Data saved");
    
    
}


//-(void)loadnetwork{
//
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    NSManagedObjectContext *context = [delegate managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Project" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//
//
//    for (NSManagedObject *obj in fetchedObjects) {
//
//        Project *newProject=[[Project alloc]init];
//
//        [newProject setProjectID:[obj valueForKey:@"projectID"]];
//        [newProject setProjectName:[obj valueForKey:@"name"]];
//        [[newProject NetworkIp]setIp1:[obj valueForKey:@"ip1"]];
//        [[newProject NetworkIp]setIp2:[obj valueForKey:@"ip2"]];
//        [[newProject NetworkIp]setIp3:[obj valueForKey:@"ip3"]];
//        [[newProject NetworkIp]setIp4:[obj valueForKey:@"ip4"]];
//
//        [ProjectList addObject:newProject];
//        NSLog(@"id %d",[[obj valueForKey:@"projectID"] integerValue]);
//
//    }
//
//
//}




    

@end
