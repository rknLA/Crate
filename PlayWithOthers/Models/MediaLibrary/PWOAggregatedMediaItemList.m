//
//  PWOAggregatedMediaItemList.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOAggregatedMediaItemList.h"

#import "PWOiPodMediaManager.h"

static PWOAggregatedMediaItemList *_sharedCollection = nil;

@interface PWOAggregatedMediaItemList()

@property (strong, nonatomic) NSArray *mediaSources;

@end

@implementation PWOAggregatedMediaItemList

@synthesize mediaSources = _mediaSources;

+ (PWOAggregatedMediaItemList *)sharedCollection
{
  if (!_sharedCollection) {
    _sharedCollection = [[PWOAggregatedMediaItemList alloc] init];
    _sharedCollection.mediaSources = @[
                                       [[PWOiPodMediaManager alloc] init]
                                       ];
  }

  return _sharedCollection;
}

- (NSArray *)itemsOfType:(NSString*)mediaType
{
  SEL delegateMethod;
  id methodArg = nil;
  BOOL requiresArg = NO;
  if ([@"Artists" isEqualToString:mediaType]) {
    delegateMethod = @selector(artistsInLibrary);
  } else if ([@"Albums" isEqualToString:mediaType]) {
    delegateMethod = @selector(albumsByArtist:);
    requiresArg = YES;
  } else if ([@"Songs" isEqualToString:mediaType]) {
    delegateMethod = @selector(songsByArtist:);
    requiresArg = YES;
  } else if ([@"Playlists" isEqualToString:mediaType]) {
    delegateMethod = @selector(playlistsInLibrary);
  }
  
  NSMutableArray *aggregateItems = [[NSMutableArray alloc] initWithCapacity:20];
  for (id<PWOMediaManager> source in _mediaSources) {
    NSArray *queryResults;
    if (requiresArg) {
      queryResults = [source performSelector:delegateMethod withObject:methodArg];
    } else {
      queryResults = [source performSelector:delegateMethod];
    }
    
    [aggregateItems addObjectsFromArray:queryResults];
  }
  
  return [NSArray arrayWithArray:aggregateItems];
}

- (NSArray *)sectionsForType:(NSString *)mediaType
{
  return @[@"a", @"b"];
}

#pragma mark - Media Manager protocol methods

- (NSArray *)artistsInLibrary
{
  NSMutableArray *aggregateArtists = [NSMutableArray arrayWithCapacity:20];
  for (id<PWOMediaManager>source in _mediaSources) {
    [aggregateArtists addObjectsFromArray:[source artistsInLibrary]];
  }
  return [NSArray arrayWithArray:aggregateArtists];
}

- (NSArray *)playlistsInLibrary
{
  NSMutableArray *aggregatePlaylists = [NSMutableArray arrayWithCapacity:20];
  for (id<PWOMediaManager>source in _mediaSources) {
    [aggregatePlaylists addObjectsFromArray:[source playlistsInLibrary]];
  }
  return [NSArray arrayWithArray:aggregatePlaylists];
}

- (NSArray *)albumsByArtist:(NSString *)artist
{
  NSMutableArray *aggregateAlbums = [NSMutableArray arrayWithCapacity:20];
  for (id<PWOMediaManager>source in _mediaSources) {
    [aggregateAlbums addObjectsFromArray:[source albumsByArtist:artist]];
  }
  return [NSArray arrayWithArray:aggregateAlbums];
}

- (NSArray *)songsByArtist:(NSString *)artist
{
  return nil;
}

- (NSArray *)songsOnAlbum:(NSString *)album
{
  return nil;
}

- (NSArray *)songsInPlaylist:(NSString *)playlist
{
  return nil;
}

#pragma mark - Table Sections
//- (NSArray *)artistSectionsInLibrary;
//- (NSArray *)playlistSectionsInLibrary;
//- (NSArray *)albumSectionsByArtist:(NSString *)artist;
//- (NSArray *)songSectionsByArtist:(NSString *)artist;

@end
