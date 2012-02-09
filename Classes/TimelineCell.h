//
//  TimelineCell.h
//  TweetTail
//
//  Created by n3tr on 10/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface TimelineCell : UITableViewCell {
	UIImage *avatar;
	NSString *name;
	NSString *screenName;
	NSString *tweetText;
	NSString *timeAgo;
	 
}

@property(nonatomic,retain) UIImage *avatar;
@property(retain) NSString *name;
@property(retain) NSString *screenName;
@property(retain) NSString *tweetText;
@property(retain) NSString *timeAgo;

@end
