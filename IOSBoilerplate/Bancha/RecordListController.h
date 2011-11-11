//
//  RecordListController.h
//  Bancha
//
//  Created by Sistemi Informativi GIV on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordListController : UITableViewController {
    NSDictionary *type;
    NSArray *records;
    id parent;
}

@property (nonatomic, retain) NSDictionary *type;
@property (nonatomic, retain) NSArray *records;
@property (nonatomic, assign) id parent;

@end
