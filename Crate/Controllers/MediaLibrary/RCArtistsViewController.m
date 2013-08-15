//
//  PWOArtistsViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCArtistsViewController.h"

#import "RCAggregatedMediaItemList.h"
#import "RCArtistCell.h"
#import "RCAlbumsViewController.h"

@interface RCArtistsViewController ()

@end

@implementation RCArtistsViewController

#pragma mark - Lifecycle
- (id)init
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    // Custom initialization
    self.cellIdentifier = @"Artist";
    self.title = @"Artists";
    [self.tableView registerClass:[RCArtistCell class] forCellReuseIdentifier:self.cellIdentifier];
    [self.tableView setDelegate:self];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data getter overrides
- (NSArray *)dataCells
{
  RCAggregatedMediaItemList *collection = [RCAggregatedMediaItemList sharedCollection];
  NSArray *artists = [collection artistsInLibrary];
  return artists;
}

- (NSArray *)dataSections
{
  RCAggregatedMediaItemList *collection = [RCAggregatedMediaItemList sharedCollection];
  NSArray *artistSections = [collection artistSectionsInLibrary];
  return artistSections;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *artistName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
  RCAlbumsViewController *artistAlbums = [[RCAlbumsViewController alloc] initWithArtist:artistName];
  [self.navigationController pushViewController:artistAlbums animated:YES];
}

@end
