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
}

-(void)setStage:(BOOL)stage;
-(IBAction)edit:(id)sender;

@property (nonatomic, retain) id<RecordCellDelegate> delegate;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *firstLine;
@property (nonatomic, retain) IBOutlet UILabel *secondLine;
@property (nonatomic, retain) IBOutlet UIView *background;
@property (nonatomic, retain) IBOutlet UIButton *btnPublish;
@property (nonatomic) int record_id;

@end
