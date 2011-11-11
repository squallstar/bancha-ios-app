//
//  RecordCell.h
//  Bancha
//
//  Created by Nicholas Valbusa on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell {
	UILabel *title;
	UIView *background;
}

-(void)setStage:(BOOL)stage;

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UIView *background;

@end
