//
//  LoginController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "LoginController.h"
#import "IOSBoilerplateAppDelegate.h"
#import "BanchaNavigationBar.h"

@interface LoginController ()
- (void)onLogin:(QButtonElement *)buttonElement;
- (void)onAbout;

@end


@implementation LoginController

- (void)loadView {
    [super loadView];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grain.gif"]];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grain.png"]];
    self.tableView.bounces = YES;
    ((QuickDialogTableView *)self.tableView).styleProvider = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    /*self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(onAbout)] autorelease];*/
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)loginCompleted {
    
	NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:3];
	
	QSection *sect = [self.root getSectionForIndex:0];
	for (QEntryElement *el in [sect elements]) {
		if (el.textValue) {
			[data setObject:el.textValue forKey:el.key];
		}
	}
    
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
	
	[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] loginToPath:[data objectForKey:@"url"] withUsername:[data objectForKey:@"username"] andPassword:[data objectForKey:@"password"]];		
}

-(void)loginFinished:(BOOL)success {
    if (success) {
        NSLog(@"Login success!");
        [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getContentTypes];
    } else {
        [self loading:NO];
    }
}

-(void)typesFinished:(BOOL)success {
    [self loading:NO];
    [[IOSBoilerplateAppDelegate sharedAppDelegate] switchToTabBar];
}

- (void)onLogin:(QButtonElement *)buttonElement {
    [self loading:YES];
    [self performSelector:@selector(loginCompleted) withObject:nil afterDelay:0.2];
}

- (void)onAbout {
    QRootElement *details = [LoginController createDetailsForm];
	
    QuickDialogController *quickform = [QuickDialogController controllerForRoot:details];
    [self presentModalViewController:
     [[[UINavigationController alloc] initWithRootViewController:quickform] autorelease] animated:YES];
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grain.gif"]];

    if ([element isKindOfClass:[QEntryElement class]]){
        //cell.textLabel.textColor = [UIColor whiteColor];
    }   
	
	if ([element isKindOfClass:[QButtonElement class]]){
		cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_green.png"]];
        cell.textLabel.textColor = [UIColor whiteColor];
	}	
}


+ (QRootElement *)createDetailsForm {
    QRootElement *details = [[[QRootElement alloc] init] autorelease];
    details.title = @"Details";
    details.controllerName = @"AboutController";
    details.grouped = YES;
    QSection *section = [[QSection alloc] initWithTitle:@"Information"];
    [section addElement:[[[QTextElement alloc] initWithText:@"Here's some more info about this app."] autorelease] ];
    [details addSection:section];
    [section release];
    return details;
}

+ (QRootElement *)createLoginForm {
    QRootElement *root = [[[QRootElement alloc] init] autorelease];
    root.controllerName = @"LoginController";
    root.grouped = YES;
    root.title = @"Login";
	
    QSection *main = [[QSection alloc] init];
    main.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
	
    QEntryElement *url = [[QEntryElement alloc] init];
    url.title = @"Admin URL";
    url.key = @"url";
    url.hiddenToolbar = YES;
    url.placeholder = @"hostname/admin";
    [main addElement:url];
    [url release];
	
	QEntryElement *login = [[QEntryElement alloc] init];
    login.title = @"Username";
    login.key = @"username";
    login.hiddenToolbar = YES;
    login.placeholder = @"John doe";
    [main addElement:login];
    [login release];
	
    QEntryElement *password = [[QEntryElement alloc] init];
    password.title = @"Password";
    password.key = @"password";
    password.secureTextEntry = YES;
    password.hiddenToolbar = YES;
    password.placeholder = @"";
    [main addElement:password];
    [password release];
	
    [root addSection:main];
    [main release];
	
    QSection *btSection = [[QSection alloc] init];
    QButtonElement *btLogin = [[QButtonElement alloc] init];
    btLogin.title = @"Login";
    btLogin.controllerAction = @"onLogin:";
    [btSection addElement:btLogin];
    [btLogin release];
	
    [root addSection:btSection];
    [btSection release];
	
    //btSection.footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footer"]];
	
    return root;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
