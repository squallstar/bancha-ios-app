//
//  RecordListController.h
//  Bancha
//
//  Created by Nicholas Valbusa on 10/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCell.h"
#import "Api.h"
#import "SideAlert.h"

@interface RecordListController : UITableViewController <ApiDelegate, RecordCellDelegate, UISearchBarDelegate> {
    NSDictionary *type;
    NSArray *records;
    id parent;
	RecordCell *cellNib;
	UISearchBar *searchBar;
	NSMutableDictionary *selectedIndexes;
	BOOL shouldBeginEditing;
	BOOL clickedEditCell;
	SideAlert *alert;
}

-(void)addNewRecord;
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;

@property (nonatomic, retain) NSDictionary *type;
@property (nonatomic, retain) NSArray *records;
@property (nonatomic, assign) id parent;
@property (nonatomic, retain) IBOutlet RecordCell *cellNib;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) SideAlert *alert;

@end
