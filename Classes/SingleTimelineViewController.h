//
//  SingleTimelineViewController.h
//  TweetTack
//
//  Created by n3tr on 11/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SingleTimelineViewController : UIViewController{
	 UILabel *screenNameLabel;
	 UIButton *avatarBtn;
	NSDictionary *userData;
}

@property (nonatomic, retain) NSDictionary *userData;
@property (nonatomic, retain) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *avatarBtn;

@end

