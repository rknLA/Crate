//
//  PWOAlbumsViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOAlbumsViewController.h"

#import "PWOAggregatedMediaItemList.h"
#import "PWOAlbumCell.h"

@interface PWOAlbumsViewController ()

@end

@implementation PWOAlbumsViewController

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
    [self.tableView registerClass:[PWOAlbumCell class] forCellReuseIdentifier:self.cellIdentifier];
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
  PWOAggregatedMediaItemList *collection = [PWOAggregatedMediaItemList sharedCollection];
  NSArray *albums = [collection albumsByArtist:_artist];
  return albums;
}

- (NSArray *)dataSections
{
  PWOAggregatedMediaItemList *collection = [PWOAggregatedMediaItemList sharedCollection];
  NSArray *albumSections = [collection albumSectionsByArtist:_artist];
  return albumSections;
}

@end
