//
//  LoginController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "LoginController.h"
#import "IOSBoilerplateAppDelegate.h"

@interface LoginController ()
- (void)onLogin:(QButtonElement *)buttonElement;
- (void)onAbout;

@end


@implementation LoginController

- (void)loadView {
    [super loadView];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grain.gif"]];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.bounces = NO;
    ((QuickDialogTableView *)self.tableView).styleProvider = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(onAbout)];
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintColor = nil;
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
    [self loading:NO];
    if (success) {
        NSLog(@"Login ok");
    } else {
        
    }
}


- (void)onLogin:(QButtonElement *)buttonElement {
    [self loading:YES];
    [self performSelector:@selector(loginCompleted) withObject:nil afterDelay:2.0];
}

- (void)onAbout {
    QRootElement *details = [LoginController createDetailsForm];
	
    QuickDialogController *quickform = [QuickDialogController controllerForRoot:details];
    [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:quickform] animated:YES];
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0000];
    
    if ([element isKindOfClass:[QEntryElement class]] || [element isKindOfClass:[QButtonElement class]]){
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0000];
    }   
}


+ (QRootElement *)createDetailsForm {
    QRootElement *details = [[QRootElement alloc] init];
    details.title = @"Details";
    details.controllerName = @"AboutController";
    details.grouped = YES;
    QSection *section = [[QSection alloc] initWithTitle:@"Information"];
    [section addElement:[[QTextElement alloc] initWithText:@"Here's some more info about this app."]];
    [details addSection:section];
    return details;
}

+ (QRootElement *)createLoginForm {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"LoginController";
    root.grouped = YES;
    root.title = @"Login";
	
    QSection *main = [[QSection alloc] init];
    //main.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_shadow.png"]];
	
    QEntryElement *url = [[QEntryElement alloc] init];
    url.title = @"Location";
    url.key = @"url";
    url.hiddenToolbar = YES;
    url.placeholder = @"www.example.com/admin";
    [main addElement:url];
	
	QEntryElement *login = [[QEntryElement alloc] init];
    login.title = @"Username";
    login.key = @"username";
    login.hiddenToolbar = YES;
    login.placeholder = @"admin";
    [main addElement:login];
	
    QEntryElement *password = [[QEntryElement alloc] init];
    password.title = @"Password";
    password.key = @"password";
    password.secureTextEntry = YES;
    password.hiddenToolbar = YES;
    password.placeholder = @"admin";
    [main addElement:password];
	
    [root addSection:main];
	
    QSection *btSection = [[QSection alloc] init];
    QButtonElement *btLogin = [[QButtonElement alloc] init];
    btLogin.title = @"Login";
    btLogin.controllerAction = @"onLogin:";
    [btSection addElement:btLogin];
	
    [root addSection:btSection];
	
    btSection.footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footer"]];
	
    return root;
}

@end
