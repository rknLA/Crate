//
//  PWOMediaManagerProtocol.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWOMediaManagerProtocol <NSObject>

/*
 *  The NSDictionary returned by these methods should include two key-value pairs:
 *  @"sections", which is an array of the sections returned by the query,
 *  and @"items", which is an array of the actual items returned by the query.
 */

- (NSDictionary *)artistsInLibrary;

- (NSDictionary *)playlistsInLibrary;

- (NSDictionary *)albumsByArtist:(NSString *)artist;

- (NSDictionary *)songsByArtist:(NSString *)artist;

- (NSDictionary *)songsOnAlbum:(NSString *)album;

- (NSDictionary *)songsInPlaylist:(NSString *)playlist;

@end
