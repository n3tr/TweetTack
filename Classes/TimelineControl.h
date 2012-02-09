//
//  TimelineControl.h
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MGTwitterEngine;

@interface TimelineControl : NSObject {
	UIAlertView *myAlert;
	MGTwitterEngine *twitterEngine;
	NSString *topFriendID;
	NSString *lastFriendID;
	NSString *topMentionID;
	NSString *lastMentionID;
	NSString *lastDMID;
	NSString *topDMID;
	NSMutableArray *directMessagesList;
	NSMutableArray *friendTimeline;
	NSMutableArray *mentionTimeline;
	NSMutableDictionary *cachedImage;
	NSOperationQueue *operationQueue;
	NSTimer *loopFriendLoading;
	NSTimer *loopMentionLoading;
	NSString *username;
	NSString *password;
}

@property (nonatomic,readonly) NSMutableArray *friendTimeline;
@property (nonatomic,readonly) NSMutableArray *mentionTimeline;
@property (nonatomic,readonly) NSMutableArray *directMessagesList;
@property (nonatomic,readonly) NSMutableDictionary *cachedImage;

+(id)sharedTimeline;
-(void) increaseNetworkActivityIndicator;
-(void) decreaseNetworkActivityIndicator;
-(UIImage *)cachedImageForURL:(NSURL *)url;
@end
