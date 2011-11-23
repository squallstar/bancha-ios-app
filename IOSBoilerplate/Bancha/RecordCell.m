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

@synthesize title, background, firstLine, secondLine, cellHeight, btnPublish, bg;
@synthesize record_id, delegate, scroller;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 55.0);
        
        
    }
    return self;
}

-(void)prepare {
    buttonsAdded = FALSE;
    btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(102, 4, 82, 31)];
}

-(void)setStage:(BOOL)stage {
	if (stage) {
		[self.bg setImage:[UIImage imageNamed:@"bg_cell_alt.png"]];
		[btnPublish setTitle:@"Publish" forState:UIControlStateNormal];
		[btnPublish setTitle:@"Publish" forState:UIControlStateHighlighted];
        [btnPublish setBackgroundImage:[UIImage imageNamed:@"btnGreen.png"] forState:UIControlStateNormal];
	} else {
        [self.bg setImage:[UIImage imageNamed:@"bg_cell.png"]];
		[btnPublish setTitle:@"Depublish" forState:UIControlStateNormal];
		[btnPublish setTitle:@"Depublish" forState:UIControlStateHighlighted];
        [btnPublish setBackgroundImage:[UIImage imageNamed:@"btnOrange.png"] forState:UIControlStateNormal];
	}
}

-(IBAction)edit:(id)sender {
	if (delegate != nil) {
		[delegate cellClickedEditButton:record_id];
	}
}

-(IBAction)triggerPublish:(id)sender {
    //TODO
}

-(void)addButtons {
    if (!buttonsAdded) {
        
        UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(12, 4, 82, 31)];
        [btnEdit setBackgroundImage:[UIImage imageNamed:@"btnGrey.png"] forState:UIControlStateNormal];
        [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
        [btnEdit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[btnEdit titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
        [btnEdit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchDown];
        [self.scroller addSubview:btnEdit];
        [btnEdit release];
        
        btnPublish.frame = CGRectMake(102, 4, 82, 31);
        [btnPublish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[btnPublish titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
        [btnPublish addTarget:self action:@selector(triggerPublish:) forControlEvents:UIControlEventTouchDown];
        [self.scroller addSubview:btnPublish];
        
        UIButton *btnView = [[UIButton alloc] initWithFrame:CGRectMake(192, 4, 82, 31)];
        [btnView setBackgroundImage:[UIImage imageNamed:@"btnGrey.png"] forState:UIControlStateNormal];
        [btnView setTitle:@"View" forState:UIControlStateNormal];
        [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[btnView titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
        //[btnView addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchDown];
        [self.scroller addSubview:btnView];
        [btnView release];
        
        UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(282, 4, 82, 31)];
        [btnDelete setBackgroundImage:[UIImage imageNamed:@"btnGrey.png"] forState:UIControlStateNormal];
        [btnDelete setTitle:@"Delete" forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[btnDelete titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
        //[btnDelete addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchDown];
        [self.scroller addSubview:btnDelete];
        [btnDelete release];
        
        [self.scroller setShowsHorizontalScrollIndicator:NO];
        [self.scroller setContentSize:CGSizeMake(374, scroller.frame.size.height)];        
        [self.scroller setAlwaysBounceHorizontal:YES];
        
        buttonsAdded = TRUE;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
