//
//  MentionTimelineViewController.m
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MentionTimelineViewController.h"
#import "TimelineControl.h"

@implementation MentionTimelineViewController

-(void)viewWillAppear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTimeline:) name:@"MentionTimelineUpdated" object:nil];
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	/*
	helpper = [[TackHelpper alloc] initWithMention];
	self.timeline = [helpper mentionTimeline];
	 */
	self.timeline = [[TimelineControl sharedTimeline] mentionTimeline];
	
	self.navigationItem.title = @"@n3tr";
}

-(void)viewDidAppear:(BOOL)animated
{
	self.parentViewController.tabBarItem.badgeValue = nil;
}


-(void)reloadTimeline:(NSNotification *)a
{
	
	self.parentViewController.tabBarItem.badgeValue = [a object];
	[self.tableView reloadData];
	
}

 
-(void)dealloc
{
	[super dealloc];
}
@end
