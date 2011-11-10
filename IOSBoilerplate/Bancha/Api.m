//
//  Api.m
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "Api.h"

@implementation Api

@synthesize delegate, client;

-(id)init {
	self = [super init];
	
	self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
	
	return self;
}

-(BOOL)loginToPath:(NSString*)adminPath withUsername:(NSString*)username andPassword:(NSString*)password {
	
	
	NSMutableCharacterSet *set = [NSMutableCharacterSet characterSetWithCharactersInString:@"/"];
	
	NSString *trimmedUri = [adminPath stringByTrimmingCharactersInSet:set];
	
	[self.client release];
	self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api/", trimmedUri]]];
	
	NSURLRequest *request = [self.client requestWithMethod:@"GET" path:@"login" parameters:[NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil]];

	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {

		NSString *msg = [JSON valueForKeyPath:@"message"];
		if ([msg isEqualToString:@"USER_PWD_WRONG"]) {
			
			UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or password wrong." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[al show];
			[al release];
            
            [delegate loginFinished:NO];
			
		} else {
			//Success!
            NSString *token = [[JSON valueForKeyPath:@"data"] valueForKeyPath:@"token"];
            
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"api_token"];
            [[NSUserDefaults standardUserDefaults] setObject:trimmedUri forKey:@"api_url"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [delegate loginFinished:YES];

		}
		
		
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
		NSLog(@"%@", error);
        [delegate loginFinished:NO];
	}];
	
	NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
	[queue addOperation:operation];
	
	
	return NO;
	
}


@end
