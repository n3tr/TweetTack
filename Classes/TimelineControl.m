//
//  TimelineControl.m
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TimelineControl.h"
#import "MGTwitterEngine.h"
#import "ImageLoadingOperation.h"


@implementation TimelineControl

static TimelineControl *timelineObject = nil;
static int NetworkActivityIndicatorCounter = 0;



@synthesize friendTimeline,mentionTimeline,cachedImage,directMessagesList;

-(id)init
{
	[super init];
	username = @"";
	password = @"";
	
	twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	if (!friendTimeline) {
		friendTimeline = [[NSMutableArray alloc] init];
	}
	if (!mentionTimeline) {
		mentionTimeline = [[NSMutableArray alloc] init];
	}
	if (!cachedImage) {
		cachedImage = [[NSMutableDictionary alloc] init];
	}
	if (!directMessagesList) {
		directMessagesList = [[NSMutableArray alloc] init];
	}
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	[twitterEngine setUsername:username password:password];
	NSLog(@"Singleton Object Created");
	
	[self updateTimeline];
				
	return self;
	
}

#pragma mark UpdateFunction

-(void)updateTimeline
{
	
	[twitterEngine getFollowedTimelineFor:[twitterEngine username] sinceID:topFriendID startingAtPage:0 count:200];
	
	[twitterEngine getRepliesStartingAtPage:0 sinceID:topMentionID count:200];
	[twitterEngine getDirectMessagesSinceID:(int)topDMID startingAtPage:0];
	[self increaseNetworkActivityIndicator];
		
	
}

#pragma mark delegate for MGTwitterEngine

- (void)requestSucceeded:(NSString *)requestIdentifier
{
	
    NSLog(@"Request succeeded (%@)", requestIdentifier);
}


- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error
{
    NSLog(@"Twitter request failed! (%@) Error: %@ (%@)", 
          requestIdentifier, 
          [error localizedDescription], 
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);	
	NetworkActivityIndicatorCounter = 0;
	[self decreaseNetworkActivityIndicator];
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)identifier
{
	[self decreaseNetworkActivityIndicator];

	int range = [statuses count];
	
	if (range != 0) {
		//NSDictionary *a = [statuses objectAtIndex:0];
		if ([[[statuses objectAtIndex:0] objectForKey:@"source_api_request_type"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
			NSLog(@"Timeline Count %d",range);
			topFriendID = [[statuses objectAtIndex:0] objectForKey:@"id"];
			NSLog(@"topFrienID = %@ and object for id = %@",topFriendID,[[statuses objectAtIndex:0] objectForKey:@"id"]);
			lastFriendID = [[statuses objectAtIndex:[statuses count]-1] objectForKey:@"id"];
			NSLog(@"Timeline arraived");
			[friendTimeline insertObjects:statuses atIndexes:[NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, range)]];
			// NSLog(@"Got statuses:\r%@", tweets);
			NSString *n = [NSString stringWithFormat:@"%d",range];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"FriendTimelineUpdated" object:n];
			NSLog(@"Friend Notofication");		
		}
		else if ([[[statuses objectAtIndex:0] objectForKey:@"source_api_request_type"] isEqualToNumber:[NSNumber numberWithInt:1]]){		
			topMentionID = [[statuses objectAtIndex:0] objectForKey:@"id"];
			NSLog(@"topMentionID = %@ and object for id = %@",topMentionID,[[statuses objectAtIndex:0] objectForKey:@"id"]);
			lastMentionID = [[statuses objectAtIndex:[statuses count]-1] objectForKey:@"id"];
			[mentionTimeline insertObjects:statuses atIndexes:[NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, range)]];
			NSLog(@"Mention Timeline Notification");
			NSString *n = [NSString stringWithFormat:@"%d",range];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"MentionTimelineUpdated" object:n];
			
		}
		
	}
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier
{
	
	int range = [messages count];
	topDMID = [[messages objectAtIndex:0] objectForKey:@"id"];
	lastDMID = [[messages objectAtIndex:[messages count]-1] objectForKey:@"id"];
	[directMessagesList insertObjects:messages atIndexes:[NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, range)]];
	//NSLog(@"Direct Notification");
	//NSLog(@"%@",[messages valueForKey:@"sender_screen_name"] );
	
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier
{
    NSLog(@"Got user info:\r%@", userInfo);
}




#pragma mark networkActivityIndicatorVisible
- (void) increaseNetworkActivityIndicator
{
	NetworkActivityIndicatorCounter++;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NetworkActivityIndicatorCounter > 0;
}

- (void) decreaseNetworkActivityIndicator
{
	if (NetworkActivityIndicatorCounter != 0) {
		NetworkActivityIndicatorCounter--;
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NetworkActivityIndicatorCounter > 0;

}


#pragma mark cachedImage



-(UIImage *)cachedImageForURL:(NSURL *)url
{
    id cachedObject = [cachedImage objectForKey:url];
    
	if (cachedObject == nil) {
		NSString *LoadingPlaceholder = @"Loading";
        // Set the loading placeholder in our cache dictionary.
        [cachedImage setObject:LoadingPlaceholder forKey:url];        
		
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = [[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:)];
		
        [operationQueue addOperation:operation];
        [operation release];
    } else if (![cachedObject isKindOfClass:[UIImage class]]) {
        // We're already loading the image. Don't kick off another request.
        cachedObject = nil;
		
    }
	
    return cachedObject;
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result
{
	
    NSURL *url = [result objectForKey:@"url"];
    UIImage *image = [result objectForKey:@"image"];
	
    // Store the image in our cache.
    // One way to enhance this application further would be to purge images that haven't been used lately,
    // or to purge aggressively in response to a memory warning.
	[cachedImage setObject:image forKey:url];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ImageCached" object:nil];
	
    
}

+ (id)sharedTimeline
{
    if (timelineObject == nil) {
        timelineObject = [[super allocWithZone:NULL] init];
    }
    return timelineObject;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedTimeline] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}



- (id)autorelease
{
    return self;
}

-(void)dealloc
{
	[twitterEngine closeAllConnections];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[myAlert release];
	[loopFriendLoading release];
	[loopMentionLoading release];
	[operationQueue release];
	[directMessagesList release];
	[cachedImage release];
	[friendTimeline release];
	[twitterEngine release];
	[super dealloc];
}

@end
