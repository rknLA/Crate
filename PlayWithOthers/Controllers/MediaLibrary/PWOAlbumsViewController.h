//
//  PWOAlbumsViewController.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOMediaItemsTableViewController.h"

@interface PWOAlbumsViewController : PWOMediaItemsTableViewController

@property (strong, nonatomic) NSString *artist;

- (id)initWithArtist:(NSString *)artist;

@end
