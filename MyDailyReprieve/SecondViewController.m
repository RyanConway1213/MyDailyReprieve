//
//  SecondViewController.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "SecondViewController.h"
#import "SWRevealViewController.h"
#import "SLColors.h"

@implementation SecondViewController

@synthesize tableDataSource, CurrentTitle, CurrentLevel, data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *DataPath = [Path stringByAppendingPathComponent:@"data.plist"];
	
    //    [self.view setBackgroundColor:[SLColors lightTanColor]];
    
	self.title = NSLocalizedString(@"Fourth", nil);
	NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
	self.data = tempDict;
    
    if(CurrentLevel == 0) {
        NSArray *tempArray = [[NSArray alloc] init];
		self.tableDataSource = tempArray;
		
        //		DrillDownAppAppDelegate *AppDelegate = (DrillDownAppAppDelegate *)[[UIApplication sharedApplication] delegate];
        //        NSLog(@"Data.plist: %@", AppDelegate.data);
		self.tableDataSource = [data objectForKey:@"Rows"];
		
		self.navigationItem.title = @"Root";
	}
	else
		self.navigationItem.title = CurrentTitle;
        
        // customize the nav bar
        self.navigationController.navigationBar.tintColor = [SLColors lightTanColor];
        self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
        self.navigationController.navigationBar.layer.shadowOpacity = 1.0f;
        NSDictionary *navBarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [SLColors greenTextColor], UITextAttributeTextColor,
                                          [UIColor clearColor], UITextAttributeTextShadowColor,
                                          [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                          [UIFont fontWithName:@"Georgia-Bold" size:20], UITextAttributeFont, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:navBarAttributes];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    // add list button
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:revealController
                                                                        action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [SLColors greenTextColor];
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableDataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	cell.textLabel.text = [dictionary objectForKey:@"Title"];
    cell.textLabel.backgroundColor = [UIColor blueColor];
    cell.textLabel.textColor = [SLColors greenTextColor];
    
    [cell setBackgroundColor:[SLColors lightTanColor]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	
	NSArray *Children = [dictionary objectForKey:@"Children"];
	
	if([Children count] == 0) {
		
        //		DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
        //		[self.navigationController pushViewController:dvController animated:YES];
	}
	else {
		SecondViewController *rvController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
		
		rvController.CurrentLevel += 1;
		rvController.CurrentTitle = [dictionary objectForKey:@"Title"];
		
		[self.navigationController pushViewController:rvController animated:YES];
		
		rvController.tableDataSource = Children;
		
	}
}

@end
