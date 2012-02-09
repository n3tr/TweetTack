//
//  SingleTimelineCell.m
//  TweetTail
//
//  Created by n3tr on 10/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingleTimelineCell.h"


@interface SingleTimelineCellContentView : UIView
{
	TimelineCell *_cell;
	BOOL _highlighted;


}

@end

@implementation SingleTimelineCellContentView

- (id)initWithFrame:(CGRect)frame cell:(TimelineCell *)cell
{
	if (self = [super initWithFrame:frame]) {
		_cell = cell;
		self.opaque = YES;
		self.backgroundColor = _cell.backgroundColor;
	}
				
	return self;
}

-(void)drawRect:(CGRect)rect
{	
	
	[_cell.avatar drawInRect:CGRectMake(10.0, 5.0, 48.0, 48.0)];
	
	// [[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_cell.avatar]]] drawInRect:CGRectMake(10.0, 5.0, 50.0, 50.0)];
	//[_cell.avatar drawInRect:CGRectMake(10.0, 5.0, 50.0, 50.0)];
	_highlighted ? [[UIColor whiteColor] set] : [[UIColor blueColor] set];
	[_cell.screenName drawAtPoint:CGPointMake(70.0, 1.0) withFont:[UIFont boldSystemFontOfSize:13.0]];
	
	_highlighted ? [[UIColor whiteColor] set] : [[UIColor blackColor] set];
	//[_cell.tweetText drawAtPoint:CGPointMake(75.0, 20.0) withFont:[UIFont systemFontOfSize:11.0]];
	[_cell.tweetText drawInRect:CGRectMake(70.0, 17.0, self.bounds.size.width -80.0, 100.0) withFont:[UIFont systemFontOfSize:13.0] lineBreakMode:UILineBreakModeClip];

	/*CGSize size = [_cell.tweetText sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(self.bounds.size.width-80.0,100.0) lineBreakMode:UILineBreakModeWordWrap];
[_cell.tweetText drawInRect:CGRectMake(75.0, 17.0, size.width - 8.0, 100.0) withFont:[UIFont systemFontOfSize:13.0] lineBreakMode:UILineBreakModeWordWrap];
	*/
	
	/*
	[url release];
	[data release];
	[images release];
	 */
}

-(void)setHighlighted:(BOOL)highlighted
{
	_highlighted = highlighted;
	[self setNeedsDisplay];
}

-(BOOL)isHighlighted
{
	return _highlighted;
}

-(void)dealloc
{
	[super dealloc];
}
@end


@implementation SingleTimelineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		cellTimelineView = [[SingleTimelineCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 1.0) cell:self];
		cellTimelineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		cellTimelineView.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:cellTimelineView];
		
		//avatarView = [[UIImage alloc] initWithFrame:CGRectMake(5.0, 5.0, 50.0, 50.0)];
	
		//UIWebView *a = [[UIWebView alloc] initWithFrame:CGRectMake(75.0, 20.0, self.contentView.bounds.size.width -100, 50)];
		
		
		/*
		tweet = [[UILabel alloc] initWithFrame:CGRectMake(75.0, 20.0, self.contentView.bounds.size.width -100.0, 50.0)];
		
		tweet.textAlignment = UITextAlignmentLeft;
		tweet.numberOfLines = 3;
		tweet.font = [UIFont systemFontOfSize:11.0];
		tweet.textColor = [UIColor colorWithWhite:0.23 alpha:1.0];
		tweet.highlightedTextColor = [UIColor whiteColor];
		tweet.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.contentView addSubview:tweet];
		 */
	}
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:backgroundColor];
	cellTimelineView.backgroundColor = backgroundColor;
}
/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
/*
-(void)setTweetText:(NSString *)newText
{
	[super setTweetText:newText];
	tweet.text = newText;
}
*/
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	
    [UIView setAnimationsEnabled:NO];
    CGSize contentSize = cellTimelineView.bounds.size;
    cellTimelineView.contentStretch = CGRectMake(225.0 / contentSize.width, 0.0, (contentSize.width - 260.0) / contentSize.width, 1.0);

	//cellTimelineView.contentStretch = CGRectMake(0, 0, contentSize.width, 1.0);
    [UIView setAnimationsEnabled:YES];
}

- (void)dealloc {
	
	[cellTimelineView release];
    [super dealloc];
}


@end
