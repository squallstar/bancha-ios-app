//
//  ContentsController.m
//  Bancha
//
//  Created by Nicholas Valbusa on 10/11/11.
//  Copyright (c) 2011 Squallstar Studio. All rights reserved.
//

#import "ContentsController.h"


@implementation ContentsController

@synthesize structure, pages, contents, types;

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

- (void)fillContentTypes {
    [pages removeAllObjects];
    [contents removeAllObjects];
    [types release];
    types = [[[NSUserDefaults standardUserDefaults] objectForKey:@"content_types"] retain];
    NSArray *keys = [types allKeys];
  
    for (NSString *key in keys) {
        if ([[[types objectForKey:key] objectForKey:@"tree"] boolValue] == 1) {
            [pages addObject:[types objectForKey:key]];
        } else {
            [contents addObject:[types objectForKey:key]];    
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"Content types";
 
    pages = [[NSMutableArray alloc] initWithCapacity:10];
    contents = [[NSMutableArray alloc] initWithCapacity:30];
    
    [self fillContentTypes];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] setDelegate:self];
    [super viewWillAppear:animated];
    
    if ([self.types count] == 0) {
        [self fillContentTypes];
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
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Pages";
    } else {
        return @"Contents";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [pages count];
    } else {
        return [contents count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *item = indexPath.section == 0 ? [pages objectAtIndex:indexPath.row] : [contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

-(void)recordsObtained:(NSArray *)records forActiveQuery:(NSString *)typeName {
    if (![records count]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No records found!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [al show];
        [al release];
        return;
    }
    
    RecordListController *recordList = [[RecordListController alloc] initWithStyle:UITableViewStylePlain];
    [recordList setRecords:records];
    [recordList setParent:self];
    
    [self.navigationController pushViewController:recordList animated:YES];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *type = indexPath.section == 0 ? [pages objectAtIndex:indexPath.row] : [contents objectAtIndex:indexPath.row];
    
    NSString *query = [NSString stringWithFormat:@"type:%@|set_list:TRUE|order_by:date_publish,DESC|limit:%i|get", [type objectForKey:@"id"], API_RECORD_RESULTS];
    
    [[[IOSBoilerplateAppDelegate sharedAppDelegate] api] getRecordsByActiveQuery:query];

}

@end
