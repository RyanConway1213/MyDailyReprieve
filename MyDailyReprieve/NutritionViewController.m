//
//  NutritionViewController.m
//  MyDailyReprieve
//
//  Created by CONWAYKS on 3/26/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NutritionViewController.h"
#import "SLColors.h"

@interface NutritionViewController ()

@end

@implementation NutritionViewController

@synthesize stepsButton, stepsView, stepsContentView;

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

    [stepsContentView.layer setCornerRadius:5.0f];
    [stepsContentView.layer setMasksToBounds:YES];
}


-(IBAction)stepsButtonPressed:(id)sender
{
    [self.stepsView setAlpha:0.0f];
    [self.view addSubview:stepsView];
    [self.stepsView setFrame:self.view.frame];

    [UIView animateWithDuration:.4 animations:^{
        [self.stepsView setAlpha:1.0f];
    }];
}

-(IBAction)exitButtonPressed:(id)sender
{
    [self.stepsView setAlpha:1.0f];

    [UIView animateWithDuration:.4 animations:^{
        [self.stepsView setAlpha:0.0f];

    }];
    
}

@end
