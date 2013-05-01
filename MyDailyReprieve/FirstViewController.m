//
//  FirstViewController.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "FirstViewController.h"
#import "SWRevealViewController.h"
#import "UIView+MDP.h"
#import "SLColors.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize detailView, detailButton, barButton, drawerToolbar, searchList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    [self.view setBackgroundColor:[SLColors lightTanColor]];
    //[detailButton setTintColor:[SLColors darkerTanColor]];
    [barButton setTintColor:[SLColors darkerTanColor]];
    [drawerToolbar setTintColor:[SLColors darkerTanColor]];
    
    searchList = [[NSArray alloc]
                  initWithObjects:@"Drug and Alcholo Treatment Centers In Patient and Out Patient Programs", @"Drug and Alcohol Therapists", @"Adult Detox Centers or Hospitals", @"Adolescent Drug and Alcohol In Patient Centers", @"Adolescent Drug and Alcohol out Patient Centers", @"Adolescent Detox Centers or Hospitals", @"Addiction Psychologists", @"Addiction Psychiatrists", @"Recovery Coaches", @"Interventionists",@"Council on Alcoholism various cities", nil];
    
    // customize the nav bar
	self.title = NSLocalizedString(@"First", nil);
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
    
    [self.detailView setY:self.view.frame.size.height];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed:(id)sender
{
    [UIView animateWithDuration:.3 animations:^{
        [self.detailView setY:self.view.frame.size.height - self.detailView.frame.size.height];
    }];
}

-(IBAction)barButtonPressed:(id)sender
{
    [UIView animateWithDuration:.3 animations:^{
        [self.detailView setY:self.view.frame.size.height];
    }];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [searchList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [searchList objectAtIndex:row];
}

@end
