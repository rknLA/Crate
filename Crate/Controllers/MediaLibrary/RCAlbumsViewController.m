//
//  PWOAlbumsViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCAlbumsViewController.h"

#import "RCAggregatedMediaItemList.h"
#import "RCAlbumCell.h"
#import "RCAlbumViewController.h"

@interface RCAlbumsViewController ()

@end

@implementation RCAlbumsViewController

@synthesize artist = _artist;

#pragma mark - Lifecycle
// filter albums shown by the artist provided.
- (id)initWithArtist:(NSString *)artist
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    // Custom initialization
    self.cellIdentifier = @"Album";
    if (artist) {
      self.title = artist;
    } else {
      self.title = @"Albums";
    }
    _artist = artist;
    [self.tableView registerClass:[RCAlbumCell class] forCellReuseIdentifier:self.cellIdentifier];
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
  NSArray *albums = [collection albumsByArtist:_artist];
  return albums;
}

- (NSArray *)dataSections
{
  RCAggregatedMediaItemList *collection = [RCAggregatedMediaItemList sharedCollection];
  NSArray *albumSections = [collection albumSectionsByArtist:_artist];
  return albumSections;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *albumName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
  RCAlbumViewController *albumView = [[RCAlbumViewController alloc] initWithArtist:_artist andAlbumTitle:albumName];
  [self.navigationController pushViewController:albumView animated:YES];
}

@end
