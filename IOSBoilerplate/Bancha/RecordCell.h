//
//  RecordCell.h
//  Bancha
//
//  Created by Nicholas Valbusa on 11/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordCellDelegate 
@optional
-(void)cellClickedEditButton:(int)record_id;
@end

@interface RecordCell : UITableViewCell {
	id<RecordCellDelegate> delegate;
	CGFloat cellHeight; 
	UILabel *title;
	UILabel *firstLine;
	UILabel *secondLine;
	UIView *background;
	UIButton *btnPublish;
	int record_id;
    UIScrollView *scroller;
    BOOL buttonsAdded;
    UIImageView *bg;
}

-(void)setStage:(BOOL)stage;
-(IBAction)edit:(id)sender;
-(IBAction)triggerPublish:(id)sender;
-(void)addButtons;
-(void)prepare;

@property (nonatomic, retain) id<RecordCellDelegate> delegate;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *firstLine;
@property (nonatomic, retain) IBOutlet UILabel *secondLine;
@property (nonatomic, retain) IBOutlet UIView *background;
@property (nonatomic, retain) UIButton *btnPublish;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) IBOutlet UIImageView *bg;
@property (nonatomic) int record_id;

@end
