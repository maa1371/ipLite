//
//  customtabViewController.h
//  ip Planner
//
//  Created by Mohammad Amin Ansari on 4/28/14.
//  Copyright (c) 2014 Mohammad Amin Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "ProjectListViewController.h"

@protocol PlayerDetailsViewControllerDelegate <NSObject>

- (void)transferProject:(ProjectListViewController *)controller didAddProject:(Project *)project;

@end

@interface customtabViewController : UITabBarController 
@property   (strong,nonatomic) NSMutableArray *ProjectList;
//@property (nonatomic, weak) id <PlayerDetailsViewControllerDelegate> delegate;

@end
