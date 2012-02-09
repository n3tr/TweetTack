//
//  ImageLoadingOperation.h
//  MyTableView
//
//  Created by Evan Doll on 10/27/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ImageResultKey;
extern NSString *const URLResultKey;

@interface ImageLoadingOperation : NSOperation {
    NSURL *imageURL;
    id target;
    SEL action;
}

- (id)initWithImageURL:(NSURL *)imageURL target:(id)target action:(SEL)action;

@end
