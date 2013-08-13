//
//  PWOArtistsViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOArtistsViewController.h"

#import "PWOAggregatedMediaItemList.h"
#import "PWOArtistCell.h"

@interface PWOArtistsViewController ()

@end

@implementation PWOArtistsViewController

#pragma mark - Lifecycle
- (id)init
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    // Custom initialization
    self.cellIdentifier = @"Artist";
    self.title = @"Artists";
    [self.tableView registerClass:[PWOArtistCell class] forCellReuseIdentifier:self.cellIdentifier];
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
  NSArray *artists = [collection artistsInLibrary];
  return artists;
}

- (NSArray *)dataSections
{
  PWOAggregatedMediaItemList *collection = [PWOAggregatedMediaItemList sharedCollection];
  NSArray *artistSections = [collection artistSectionsInLibrary];
  return artistSections;
}

@end
