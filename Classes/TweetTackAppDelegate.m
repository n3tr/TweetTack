//
//  TweetTackAppDelegate.m
//  TweetTack
//
//  Created by n3tr on 10/30/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TweetTackAppDelegate.h"


@implementation TweetTackAppDelegate

@synthesize window,initViewController ;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
    // Override point for customization after application launch
	
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	[window addSubview:self.initViewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	
    [window release];
    [super dealloc];
}


@end
