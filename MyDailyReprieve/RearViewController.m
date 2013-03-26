//
//  RearViewController.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SLColors.h"

@interface RearViewController ()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;
@synthesize rearNavBar = _rearNavBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // customize the nav bar
    _rearNavBar.tintColor = [SLColors lightTanColor];
    _rearNavBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    _rearNavBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _rearNavBar.layer.shadowRadius = 3.0f;
    _rearNavBar.layer.shadowOpacity = 1.0f;
    NSDictionary *navBarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [SLColors greenTextColor], UITextAttributeTextColor,
                                      [UIColor clearColor], UITextAttributeTextShadowColor,
                                      [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                      [UIFont fontWithName:@"Georgia-Bold" size:20], UITextAttributeFont, nil];
    [_rearNavBar setTitleTextAttributes:navBarAttributes];
    
    // customize the table view
    [_rearTableView setBackgroundColor:[SLColors lightTanColor]];
    [_rearTableView setSeparatorColor:[SLColors darkerTanColor]];
    
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
	
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
    
	if (row == 0) {
		cell.textLabel.text = @"Home";
	}
	else if (row == 1) {
		cell.textLabel.text = @"Resources";
	}
    else if (row == 2) {
		cell.textLabel.text = @"Twitter";
	}
    else if (row == 3) {
		cell.textLabel.text = @"FourthViewController";
	}
    else if (row == 4) {
		cell.textLabel.text = @"FifthViewController";
	}
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[SLColors greenTextColor]];
    [cell.textLabel setHighlightedTextColor:[SLColors greenTextColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:16]];
    
    // set selected background color
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[SLColors darkerTanColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;
    NSInteger row = indexPath.row;
    
	// Presentation logic for each view controller
	if (row == 0) {
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[FirstViewController class]] ) {
			FirstViewController *frontViewController = [[FirstViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else {
			[revealController revealToggle:self];
		}
	}
	else if (row == 1) {
        if ( ![frontNavigationController.topViewController isKindOfClass:[SecondViewController class]] ) {
			SecondViewController *newViewController = [[SecondViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 2) {
        if ( ![frontNavigationController.topViewController isKindOfClass:[ThirdViewController class]] ) {
			ThirdViewController *newViewController = [[ThirdViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 3) {
        if ( ![frontNavigationController.topViewController isKindOfClass:[FourthViewController class]] ) {
			FourthViewController *newViewController = [[FourthViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        else {
			[revealController revealToggle:self];
		}
	}
    else if (row == 4) {
        if ( ![frontNavigationController.topViewController isKindOfClass:[FifthViewController class]] ) {
			FifthViewController *newViewController = [[FifthViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        else {
			[revealController revealToggle:self];
		}
	}
}



@end
