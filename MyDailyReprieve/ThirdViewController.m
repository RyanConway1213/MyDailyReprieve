//
//  ThirdViewController.m
//  MyDailyReprieve
//
//  Created by Scott Lucien on 3/6/13.
//  Copyright (c) 2013 CONWAYKS. All rights reserved.
//

#import "ThirdViewController.h"
#import "SWRevealViewController.h"
#import "SLColors.h"

@interface ThirdViewController ()

// IBOutlets
@property (weak, nonatomic) IBOutlet UITextView *textView;

// Properties
@property (nonatomic, strong) NSXMLParser * rssParser;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) NSMutableDictionary *item;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *tweet, *date;//, *currentDate, *currentSummary, *currentLink;

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"Support", nil);
    [self.view setBackgroundColor:[SLColors lightTanColor]];
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
    self.navigationItem.leftBarButtonItem.tintColor = [SLColors greenTextColor];
    
    // customize the text view
    [_textView setBackgroundColor:[UIColor clearColor]];
    [_textView setFont:[UIFont fontWithName:@"Georgia-Bold" size:18]];
    [_textView setTextColor:[SLColors greenTextColor]];
    
    // add refresh button
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTweet)];
    refreshBtn.tintColor = [SLColors greenTextColor];
    self.navigationItem.rightBarButtonItem = refreshBtn;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshTweet];
}

- (void)parseXMLFileAtURL:(NSString *)URL {
	_tweets = [[NSMutableArray alloc] init];
    
	//you must then convert the path to a proper NSURL or it won't work
	NSURL *xmlURL = [NSURL URLWithString:URL];
    
	// here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
	// this may be necessary only for the toolchain
	NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [rssParser setDelegate:self];
    
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
    
	[rssParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	//NSLog(@"Found file and started parsing");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
    
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	//NSLog(@"found this element: %@", elementName);
	_currentElement = [elementName copy];
    
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		_item = [[NSMutableDictionary alloc] init];
		_tweet = [[NSMutableString alloc] init];
        _date = [[NSMutableString alloc] init];
        
        //_currentTitle = [[NSMutableString alloc] init];
		//_currentDate = [[NSMutableString alloc] init];
		//_currentSummary = [[NSMutableString alloc] init];
		//_currentLink = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[_item setObject:_tweet forKey:@"description"];
        [_item setObject:_date forKey:@"pubDate"];
        
        //[_item setObject:_currentTitle forKey:@"title"];
		//[_item setObject:_currentLink forKey:@"link"];
		//[_item setObject:_currentSummary forKey:@"summary"];
		//[_item setObject:_currentDate forKey:@"date"];
        
		[_tweets addObject:[_item copy]];
		//NSLog(@"adding story: %@", _tweet);
	}
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	
    if ([_currentElement isEqualToString:@"description"]) {
		[_tweet appendString:string];
	} else if ([_currentElement isEqualToString:@"pubDate"]) {
		[_date appendString:string];
	}
    
    /*
     if ([_currentElement isEqualToString:@"title"]) {
     [_currentTitle appendString:string];
     } else if ([_currentElement isEqualToString:@"link"]) {
     [_currentLink appendString:string];
     } else if ([_currentElement isEqualToString:@"description"]) {
     [_currentSummary appendString:string];
     } else if ([_currentElement isEqualToString:@"pubDate"]) {
     [_currentDate appendString:string];
     }
     */
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
	//NSLog(@"all done!");
	//NSLog(@"stories array has %d items", [_tweets count]);
    
	//[newsTable reloadData];
    
}

- (void)refreshTweet {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // update the twitter field
    NSString *username = @"yager4";
    NSString *url = [[NSString alloc] initWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=%@", username];
    [self parseXMLFileAtURL:url];
    
    NSDictionary *dict = [_tweets objectAtIndex:0];
    NSString *txt = [[dict objectForKey:@"description"] substringFromIndex:8];
    [_textView setText:txt];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}



@end
