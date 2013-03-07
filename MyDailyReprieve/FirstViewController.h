//
//  FirstViewController.h
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView           *detailView;
@property (strong, nonatomic) IBOutlet UIButton         *detailButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem  *barButton;

-(IBAction)buttonPressed:(id)sender;
-(IBAction)barButtonPressed:(id)sender;

@end
