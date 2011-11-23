//
//  RecordEditController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 14/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "RecordEditController.h"
#import "RecordEditNavigationController.h"
#import "IOSBoilerplateAppDelegate.h"

@interface RecordEditController ()

@end

@implementation RecordEditController



- (void)loadView {
    [super loadView];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.bounces = NO;
    ((QuickDialogTableView *)self.tableView).styleProvider = self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loading:NO];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Actions" style:UIBarButtonItemStylePlain target:self action:@selector(showActions)];	
	
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back"
									  style:UIBarButtonItemStyleBordered
									 target:nil
									 action:nil] autorelease];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0000];
    
    if ([element isKindOfClass:[QEntryElement class]] || [element isKindOfClass:[QButtonElement class]]){
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0000];
    }
}


#pragma mark - Form creation

+ (QRootElement *)createFormForContentType:(NSDictionary*)content_type andRecord:(NSDictionary*)record {
	QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"RecordEditController";
    root.grouped = YES;
    root.title = [record objectForKey:[content_type objectForKey:@"edit_link"]];
	
	
	
    QSection *main = [[QSection alloc] init];
	
    [root addSection:main];
	
    QSection *mainSection = [[QSection alloc] init];
  
    for (NSDictionary *fieldset in [content_type objectForKey:@"fieldsets"]) {
		QButtonElement *btnFieldset = [[QButtonElement alloc] init];
		btnFieldset.title = [fieldset objectForKey:@"name"];
		btnFieldset.controllerAction = @"openSection:";
		[mainSection addElement:btnFieldset];
	}
  	
    [root addSection:mainSection];
	
    return root;
}

+ (QRootElement*)createFieldsetWithName:(NSString*)fieldSetName andContentType:(NSDictionary*)content_type usingRecord:(NSDictionary*)record {
	
	NSDictionary *fields;
	
	for (NSDictionary *fieldset in [content_type objectForKey:@"fieldsets"]) {
		if ([[fieldset objectForKey:@"name"] isEqualToString:fieldSetName]) {
			fields = [fieldset objectForKey:@"fields"];
			break;
		}
	}
	
	if (fields != nil) {
		
		QRootElement *root = [[QRootElement alloc] init];
		root.controllerName = @"RecordEditController";
		root.grouped = YES;
		root.title = fieldSetName;
		
		QSection *mainSection = [[QSection alloc] init];
		
		for (NSString *fieldName in fields) {
			
			NSDictionary *field = [[content_type objectForKey:@"fields"] objectForKey:fieldName];
			
			NSString *description = [field objectForKey:@"description"];
			NSString *value = [record objectForKey:fieldName];
			
			if ([[field objectForKey:@"type"] isEqualToString:@"text"]) {
				//Input text - singleline
				QEntryElement *input;
				
				if ([[field objectForKey:@"note"] isKindOfClass:[NSString class]]) {
					input = [[QEntryElement alloc] initWithTitle:description Value:value Placeholder:[field objectForKey:@"note"]];
				} else {
					input = [[QEntryElement alloc] initWithTitle:description Value:value];
				}
			
				if (input != nil) {
					[input setKey:fieldName];
					[mainSection addElement:input];
				}
			
            } else if ([[field objectForKey:@"type"] isEqualToString:@"textarea"]
					   || [[field objectForKey:@"type"] isEqualToString:@"textarea_full"]
                       || [[field objectForKey:@"type"] isEqualToString:@"textarea_code"]) {
            
                //Textarea input
                QEntryElement *input = [[QEntryElement alloc] initWithTitle:description Value:value];
                [input setKey:fieldName];
                
                [mainSection addElement:input];
                
                
			} else if ([[field objectForKey:@"type"] isEqualToString:@"select"]
					   || [[field objectForKey:@"type"] isEqualToString:@"radio"]) {
				
				id options = [field objectForKey:@"options"];
				if (![options isKindOfClass:[NSDictionary class]]) {
					continue;
				}
				
				int selectedOption = 0;
				int i = 0;
				
				if (value != nil) {
					for (NSString *key in [options allKeys]) {
						if ([key isEqualToString:value]) {
							selectedOption = i;
							break;
						}
						i++;
					}
				}
				
				QRadioElement *select = [[QRadioElement alloc] initWithItems:[[options allValues]retain] selected:selectedOption];
				[select setGrouped:YES];
				[select setTitle:description];
				[mainSection addElement:select];
			}
		}
		
		[root addSection:mainSection];
		return root;
	}
	
	return nil;
}

