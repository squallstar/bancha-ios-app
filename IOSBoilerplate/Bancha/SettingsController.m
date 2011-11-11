//
//  LoginController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 04/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "SettingsController.h"
#import "IOSBoilerplateAppDelegate.h"

@interface SettingsController ()
- (void)doLogout:(QButtonElement *)buttonElement;
- (void)updateTypes:(QButtonElement *)buttonElement;
@end


@implementation SettingsController

- (void)loadView {
    [super loadView];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.bounces = NO;
    ((QuickDialogTableView *)self.tableView).styleProvider = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loading:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)updateTypes:(QButtonElement *)buttonElement {
    [self loading:YES];
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
    
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getContentTypes];
}

-(void)typesFinished:(BOOL)success {
    [self loading:NO];
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update" message:@"Content types have been renewed." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];*/
}



- (void)doLogout:(QButtonElement *)buttonElement {    
    [[IOSBoilerplateAppDelegate sharedAppDelegate] clearUserData];
    [[IOSBoilerplateAppDelegate sharedAppDelegate] switchToLogin];
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0000];
    
    if ([element isKindOfClass:[QEntryElement class]] || [element isKindOfClass:[QButtonElement class]]){
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0000];
    }
}

+ (QRootElement *)createSettingsForm {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"SettingsController";
    root.grouped = YES;
    root.title = @"Settings";
	
    QSection *main = [[QSection alloc] init];
	
    [root addSection:main];
	
    QSection *updateSection = [[QSection alloc] init];
    QSection *btSection = [[QSection alloc] init];
    
    QLabelElement *lbl = [[QLabelElement alloc] initWithTitle:@"Last update" Value:@"just now"];
    [updateSection addElement:lbl];
    
    QButtonElement *btTypes = [[QButtonElement alloc] init];
    btTypes.title = @"Update content types";
    btTypes.controllerAction = @"updateTypes:";
    [updateSection addElement:btTypes];
    
    QButtonElement *btLogin = [[QButtonElement alloc] init];
    btLogin.title = @"Logout";
    btLogin.controllerAction = @"doLogout:";
    [btSection addElement:btLogin];
	
    [root addSection:updateSection];
    [root addSection:btSection];
	
    return root;
}

@end
