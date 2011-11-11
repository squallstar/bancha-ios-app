//
//  IOSBoilerplateAppDelegate.m
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  

#import "IOSBoilerplateAppDelegate.h"
#import "AFURLCache.h"
#import "BrowserViewController.h"
#import "SettingsController.h"

@implementation IOSBoilerplateAppDelegate

@synthesize window = _window;
@synthesize loginController = _loginController, api, tabsController;
@synthesize contentsNavigation;

+ (IOSBoilerplateAppDelegate*) sharedAppDelegate {
	return (IOSBoilerplateAppDelegate*) [UIApplication sharedApplication].delegate;
}

- (BOOL)openURL:(NSURL*)url
{
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
    //[self.navigationController pushViewController:bvc animated:YES];
    [bvc release];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // use custom URLCache to get disk caching on iOS
    AFURLCache *URLCache = [[[AFURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                          diskCapacity:1024*1024*5 // 5MB disk cache
                                                              diskPath:[AFURLCache defaultCachePath]] autorelease];
    
	[NSURLCache setSharedURLCache:URLCache];
	
	self.api = [[Api alloc] init];
    
    //We create the settings form view
    UINavigationController *settingsRoot = [QuickDialogController controllerWithNavigationForRoot:[SettingsController createSettingsForm]];
    
    UITabBarItem *sett = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    [settingsRoot setTabBarItem:sett];
    [self.tabsController addChildViewController:settingsRoot];

	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"api_token"] != nil) {
        [self switchToTabBar];
    } else {
        [self switchToLogin];
    }
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) switchToTabBar {
    self.window.rootViewController = [self tabsController];
}

- (void) switchToLogin {
    UINavigationController *loginRoot = [QuickDialogController controllerWithNavigationForRoot:[LoginController createLoginForm]];
    
	self.window.rootViewController = loginRoot;
}

- (void)clearUserData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"api_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"api_url"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"content_types"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}

- (NSString*) version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)dealloc
{
	[api release];
    [_window release];
    [_loginController release];
    [contentsNavigation release];
    [tabsController release];
    [super dealloc];
}

@end
