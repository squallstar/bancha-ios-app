//
//  IOSBoilerplateAppDelegate.h
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import <UIKit/UIKit.h>
#import "Api.h"
#import "LoginController.h"
#import "TabsController.h"

@interface IOSBoilerplateAppDelegate : NSObject <UIApplicationDelegate> {
	Api *api;
    TabsController *tabsController;
    UINavigationController *contentsNavigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) Api *api;
@property (nonatomic, retain) IBOutlet LoginController *loginController;
@property (nonatomic, retain) IBOutlet TabsController *tabsController;
@property (nonatomic, retain) IBOutlet UINavigationController *contentsNavigation;

+ (IOSBoilerplateAppDelegate*) sharedAppDelegate;

- (void)switchToTabBar;
- (void)switchToLogin;
- (BOOL)openURL:(NSURL*)url;

@end
