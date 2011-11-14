//
//  Constants.h
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

extern NSString * const API_URL;
extern int const API_RECORD_RESULTS;

typedef enum {
	StructureTree = 0,
	StructureSimple = 1
} Structure;

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]