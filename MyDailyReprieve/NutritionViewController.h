//
//  NutritionViewController.h
//  MyDailyReprieve
//
//  Created by CONWAYKS on 3/26/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton         *stepsButton;
@property (strong, nonatomic) IBOutlet UIView           *stepsView;
@property (strong, nonatomic) IBOutlet UIView           *stepsContentView;

-(IBAction)stepsButtonPressed:(id)sender;
-(IBAction)exitButtonPressed:(id)sender;

@end
