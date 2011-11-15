//
//  RecordEditController.h
//  Bancha
//
//  Created by Nicholas Valbusa on 14/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Api.h"

@interface RecordEditController : QuickDialogController  <QuickDialogStyleProvider, ApiDelegate, UIActionSheetDelegate> 

-(void)showActions;
-(void)openSection:(QButtonElement*)fieldset;

+ (QRootElement *)createFormForContentType:(NSDictionary*)content_type andRecord:(NSDictionary*)record;

+ (QRootElement*)createFieldsetWithName:(NSString*)fieldSetName andContentType:(NSDictionary*)content_type usingRecord:(NSDictionary*)record;


@end
