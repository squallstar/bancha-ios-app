//
//  Api.h
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"

@interface Api : NSObject  {
	AFHTTPClient *client;
}

@property (nonatomic, retain) AFHTTPClient *client;

-(BOOL)loginToPath:(NSString*)adminPath withUsername:(NSString*)username andPassword:(NSString*)password;

@end
