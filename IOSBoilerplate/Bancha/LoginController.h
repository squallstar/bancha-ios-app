//
//  LoginController.h
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginController : QuickDialogController  <QuickDialogStyleProvider>

+ (QRootElement *)createLoginForm;
+ (QRootElement *)createDetailsForm;

@end