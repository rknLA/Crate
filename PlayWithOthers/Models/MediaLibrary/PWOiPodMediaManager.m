//
//  PWOiPodMediaManager.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "PWOiPodMediaManager.h"

@implementation PWOiPodMediaManager


#pragma mark - PWOMediaManagerProtocol methods
- (NSArray *)artistsInLibrary
{
  MPMediaQuery *query = [MPMediaQuery artistsQuery];

  NSArray *collections = [query collections];
  NSMutableArray *artists = [NSMutableArray arrayWithCapacity:20];
  if (collections) {
    for (MPMediaItemCollection *collection in collections) {
      NSString *artist = [[collection representativeItem] valueForProperty:MPMediaItemPropertyArtist];
      NSDictionary *artistRow = @{@"title": artist};
      [artists addObject:artistRow];
    }
  }
  return [NSArray arrayWithArray:artists];
}

- (NSArray *)playlistsInLibrary
{
  // unimplemented
  return @[];
}

- (NSArray *)albumsByArtist:(NSString *)artist
{
  MPMediaQuery *query = [MPMediaQuery albumsQuery];
  
  if (artist) {
    MPMediaPropertyPredicate *artistFilter = [MPMediaPropertyPredicate predicateWithValue:artist forProperty:MPMediaItemPropertyArtist comparisonType:MPMediaPredicateComparisonEqualTo];
    [query addFilterPredicate:artistFilter];
  }
  
  NSArray *collections = [query collections];
  NSMutableArray *albums = [NSMutableArray arrayWithCapacity:20];
  if (collections) {
    for (MPMediaItemCollection *collection in collections) {
      NSString *album = [[collection representativeItem] valueForProperty:MPMediaItemPropertyAlbumTitle];
      NSString *albumArtist = [[collection representativeItem] valueForProperty:MPMediaItemPropertyAlbumArtist];
      NSDictionary *albumRow = @{@"title": album,
                                 @"subtitle": albumArtist};
      [albums addObject:albumRow];
    }
  }
  return [NSArray arrayWithArray:albums];
}

- (NSDictionary *)songsByArtist:(NSString *)artist
{
  MPMediaQuery *query = [MPMediaQuery songsQuery];
  
  if (artist) {
    MPMediaPropertyPredicate *artistFilter = [MPMediaPropertyPredicate predicateWithValue:artist forProperty:MPMediaItemPropertyArtist comparisonType:MPMediaPredicateComparisonEqualTo];
    [query addFilterPredicate:artistFilter];
  }
  
  NSArray *collections = [query collections];
  NSMutableArray *songs = [NSMutableArray arrayWithCapacity:20];
  if (collections) {
    for (MPMediaItemCollection *collection in collections) {
      NSString *song = [[collection representativeItem] valueForProperty:MPMediaItemPropertyTitle];
      [songs addObject:song];
    }
  }
  return [NSArray arrayWithArray:songs];
}

- (NSDictionary *)songsOnAlbum:(NSString *)album
{
  MPMediaQuery *query = [MPMediaQuery songsQuery];
  
  if (album) {
    MPMediaPropertyPredicate *albumFilter = [MPMediaPropertyPredicate predicateWithValue:album forProperty:MPMediaItemPropertyAlbumTitle comparisonType:MPMediaPredicateComparisonEqualTo];
    [query addFilterPredicate:albumFilter];
  }
  
  NSArray *collections = [query collections];
  NSMutableArray *songs = [NSMutableArray arrayWithCapacity:20];
  if (collections) {
    for (MPMediaItemCollection *collection in collections) {
      NSString *song = [[collection representativeItem] valueForProperty:MPMediaItemPropertyTitle];
      [songs addObject:song];
    }
  }
  return [NSArray arrayWithArray:songs];
}

- (NSDictionary *)songsInPlaylist:(NSString *)playlist
{
  return nil;
}

@end
