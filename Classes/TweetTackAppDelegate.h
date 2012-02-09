//
//  TweetTackAppDelegate.h
//  TweetTack
//
//  Created by n3tr on 10/30/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetTackAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	UIViewController *initViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *initViewController;

@end

