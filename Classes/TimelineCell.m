//
//  TimelineCell.m
//  TweetTail
//
//  Created by n3tr on 10/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TimelineCell.h"


@implementation TimelineCell

@synthesize avatar,name ,tweetText, screenName;



/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
    }
    return self;
}

*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[timeAgo release];
	[avatar release];
	[name release];
	[tweetText release];
	[screenName release];
    [super dealloc];
}


@end
