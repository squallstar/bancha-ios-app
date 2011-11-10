//
//  Api.h
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"


@protocol ApiDelegate 
-(void)loginFinished:(BOOL)success;
@end

@interface Api : NSObject  {
    id<ApiDelegate> delegate;
	AFHTTPClient *client;
}

@property (nonatomic, retain) id<ApiDelegate> delegate;
@property (nonatomic, retain) AFHTTPClient *client;

-(BOOL)loginToPath:(NSString*)adminPath withUsername:(NSString*)username andPassword:(NSString*)password;

@end
