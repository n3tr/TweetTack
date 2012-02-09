//
//  TimelineViewController.h
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TimelineViewController : UITableViewController<UITabBarDelegate> {
		
	NSMutableArray *timeline;
}

-(void)needUpdate;
@property (nonatomic, retain) NSMutableArray *timeline;
@property(assign) NSString *newMsg;

@end




