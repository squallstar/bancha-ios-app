//
//  RecordListController.h
//  Bancha
//
//  Created by Sistemi Informativi GIV on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordListController : UITableViewController {
    NSMutableArray *records;
}

@property (nonatomic, retain) NSMutableArray *records;

@end
