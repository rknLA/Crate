//
//  PWOAlbumViewController.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/14/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAlbumViewController : UITableViewController

@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *album;

- (id)initWithArtist:(NSString *)artist andAlbumTitle:(NSString *)album;

@end
