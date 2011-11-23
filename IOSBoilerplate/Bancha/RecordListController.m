//
//  RecordListController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 10/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "RecordListController.h"
#import "ContentsController.h"
#import "RecordEditController.h"
#import "RecordEditNavigationController.h"

#define OPEN_HEIGHT 93.0f
#define CLOSE_HEIGHT 55.0f

@implementation RecordListController

@synthesize records, type, parent, cellNib, searchBar, alert, tableView;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
	[tableView setDataSource:self];
	[tableView setDelegate:self];
	
	[tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	
	[self.view addSubview:self.tableView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    selectedIndexes = [[NSMutableDictionary alloc] init];
	
	UIBarButtonItem *new = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRecord)];
	
	self.navigationItem.rightBarButtonItem = new;
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
	self.tableView.tableHeaderView = searchBar;
	[searchBar setDelegate:self];
	
	[searchBar setPlaceholder:@"Search by title"];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	clickedEditCell = FALSE;
    
    //We need to find the type of the first record
    if ([records count]) {
        int id_type = [[[records objectAtIndex:0] objectForKey:@"id_type"] intValue];

        NSDictionary *ctypes = [(ContentsController*)parent types];
        NSArray *keys = [ctypes allKeys];
        
        for (NSString *key in keys) {
            NSDictionary *ctype = [ctypes objectForKey:key];            
            if ([[ctype valueForKey:@"id"] intValue] == id_type) {
                self.type = ctype;
                NSLog(@"Current type is %@.", [ctype objectForKey:@"description"]);
                break;
            }
        }
		self.title = [self.type objectForKey:@"description"];
    }
	
	if (!alert) {
		alert = [[SideAlert alloc] initInFrame:self.view.frame WithTitle:@"Loading..."];
		[self.view addSubview:alert];
	}
	alert.alpha = 0;
	
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (records != nil) {
        return [records count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	static NSString *CellIdentifier = @"RecordCell";
	RecordCell *cell = (RecordCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
		cell = (RecordCell *)[nib objectAtIndex:0];
		
		[cell setDelegate:self];
        [cell prepare];
		[cell setClipsToBounds:YES];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	
    NSDictionary *record = [records objectAtIndex:indexPath.row];
    cell.title.text = [record objectForKey:[type objectForKey:@"edit_link"]];
	cell.record_id = [[record objectForKey:[type objectForKey:@"primary_key"]] intValue];
	
	if (![record objectForKey:@"published"]) {
		[cell setStage:YES];
	} else {
		[cell setStage:NO];
	}
	
	//First Row: 
	NSMutableString *first = [[NSMutableString alloc] init];
	if ([record objectForKey:@"lang"]) {
		[first appendFormat:@"Language: %@", [[record objectForKey:@"lang"] uppercaseString]];
	}
	if ([record objectForKey:@"date_publish"]) {
		[first appendFormat:@" - Published on %@", [record objectForKey:@"date_publish"]];
	}
	
	[[cell firstLine] setText:first];
    
    return cell;
}

-(void)addNewRecord {
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// If our cell is selected, return double height
    if([self cellIsSelected:indexPath]) {
        return OPEN_HEIGHT;
    }
	
	return CLOSE_HEIGHT;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView2 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
	
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedIndexes removeAllObjects];
    [selectedIndexes setObject:selectedIndex forKey:indexPath]; 
    
    [(RecordCell*)[self.tableView cellForRowAtIndexPath:indexPath] addButtons];
	
    // This is where magic happens...
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

#pragma mark - Record cell delegate

-(void)cellClickedEditButton:(int)record_id {
	clickedEditCell = TRUE;
	[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
	
	NSString *query = [NSString stringWithFormat:@"type:%@|documents:TRUE|where:%@,%i|limit:1|get", [type objectForKey:@"id"], [type objectForKey:@"primary_key"], record_id];
	
	[alert setText:@"Loading record..."];
	[alert fire];
    
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getRecordsByActiveQuery:query];
}

#pragma mark - search bar

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchB {
	[searchB resignFirstResponder];
	
	[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
	
	NSString *query = [NSString stringWithFormat:@"type:%@|like:title,%@|order_by:date_publish,DESC|set_list:TRUE|limit:%i|get", [type objectForKey:@"id"], [searchB text], API_RECORD_RESULTS];
	
	[alert setText:@"Searching..."];
	[alert fire];
    
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getRecordsByActiveQuery:query];

}



- (void)searchBar:(UISearchBar *)bar textDidChange:(NSString *)searchText {
    if(![searchBar isFirstResponder]) {
        // user tapped the 'clear' button
        shouldBeginEditing = NO;
        // do whatever I want to happen when the user clears the search...
		
		
		[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
		
		NSString *query = [NSString stringWithFormat:@"type:%@|set_list:TRUE|order_by:date_publish,DESC|limit:%i|get", [type objectForKey:@"id"], API_RECORD_RESULTS];
		
		
		
		[[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getRecordsByActiveQuery:query];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)bar {
    // reset the shouldBeginEditing BOOL ivar to YES, but first take its value and use it to return it from the method call
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

-(void)recordsObtained:(NSArray *)recs forActiveQuery:(NSString *)typeName {
	if (!clickedEditCell) {
		self.records = recs;
		[self.tableView reloadData];
	} else {
		//Edit button clicked on a cell
		clickedEditCell = FALSE;
		
		[alert removeAnimated];
		
		NSDictionary *record = [recs objectAtIndex:0];
		
		RecordEditNavigationController *editNav = [[RecordEditNavigationController alloc] initWithRootViewController:[RecordEditController controllerForRoot:[RecordEditController createFormForContentType:type andRecord:record]]];
	
		[editNav setType:self.type];
		[[editNav sections] removeAllObjects];
		[editNav setRecord:[NSDictionary dictionaryWithDictionary:record]];
		
		[self presentModalViewController:editNav animated:YES];
	}
}

@end
