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

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize detailView, detailButton, barButton;

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
	
	self.title = NSLocalizedString(@"First", nil);
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 1.0f;
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:revealController
                                                                        action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
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

@end
