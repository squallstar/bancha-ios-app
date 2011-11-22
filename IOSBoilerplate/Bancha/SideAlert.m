//
//  SideAlert.m
//  Bancha
//
//  Created by Nicholas Valbusa on 22/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SideAlert.h"

#define ANIM_DURATION 0.3
#define MAX_ALPHA 0.8
#define FRAME_HEIGHT 30
#define LEFT_PADDING 15

@implementation SideAlert

@synthesize textLabel;

-(id)initInFrame:(CGRect)frame WithTitle:(NSString*)title {
	self = [super initWithFrame:CGRectMake(0, frame.size.height-FRAME_HEIGHT, frame.size.width, FRAME_HEIGHT)];
    if (self) {
        self.alpha = 0;
		self.backgroundColor = [UIColor blackColor];
		
		//Label
		textLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_PADDING, 0, self.frame.size.width-LEFT_PADDING, self.frame.size.height)];
		[textLabel setBackgroundColor:[UIColor clearColor]];
		[textLabel setText:title];
		[textLabel setTextColor:[UIColor whiteColor]];
		[textLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
		[self addSubview:textLabel];
    }
    return self;
}

-(void)setText:(NSString*)newText {
	[self.textLabel setText:newText];
}

-(void)fire {
	[UIView beginAnimations:@"SideAlert" context:nil];
	[UIView setAnimationDuration:ANIM_DURATION];
	
	self.alpha = MAX_ALPHA;
	
	[UIView commitAnimations];
}

-(void)remove {
	//[self removeFromSuperview];
}

-(void)removeAnimated {
	[UIView beginAnimations:@"SideAlert" context:nil];
	[UIView setAnimationDuration:ANIM_DURATION];
	//[UIView setAnimationDidStopSelector:@selector(remove)];
	
	self.alpha = 0;
	
	[UIView commitAnimations];
}

-(void)fireAndRemoveAfter:(CGFloat)seconds {
	[self fire];
	[NSTimer timerWithTimeInterval:seconds target:self selector:@selector(removeAnimated) userInfo:nil repeats:NO];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
