//
//  SingleTimelineViewController.m
//  TweetTack
//
//  Created by n3tr on 11/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingleTimelineViewController.h"
#import "TimelineControl.h"


@implementation SingleTimelineViewController

@synthesize userData,screenNameLabel,avatarBtn;

- (void)dealloc {
	[userData release];
	[avatarBtn release];
	[screenNameLabel release];
    [super dealloc];
}

- (void)viewDidLoad {
	self.screenNameLabel.text = [[userData objectForKey:@"user"] objectForKey:@"screen_name"];
	 
	[self.avatarBtn setImage:[[TimelineControl sharedTimeline] cachedImageForURL:[NSURL URLWithString:[[userData objectForKey:@"user"] objectForKey:@"profile_image_url"]]]  forState:UIControlStateNormal];
	self.title = [[userData objectForKey:@"user"] objectForKey:@"screen_name"];
    [super viewDidLoad];
}

-(void)viewDidUnload{
	self.screenNameLabel = nil;
	self.avatarBtn = nil;
	
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/




/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;





@end
