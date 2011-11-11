//
//  RecordListController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 10/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "RecordListController.h"
#import "ContentsController.h"

@implementation RecordListController

@synthesize records, type, parent, cellNib, searchBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    selectedIndexes = [[NSMutableDictionary alloc] init];
	
	UIBarButtonItem *new = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRecord)];
	
	self.navigationItem.rightBarButtonItem = new;
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
	self.tableView.tableHeaderView = searchBar;
	
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }*/
	
	static NSString *CellIdentifier = @"RecordCell";
	RecordCell *cell = (RecordCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
		cell = (RecordCell *)[nib objectAtIndex:0];
	}
    
	[cell setClipsToBounds:YES];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    NSDictionary *record = [records objectAtIndex:indexPath.row];
    cell.title.text = [record objectForKey:[type objectForKey:@"edit_link"]];
	
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// If our cell is selected, return double height
    if([self cellIsSelected:indexPath]) {
        return 110.0;
    }
	
	return 70.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
	
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedIndexes removeAllObjects];
    [selectedIndexes setObject:selectedIndex forKey:indexPath]; 
	
    // This is where magic happens...
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

@end
