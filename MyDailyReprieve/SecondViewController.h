//
//  SecondViewController.h
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController : UITableViewController {
	
	NSArray *tableDataSource;
	NSString *CurrentTitle;
	NSInteger CurrentLevel;
}

@property (nonatomic, retain) NSArray *tableDataSource;
@property (nonatomic, retain) NSString *CurrentTitle;
@property (nonatomic, readwrite) NSInteger CurrentLevel;
@property (nonatomic, retain) NSDictionary *data;

@end
