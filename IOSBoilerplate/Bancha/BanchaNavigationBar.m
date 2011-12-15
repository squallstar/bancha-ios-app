//
//  BanchaNavigationBar.m
//  Bancha
//
//  Created by Nicholas Valbusa on 15/12/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "BanchaNavigationBar.h"

@implementation BanchaNavigationBar


- (void) drawRect:(CGRect)rect
{
	[super drawRect:rect];
	UIImage *image = [UIImage imageNamed: @"btnOrange.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
