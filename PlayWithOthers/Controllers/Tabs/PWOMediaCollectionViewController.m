//
//  PWOMediaCollectionViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOMediaCollectionViewController.h"

#import "PWOMediaItemListViewController.h"

@interface PWOMediaCollectionViewController () {
  NSString *_mediaType;
}

@end

@implementation PWOMediaCollectionViewController


- (id)initWithMediaType:(NSString *)mediaType
{
  PWOMediaItemListViewController *itemListController = [[PWOMediaItemListViewController alloc] initWithMediaType:mediaType];
  self = [super initWithRootViewController:itemListController];
  if (self) {
    _mediaType = mediaType;
    
    self.title = _mediaType;
    
    [itemListController.tableView setDelegate:self];
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

#pragma mark - Settings bar button item handler
- (void)settingsPressed
{
  NSLog(@"User pressed settings.");
}

#pragma mark - UITableViewDelegate methods



@end
