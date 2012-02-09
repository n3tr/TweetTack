//
//  FriendTimelineViewController.m
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FriendTimelineViewController.h"

#import "TimelineControl.h"



@implementation FriendTimelineViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	//helpper = [[TackHelpper alloc] initWithFriend];
	//self.timeline = [helpper friendTimeline];
	
	self.timeline = [[TimelineControl sharedTimeline] friendTimeline];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTimeline:) name:@"FriendTimelineUpdated" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountSetting) name:@"AccountError" object:nil];
	
}

-(void)viewDidAppear:(BOOL)animated
{
	self.parentViewController.tabBarItem.badgeValue = nil;
}


-(void)reloadTimeline:(NSNotification *)a
{

	self.parentViewController.tabBarItem.badgeValue =[a object];
	[self.tableView reloadData];
	
}

 
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

@end
