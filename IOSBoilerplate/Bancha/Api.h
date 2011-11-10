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
@optional
-(void)loginFinished:(BOOL)success;
-(void)typesFinished:(BOOL)success;
-(void)recordsObtained:(NSArray*)records forActiveQuery:(NSString*)typeName;
@end

@interface Api : NSObject  {
    id<ApiDelegate> delegate;
	AFHTTPClient *client;
}

@property (nonatomic, retain) id<ApiDelegate> delegate;
@property (nonatomic, retain) AFHTTPClient *client;

-(BOOL)loginToPath:(NSString*)adminPath withUsername:(NSString*)username andPassword:(NSString*)password;
-(void)getContentTypes;
-(void)getRecordsByActiveQuery:(NSString*)activeQuery;
-(void)tokenInvalidScript;

@end
