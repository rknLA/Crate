//
//  PWOMediaManagerProtocol.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RCMediaManager <NSObject>

- (NSArray *)artistsInLibrary;

- (NSArray *)playlistsInLibrary;

- (NSArray *)albumsByArtist:(NSString *)artist;

- (NSArray *)songsByArtist:(NSString *)artist;

- (NSArray *)songsOnAlbum:(NSString *)album;

- (NSArray *)songsInPlaylist:(NSString *)playlist;

@end