-(void)openSection:(QButtonElement*)fieldset {
	
	RecordEditNavigationController *parent = (RecordEditNavigationController*)self.navigationController;
	
	if ([parent.sections objectForKey:fieldset.title] != nil) {
		//Already present
		[self.navigationController pushViewController:[parent.sections objectForKey:fieldset.title] animated:YES];
	} else {
		//Not found. Let's create a new section
		QRootElement *fieldsetRoot = [RecordEditController createFieldsetWithName:fieldset.title andContentType:parent.type usingRecord:parent.record];
		
		QuickDialogController *c = [QuickDialogController controllerForRoot:fieldsetRoot];
		[parent.sections setObject:c forKey:fieldset.title];

		[self.navigationController pushViewController:c animated:YES];
	}	
}

#pragma mark - Save and cancel data

-(void)showActions {
	UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:@"Actions"
														 delegate:self
												cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Discard all" otherButtonTitles:@"Save", @"Save and publish", nil];
	[actions showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	RecordEditNavigationController *parent = (RecordEditNavigationController*)self.navigationController;
	NSMutableDictionary *fieldsToSave = [[NSMutableDictionary alloc] init];
	
	switch (buttonIndex) {
		case 0:
			//Discard
			[self dismissModalViewControllerAnimated:YES];
			break;
			
		case 1:
			//Save
		case 2:
			//Save and publish
			for (QuickDialogController *c in [parent.sections allValues]) {
				QSection *sect = [c.root getSectionForIndex:0];
				//NSLog(@"TYPE %@", [parent type]);
				for (QElement *el in [sect elements]) {
					
					if (el.key == nil) continue;
					
					//We try to get the type of this field
					NSDictionary *field = [[[parent type] objectForKey:@"fields"] objectForKey:el.key];
					
					if ([[field objectForKey:@"type"] isEqualToString:@"text"]) {
						NSString *val = [(QEntryElement*)el textValue];
						if (val == nil) {
							val = @"";
						}
						[fieldsToSave setObject:val forKey:el.key];
					
                    } else if ([[field objectForKey:@"type"] isEqualToString:@"textarea"]
                               || [[field objectForKey:@"type"] isEqualToString:@"textarea_code"]
                               || [[field objectForKey:@"type"] isEqualToString:@"textarea_full"]) {
                        
                        NSString *val = [(QEntryElement*)el textValue];
						if (val == nil) {
							val = @"";
						}
						[fieldsToSave setObject:val forKey:el.key];
                        
                    } else if ([[field objectForKey:@"type"] isEqualToString:@"select"]
                                || [[field objectForKey:@"type"] isEqualToString:@"radio"]) {
                        
                        QRadioElement *radioEl = (QRadioElement*)el;
                        
                        NSDictionary *options = [[[[parent type] objectForKey:@"fields"] objectForKey:radioEl.key] objectForKey:@"options"];
                        if ([options count]) {
                            int selectedIndex = [radioEl selected];
                            NSString *selectedValue = [[options allKeys] objectAtIndex:selectedIndex];
                            if (selectedValue) {
                                [fieldsToSave setObject:selectedValue forKey:el.key];
                            }
                        }
                        
                    }
					
				}
			}
			
			if ([fieldsToSave count]) {
				//Saving
                NSLog(@"SAVING: %@", fieldsToSave);
				[self loading:YES];	
				
				[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
				[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] updateRecordWithId:[parent.record objectForKey:[parent.type objectForKey:@"primary_key"]] ofContentType:[[parent.type objectForKey:@"id"] intValue] updateFields:fieldsToSave publish:(buttonIndex == 2 ? YES : TRUE)];
			}
			
			break;
			
		case 3:
			//Nothing
			break;
	}
}

-(void)updateFinished:(BOOL)success {
	[self dismissModalViewControllerAnimated:YES];
}


@end
