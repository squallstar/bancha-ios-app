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

@interface ContentsController : UITableViewController <ApiDelegate> {
    Structure structure;
    NSMutableArray *pages;
    NSMutableArray *contents;
    NSDictionary *types;
}

- (void)fillContentTypes;

@property (nonatomic, assign) Structure structure;

@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) NSMutableArray *contents;
@property (nonatomic, retain) NSDictionary *types;

@end
