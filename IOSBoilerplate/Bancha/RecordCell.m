//
//  RecordCell.m
//  Bancha
//
//  Created by Nicholas Valbusa on 11/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "RecordCell.h"
#import "Constants.h"

@implementation RecordCell

@synthesize title, background, firstLine, secondLine, cellHeight, btnPublish;
@synthesize record_id, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 55.0);
    }
    return self;
}

-(void)setStage:(BOOL)stage {
	if (stage) {
		[[self background] setBackgroundColor:RGB(255, 244, 195)];
		[btnPublish setTitle:@"Draft" forState:UIControlStateNormal];
		[btnPublish setTitle:@"Draft" forState:UIControlStateHighlighted];
	} else {
		[[self background] setBackgroundColor:[UIColor clearColor]];
		[btnPublish setTitle:@"Published" forState:UIControlStateNormal];
		[btnPublish setTitle:@"Published" forState:UIControlStateHighlighted];
	}
}

-(IBAction)edit:(id)sender {
	if (delegate != nil) {
		[delegate cellClickedEditButton:record_id];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
