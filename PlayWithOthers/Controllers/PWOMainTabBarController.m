//
//  PWOMainTabBarController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOMainTabBarController.h"
#import "PWOMediaCollectionViewController.h"
#import "PWOSettingsViewController.h"

@interface PWOMainTabBarController ()

@end

@implementation PWOMainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.

  PWOMediaCollectionViewController *artistsTab = [[PWOMediaCollectionViewController alloc] initWithMediaType:@"Artists"];
  PWOMediaCollectionViewController *albumsTab = [[PWOMediaCollectionViewController alloc] initWithMediaType:@"Albums"];
  PWOMediaCollectionViewController *songsTab = [[PWOMediaCollectionViewController alloc] initWithMediaType:@"Songs"];
  PWOMediaCollectionViewController *playlistsTab = [[PWOMediaCollectionViewController alloc] initWithMediaType:@"Playlists"];

  PWOSettingsViewController *settings = [[PWOSettingsViewController alloc] init];
  
  self.viewControllers = @[artistsTab, albumsTab, songsTab, playlistsTab, settings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
