//
//  PWOMainTabBarController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCMainTabBarController.h"
#import "RCMediaNavigationController.h"
#import "RCSettingsViewController.h"

#import "RCArtistsViewController.h"
#import "RCAlbumsViewController.h"
#import "RCAlbumViewController.h" //fake SongsViewController

@interface RCMainTabBarController ()

@end

@implementation RCMainTabBarController

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

  RCMediaNavigationController *artistsTab = [[RCMediaNavigationController alloc] initWithRootViewController:[[RCArtistsViewController alloc] init]];
  RCMediaNavigationController *albumsTab = [[RCMediaNavigationController alloc] initWithRootViewController:[[RCAlbumsViewController alloc] initWithArtist:nil]];
  RCMediaNavigationController *songsTab = [[RCMediaNavigationController alloc] initWithRootViewController:[[RCAlbumViewController alloc] initWithArtist:nil andAlbumTitle:nil]];
  RCMediaNavigationController *playlistsTab = [[RCMediaNavigationController alloc] initWithRootViewController:[[RCArtistsViewController alloc] init]];

  RCSettingsViewController *settings = [[RCSettingsViewController alloc] init];
  
  self.viewControllers = @[artistsTab, albumsTab, songsTab, playlistsTab, settings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
