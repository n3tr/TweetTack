//
//  TimelineViewController.m
//  TweetTack
//
//  Created by n3tr on 10/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TimelineViewController.h"


#import "SingleTimelineCell.h"
#import "ImageLoadingOperation.h"
#import "TimelineControl.h"
#import "SingleTimelineViewController.h"

#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]

@implementation TimelineViewController

@synthesize timeline;

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[timeline release];
	
    [super dealloc];
}

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */





- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	self.timeline = [[NSMutableArray alloc] init];
	self.tableView.backgroundColor = DARK_BACKGROUND;
	
	 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTimeline) name:@"ImageCached" object:nil];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	UIBarButtonItem *newMsgButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
																				  target:self action:nil];
	
	UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																				  target:self action:@selector(needUpdate)];
	
	self.navigationItem.leftBarButtonItem = reloadButton;
	
	self.navigationItem.rightBarButtonItem = newMsgButton;
	[newMsgButton release];
	[reloadButton release];
}

#pragma mark Notification
-(void)needUpdate
{
	
	[[TimelineControl sharedTimeline] updateTimeline];
	self.navigationItem.leftBarButtonItem.enabled = NO;
}


-(void)reloadTimeline
{	
	
	
	[self.tableView reloadData];
	if (self.navigationItem.leftBarButtonItem.enabled == NO) {
		self.navigationItem.leftBarButtonItem.enabled = YES;
	}

}



/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return !timeline || [timeline count] == 1 ? 1 : [timeline count] + 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.row < [timeline count]) {
		static NSString *CellIdentifier = @"SingleTimelineCell";
		
		TimelineCell *cell = (TimelineCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[SingleTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// Set up the cell...
		NSDictionary *tweet = [timeline objectAtIndex:indexPath.row];
		
		cell.avatar = [[TimelineControl sharedTimeline] cachedImageForURL:[NSURL URLWithString:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]]];
	
		cell.tweetText = [tweet objectForKey:@"text"];
		cell.screenName = [[tweet objectForKey:@"user"] objectForKey:@"screen_name"];
		return cell;
	}else {			
		static NSString *Identifier = @"LoadMoreTimelineCell";
		UITableViewCell *uiCell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:Identifier] autorelease];
		uiCell.textLabel.text = [timeline count] ==0 ? @"" : @"Load More..";
		uiCell.textLabel.textAlignment = UITextAlignmentCenter;
		uiCell.textLabel.font = [UIFont systemFontOfSize:16];
		return uiCell;
		
	}
	
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = indexPath.row % 2 == 0 ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row < [timeline count]) {
		NSDictionary *tweet = [timeline objectAtIndex:indexPath.row];
		NSString *text = [tweet objectForKey:@"text"];
		UIFont *font = [UIFont systemFontOfSize:13.0]; 
		CGSize withinSize = CGSizeMake(tableView.bounds.size.width -80.0, 100.0);
		
		CGSize size = [text sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];			
		if (size.height < 35.0) {
			return 65.0;
		}
		return size.height + 30.0;
	}else {
		return 50.0;
	}
	
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	SingleTimelineViewController *view = [[SingleTimelineViewController alloc] initWithNibName:@"SingleTimelineViewController" bundle:nil];
	view.userData = [timeline objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:view animated:YES];
	[view release];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */






@end

