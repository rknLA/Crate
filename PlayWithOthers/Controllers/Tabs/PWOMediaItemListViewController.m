//
//  PWOMediaItemListViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOMediaItemListViewController.h"
#import "PWOAggregatedMediaItemList.h"

#import "PWOArtistCell.h"
#import "PWOAlbumCell.h"
#import "PWOSongCell.h"
#import "PWOPlaylistCell.h"

@interface PWOMediaItemListViewController () {
  NSString *_mediaType;
  NSArray *_dataItems;
}

@end

@implementation PWOMediaItemListViewController

- (id)initWithMediaType:(NSString *)mediaType
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    PWOAggregatedMediaItemList *collection = [PWOAggregatedMediaItemList sharedCollection];

    _mediaType = mediaType;
    _dataItems = [collection itemsOfType:mediaType];

    self.title = _mediaType;
    
    [self.tableView registerClass:[PWOArtistCell class] forCellReuseIdentifier:@"Artists"];
    [self.tableView registerClass:[PWOAlbumCell class] forCellReuseIdentifier:@"Albums"];
    [self.tableView registerClass:[PWOSongCell class] forCellReuseIdentifier:@"Songs"];
    [self.tableView registerClass:[PWOPlaylistCell class] forCellReuseIdentifier:@"Playlists"];

  }
  return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [_dataItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_mediaType forIndexPath:indexPath];
  
  // Configure the cell...
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_mediaType];
  }
  
  NSString *cellData = [_dataItems objectAtIndex:[indexPath row]];
  
  [cell.textLabel setText:cellData];
  
  return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
