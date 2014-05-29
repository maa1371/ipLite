//
//  NetworkMapViewController.m
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import "NetworkMapViewController.h"
#import "Project.h"
#import "Netwok.h"
#import "MapDetailsViewController.h"

@interface NetworkMapViewController ()

@end

@implementation NetworkMapViewController

@synthesize currentProject,IPaval;

Project *SortedCurrentProject;
NSMutableArray * clientsNum;
NSMutableArray * serverNum;

NSMutableArray * clientsNumround;
NSMutableArray * serverNumround;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
   
    
    ///////////
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view  insertSubview:imageView atIndex:0];
    
  ////////////////////
    self.tableView.backgroundColor=[UIColor blackColor];
    
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

    
    SortedCurrentProject =[[Project alloc]init];
    clientsNum=[[NSMutableArray alloc]init];
    serverNum=[[NSMutableArray alloc]init];
    clientsNumround=[[NSMutableArray alloc]init];
    serverNumround=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[[currentProject NetworkList]count]; i++) {
        [[SortedCurrentProject NetworkList]addObject:[[currentProject NetworkList]objectAtIndex:i ]];
        
    }
    
    for (int i=0; i<[[currentProject NetworkList]count]; i++) {
        [clientsNum addObject:[[[[currentProject NetworkList]objectAtIndex:i]clients]stringValue]];
        [serverNum addObject:[[[[currentProject NetworkList]objectAtIndex:i]Servers]stringValue]];
        
    }
    
    
    
    SortedCurrentProject=[self clientNumberRound:SortedCurrentProject];

    for (int i=0; i<[[currentProject NetworkList]count]; i++) {
        [clientsNumround addObject:[[[[currentProject NetworkList]objectAtIndex:i]clients]stringValue]];
        [serverNumround addObject:[[[[currentProject NetworkList]objectAtIndex:i]Servers]stringValue]];
        
    }

    SortedCurrentProject=[self sort:SortedCurrentProject];
   
    
    for (int i=0; i<[[SortedCurrentProject NetworkList]count]; i++) {
        NSLog(@"sorted ::%d",[[[[SortedCurrentProject NetworkList]objectAtIndex:i]clients]intValue]);
    }
    
    for (int i=0; i<[[currentProject NetworkList]count]; i++) {
        
        [[[SortedCurrentProject NetworkList]objectAtIndex:i]setClients:[NSNumber numberWithInt:[[clientsNum objectAtIndex:i] intValue]]];
        [[[SortedCurrentProject NetworkList]objectAtIndex:i]setServers:[NSNumber numberWithInt:[[serverNum objectAtIndex:i] intValue]]];

        
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    MapDetailsViewController *to=[segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    to.NSclientNumber=[clientsNum objectAtIndex:indexPath.row];
    to.NSserverNumber=[serverNum objectAtIndex:indexPath.row];
    to.NSNetworkIP =[self networkIPShow];
    to.NSbroadCastIP=[self broadcastIPShow];
    to.NSclientIPFrom=[self serverIPFromShow];
    to.NSclientIPTo=[self serverIPToShow];
    to.NSserverIPFrom=[self clientIPFromShow];
    to.NSserverIPto=[self clientIPToShow];
    to.title=[[[currentProject NetworkList]objectAtIndex:indexPath.row]NetworkName];
}

-(NSString *)networkIPShow{
   
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    int counter1=0;

    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    

    
    index4=counter1%256;
    
    index3=counter1/256;
    
    index2=counter1/(256*256);
    
    index1=counter1/(256*256*256);
    
    index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
    if (index4>255) {
        index4=index4-255;
        index3++;
    }
    
    index3=[[IPaval objectAtIndex:2]intValue]+index3;
    
    if (index3>255) {
        index3=index3-255;
        index2++;
    }
    
    index2=[[IPaval objectAtIndex:1]intValue]+index2;
    
    if (index2>255) {
        index2=index3-255;
        index1++;
    }
    
    index1=[[IPaval objectAtIndex:0]intValue]+index1;
    
    NSString *ip;
    int subint;
    NSString *sub;
   // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];

    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
    return ip ;
}

-(NSString *)broadcastIPShow{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    int counter1=0;
    
    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    
    counter1=counter1+[[clientsNumround objectAtIndex:indexPath.row]intValue]-1;
    
    
    index4=counter1%256;
    
    index3=counter1/256;
    
    index2=counter1/(256*256);
    
    index1=counter1/(256*256*256);
    
    index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
    if (index4>255) {
        index4=index4-255;
        index3++;
    }
    
    index3=[[IPaval objectAtIndex:2]intValue]+index3;
    
    if (index3>255) {
        index3=index3-255;
        index2++;
    }
    
    index2=[[IPaval objectAtIndex:1]intValue]+index2;
    
    if (index2>255) {
        index2=index3-255;
        index1++;
    }
    
    index1=[[IPaval objectAtIndex:0]intValue]+index1;
    
    
    NSString *ip;
    int subint;
    NSString *sub;
    // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];
    
    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
    return ip ;
}

-(NSString *)serverIPFromShow{

    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([[serverNum objectAtIndex:indexPath.row]intValue]==0) {
        return @"--.--.--.--/--";
    }
    else
    {
    int counter1=0;
    
    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    counter1=counter1+1;
    
    
        index4=counter1%256;
        
        index3=counter1/256;
        
        index2=counter1/(256*256);
        
        index1=counter1/(256*256*256);
        
        index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
        if (index4>255) {
            index4=index4-255;
            index3++;
        }
        
        index3=[[IPaval objectAtIndex:2]intValue]+index3;
        
        if (index3>255) {
            index3=index3-255;
            index2++;
        }
        
        index2=[[IPaval objectAtIndex:1]intValue]+index2;
        
        if (index2>255) {
            index2=index3-255;
            index1++;
        }
        
        index1=[[IPaval objectAtIndex:0]intValue]+index1;
        

    
    NSString *ip;
    int subint;
    NSString *sub;
    // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];
    
    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
    return ip ;
    }
}

-(NSString *)serverIPToShow{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([[serverNum objectAtIndex:indexPath.row]intValue]==0) {
        return @"--.--.--.--/--";
    }
    else
    {
    
    int counter1=0;
    
    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    
    counter1=counter1+[[serverNum objectAtIndex:indexPath.row]intValue];
    
    
        index4=counter1%256;
        
        index3=counter1/256;
        
        index2=counter1/(256*256);
        
        index1=counter1/(256*256*256);
        
        index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
        if (index4>255) {
            index4=index4-255;
            index3++;
        }
        
        index3=[[IPaval objectAtIndex:2]intValue]+index3;
        
        if (index3>255) {
            index3=index3-255;
            index2++;
        }
        
        index2=[[IPaval objectAtIndex:1]intValue]+index2;
        
        if (index2>255) {
            index2=index3-255;
            index1++;
        }
        
        index1=[[IPaval objectAtIndex:0]intValue]+index1;
        

    
    NSString *ip;
    int subint;
    NSString *sub;
    // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];
    
    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
    return ip ;
    }
}
-(NSString *)clientIPFromShow{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([[clientsNum objectAtIndex:indexPath.row]intValue]==0) {
        return @"--.--.--.--/--";
    }
    else
    {
    int counter1=0;
    
    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    
    counter1=counter1+[[serverNum objectAtIndex:indexPath.row]intValue]+1;
    
    
        index4=counter1%256;
        
        index3=counter1/256;
        
        index2=counter1/(256*256);
        
        index1=counter1/(256*256*256);
        
        index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
        if (index4>255) {
            index4=index4-255;
            index3++;
        }
        
        index3=[[IPaval objectAtIndex:2]intValue]+index3;
        
        if (index3>255) {
            index3=index3-255;
            index2++;
        }
        
        index2=[[IPaval objectAtIndex:1]intValue]+index2;
        
        if (index2>255) {
            index2=index3-255;
            index1++;
        }
        
        index1=[[IPaval objectAtIndex:0]intValue]+index1;
        

    
    NSString *ip;
    int subint;
    NSString *sub;
    // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];
    
    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
    return ip ;
    }
}

-(NSString *)clientIPToShow{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([[clientsNum objectAtIndex:indexPath.row]intValue]==0) {
        return @"--.--.--.--/--";
    }
    else{
        
    
    int counter1=0;
    
    int index1,index2,index3,index4;
    
    for (int i=0; i<indexPath.row; i++) {
        
        counter1 = counter1 + [[clientsNumround objectAtIndex:i]intValue];
    }
    
    counter1=counter1+[[clientsNumround objectAtIndex:indexPath.row]intValue]-1-1;
    
    
        index4=counter1%256;
        
        index3=counter1/256;
        
        index2=counter1/(256*256);
        
        index1=counter1/(256*256*256);
        
        index4=[[IPaval objectAtIndex:3]intValue]+index4;//+from;
        if (index4>255) {
            index4=index4-255;
            index3++;
        }
        
        index3=[[IPaval objectAtIndex:2]intValue]+index3;
        
        if (index3>255) {
            index3=index3-255;
            index2++;
        }
        
        index2=[[IPaval objectAtIndex:1]intValue]+index2;
        
        if (index2>255) {
            index2=index3-255;
            index1++;
        }
        
        index1=[[IPaval objectAtIndex:0]intValue]+index1;
        
    
    NSString *ip;
    int subint;
    NSString *sub;
    // sub=[self clientNumberToSubnet:[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]stringValue]];
    
    
    subint=[[clientsNumround objectAtIndex:indexPath.row]intValue];
    
    sub=[[NSNumber numberWithInt:[self clientNumberToSubnet:subint]]stringValue];
    
    NSLog(@":%d",subint);
    
    
    
    ip=[self show:    [[NSNumber numberWithInt:index1]stringValue]
              and:    [[NSNumber numberWithInt:index2]stringValue]
              and:    [[NSNumber numberWithInt:index3]stringValue]
              and:    [[NSNumber numberWithInt:index4]stringValue]
              and:     sub ];
    
        return ip ;}
}

-(int)clientNumberToSubnet:(int)clientNumber{
    int counter=0;
    int temp=0;
    
    while (temp==0) {
        
        clientNumber=clientNumber/2;
        counter++;
        
        if (clientNumber==1) {
            temp=1;
        }
    
    }
    
    
    return 32-counter;
}



-(NSString *)show:(NSString *)part1  and :(NSString *)part2 and: (NSString *)part3 and : (NSString *)part4  and :(NSString *)subnet{
    
    NSString *part1String=part1;
    NSString *part2String=part2;
    NSString *part3String=part3;
    NSString *part4String=part4;
    NSString *partSubnet =subnet;
   // [self clientNumberToSubnet:clientCount];
    
   // NSString *partSubnet=[[NSNumber numberWithInt:[self clientNumberToSubnet:clientCount]]stringValue];
    
    
    
    
    
    
    
    NSString * returnVAlue=[[NSString alloc]init];
    returnVAlue=[returnVAlue stringByAppendingString:part1String];
    returnVAlue=[returnVAlue stringByAppendingString:@":"];
    returnVAlue=[returnVAlue stringByAppendingString:part2String];
    returnVAlue=[returnVAlue stringByAppendingString:@":"];
    returnVAlue=[returnVAlue stringByAppendingString:part3String];
    returnVAlue=[returnVAlue stringByAppendingString:@":"];
    returnVAlue=[returnVAlue stringByAppendingString:part4String];
    returnVAlue=[returnVAlue stringByAppendingString:@"/"];
    returnVAlue=[returnVAlue stringByAppendingString:partSubnet];
    
    return returnVAlue;
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [SortedCurrentProject NetworkList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"result";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    NSString *networkName=[[[SortedCurrentProject NetworkList]objectAtIndex:indexPath.row]NetworkName];
//    [[cell textLabel]setText:networkName];
//    
    UILabel *lable200 =(UILabel*)[cell viewWithTag:200];
    // lable200.backgroundColor=[UIColor whiteColor];
    
    [lable200 setText:[[[currentProject NetworkList] objectAtIndex:indexPath.row]NetworkName]];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:210];
    recipeImageView.image = [UIImage imageNamed:@"side_icon.png"];

    
    return cell;
    
}



-(Project *) sort:(Project *)projects{
    
    for (int i=0; i<[[projects NetworkList]count];i++ ) {
        
        
        for (int j=i; j<[[projects NetworkList]count];j++ ) {
            
            if ([[[[projects NetworkList]objectAtIndex:i]clients]intValue]<[[[[projects NetworkList]objectAtIndex:j]clients]intValue]) {
            
                Netwok * temp;
                temp=[[projects NetworkList]objectAtIndex:i] ;
                
                [[projects NetworkList]replaceObjectAtIndex:i withObject:[[projects NetworkList]objectAtIndex:j]];
                [[projects NetworkList]replaceObjectAtIndex:j withObject:temp];
                
                NSString *NStemp;
                NStemp=[clientsNum objectAtIndex:i];
                [clientsNum replaceObjectAtIndex:i withObject:[clientsNum objectAtIndex:j]];
                [clientsNum replaceObjectAtIndex:j withObject:NStemp];
                
                NStemp=[serverNum objectAtIndex:i];
                [serverNum replaceObjectAtIndex:i withObject:[serverNum objectAtIndex:j]];
                [serverNum replaceObjectAtIndex:j withObject:NStemp];
                
                NStemp=[clientsNumround objectAtIndex:i];
                [clientsNumround replaceObjectAtIndex:i withObject:[clientsNumround objectAtIndex:j]];
                [clientsNumround replaceObjectAtIndex:j withObject:NStemp];
                
                NStemp=[serverNumround objectAtIndex:i];
                [serverNumround replaceObjectAtIndex:i withObject:[serverNumround objectAtIndex:j]];
                [serverNumround replaceObjectAtIndex:j withObject:NStemp];
                
                
            }
            
        }
        
        
        
    }
    
    return projects;
}




-(int)power:(int)item1 to:(int)item2{
    int value=1;
    for (int index=0; index<item2; index++) {
        value=value*item1;
    }
    return value;
}


-(Project *)clientNumberRound:(Project *)iProject{
  
    int indexPath=(int)[[iProject NetworkList]count];
    int convertor=0;
    int counter=0;
    for (int i=0; i<indexPath; i++) {
        
        convertor= [[[[iProject NetworkList]objectAtIndex:i] clients]intValue]+ [[[[iProject NetworkList]objectAtIndex:i] Servers]intValue];
        counter=[self round:convertor];
    
        [[[iProject NetworkList]objectAtIndex:i]setClients:[NSNumber numberWithInt:counter]];
        [[[iProject NetworkList]objectAtIndex:i]setServers:[NSNumber numberWithInt:0]];
        
        
    }
    
    return iProject ;
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
    
    
    return pow;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)exitAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
