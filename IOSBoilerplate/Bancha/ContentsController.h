//
//  ContentsController.h
//  Bancha
//
//  Created by Nicholas Valbusa on 10/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "IOSBoilerplateAppDelegate.h"
#import "RecordListController.h"
#import "SideAlert.h"

@interface ContentsController : UIViewController <ApiDelegate, UITableViewDelegate, UITableViewDataSource> {
    Structure structure;
    NSMutableArray *pages;
    NSMutableArray *contents;
    NSDictionary *types;
	SideAlert *alert;
	UITableView *tableView;
}

- (void)fillContentTypes;

@property (nonatomic, assign) Structure structure;

@property (nonatomic, retain) SideAlert *alert;
@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, retain) NSDictionary *types;
@property (nonatomic, retain) UITableView *tableView;

@end
