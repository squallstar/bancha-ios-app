//
//  RecordEditNavigationController.h
//  Bancha
//
//  Created by Nicholas Valbusa on 15/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//



@interface RecordEditNavigationController : UINavigationController {
	NSDictionary *type;
	NSDictionary *record;
}

@property (nonatomic, retain) NSDictionary *type;
@property (nonatomic, retain) NSDictionary *record;

@end
