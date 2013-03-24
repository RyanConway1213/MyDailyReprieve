//
//  FifthViewController.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "FifthViewController.h"
#import "SWRevealViewController.h"
#import "SLColors.h"

@interface FifthViewController ()

@end

@implementation FifthViewController

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
	
	self.title = NSLocalizedString(@"Fifth", nil);
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
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:revealController
                                                                        action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
