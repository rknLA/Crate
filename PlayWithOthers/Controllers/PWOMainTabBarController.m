//
//  PWOMainTabBarController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOMainTabBarController.h"
#import "PWOMediaNavigationController.h"
#import "PWOSettingsViewController.h"

#import "PWOArtistsViewController.h"
#import "PWOAlbumsViewController.h"
#import "PWOAlbumViewController.h" //fake SongsViewController

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

  PWOMediaNavigationController *artistsTab = [[PWOMediaNavigationController alloc] initWithRootViewController:[[PWOArtistsViewController alloc] init]];
  PWOMediaNavigationController *albumsTab = [[PWOMediaNavigationController alloc] initWithRootViewController:[[PWOAlbumsViewController alloc] initWithArtist:nil]];
  PWOMediaNavigationController *songsTab = [[PWOMediaNavigationController alloc] initWithRootViewController:[[PWOAlbumViewController alloc] initWithArtist:nil andAlbumTitle:nil]];
  PWOMediaNavigationController *playlistsTab = [[PWOMediaNavigationController alloc] initWithRootViewController:[[PWOArtistsViewController alloc] init]];

  PWOSettingsViewController *settings = [[PWOSettingsViewController alloc] init];
  
  self.viewControllers = @[artistsTab, albumsTab, songsTab, playlistsTab, settings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
