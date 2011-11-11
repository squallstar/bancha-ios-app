//
//  RecordCell.m
//  Bancha
//
//  Created by Nicholas Valbusa on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordCell.h"
#import "Constants.h"

@implementation RecordCell

@synthesize title, background;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setStage:(BOOL)stage {
	if (stage) {
		[[self background] setBackgroundColor:RGB(255, 244, 195)];
	} else {
		[[self background] setBackgroundColor:[UIColor clearColor]];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
