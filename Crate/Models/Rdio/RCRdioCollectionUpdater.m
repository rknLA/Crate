//
//  RCRdioCollectionUpdater.m
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCRdioCollectionUpdater.h"
#import "RCRdio.h"
#import "RCRdioCollectionManager.h"

static const int RDIO_REQUEST_INCREMENT = 50;

@interface RCRdioCollectionUpdater() {
  Rdio *_rdio;
  RCRdioCollectionManager *_rdioManager;
  NSInteger _updatingToVersion;

  NSInteger _artistCount;
  NSInteger _currentArtistIndex;

  NSInteger _albumCount;
  NSInteger _currentAlbumIndex;

  NSInteger _trackCount;
  NSInteger _currentTrackIndex;

  BOOL _updating;
}

@end

@implementation RCRdioCollectionUpdater

+ (RCRdioCollectionUpdater *)sharedUpdater
{
  static RCRdioCollectionUpdater *updater = nil;
  if (updater == nil) {
    updater = [[RCRdioCollectionUpdater alloc] init];
  }
  return updater;
}

#pragma mark - Lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    _rdio = [RCRdio sharedRdio];
    [self resetState];
  }
  return self;
}

- (void)resetState
{
  _rdioManager = nil;

  _updatingToVersion = 0;
  _updating = NO;
  
  _artistCount = 0;
  _currentArtistIndex = 0;
  
  _albumCount = 0;
  _currentAlbumIndex = 0;
  
  _trackCount = 0;
  _currentTrackIndex = 0;
}


- (void)updateToVersion:(NSInteger)newVersion
{
  _updating = YES;
  _updatingToVersion = newVersion;
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger currentVersion = [defaults integerForKey:@"libraryVersion"];
  
  if (newVersion > currentVersion) {
    _rdioManager = [[RCRdioCollectionManager alloc] init];
    
    RCRdioUpdateState *updateState = [_rdioManager updateState];
    _artistCount = [updateState.artistCount integerValue];
    _currentArtistIndex = [updateState.artistsProcessed integerValue];
    
    _albumCount = [updateState.albumCount integerValue];
    _currentAlbumIndex = [updateState.albumsProcessed integerValue];
    
    _trackCount = [updateState.trackCount integerValue];
    _currentTrackIndex = [updateState.tracksProcessed integerValue];

    
    // the update method continues to call itself in pages until artists are finished,
    // then it kicks off the same update process for albums, and then tracks.
    [self updateArtistsFromIndex:_currentArtistIndex];
  } else {
    NSLog(@"Not updating, because we're already up to date.");
  }
}

#pragma mark - Update Artist routine

- (void)updateArtistsFromIndex:(NSInteger)index
{
  RDAPIRequestDelegate *rdioDelegate = [RDAPIRequestDelegate delegateToTarget:self
                                                                 loadedAction:@selector(collectionRequest:didLoadArtistData:)
                                                                 failedAction:@selector(collectionRequest:didFailWithError:)];
  [_rdio callAPIMethod:@"getArtistsInCollection"
        withParameters:@{@"extras": @"-*,artistKey,name",
                         @"start": [NSString stringWithFormat:@"%d", _currentArtistIndex],
                         @"count": [NSString stringWithFormat:@"%d", RDIO_REQUEST_INCREMENT],
                         @"v": @"20130828"}
              delegate:rdioDelegate];
}

- (void)collectionRequest:(RDAPIRequest*)request didLoadArtistData:(NSDictionary *)artistData
{
  NSLog(@"Artist data: %@", artistData);
  NSInteger total = [(NSNumber *)[artistData objectForKey:@"total"] integerValue];
  NSArray *artists = [artistData objectForKey:@"items"];
  if (artists) {
    // sanity check
    NSInteger resultCount = [artists count];
    if (_artistCount == 0) {
      _artistCount = total;
    }
    
    [_rdioManager updateArtists:artists toVersion:_updatingToVersion];

    _currentArtistIndex += resultCount;

    RCRdioUpdateState *state = [_rdioManager updateState];
    state.artistCount = [NSNumber numberWithInteger:_artistCount];
    state.artistsProcessed = [NSNumber numberWithInteger:_currentArtistIndex];
    [_rdioManager saveCollection];
    
    if (_currentArtistIndex < _artistCount) {
      [self updateArtistsFromIndex:_currentArtistIndex];
    } else {
      [self updateAlbumsFromIndex:_currentAlbumIndex];
    }
  }
}

- (void)collectionRequest:(RDAPIRequest *)request didFailWithError:(NSError *)err
{
  NSLog(@"Collection request failed. ABORT");
  NSLog(@"%@", [err localizedDescription]);
}

#pragma mark - Update Albums routine
- (void)updateAlbumsFromIndex:(NSInteger)index
{
  RDAPIRequestDelegate *rdioDelegate = [RDAPIRequestDelegate delegateToTarget:self
                                                                 loadedAction:@selector(collectionRequest:didLoadAlbumData:)
                                                                 failedAction:@selector(collectionRequest:didFailWithError:)];
  [_rdio callAPIMethod:@"getAlbumsInCollection"
        withParameters:@{@"extras": @"-*,albumKey,duration,length,rawArtistKey,name",
                         @"start": [NSString stringWithFormat:@"%d", _currentAlbumIndex],
                         @"count": [NSString stringWithFormat:@"%d", RDIO_REQUEST_INCREMENT],
                         @"v": @"20130828"}
              delegate:rdioDelegate];
}

- (void)collectionRequest:(RDAPIRequest*)request didLoadAlbumData:(NSDictionary *)albumData
{
  NSLog(@"Album data: %@", albumData);
  NSInteger total = [(NSNumber *)[albumData objectForKey:@"total"] integerValue];
  NSArray *albums = [albumData objectForKey:@"items"];
  if (albums) {
    // sanity check
    NSInteger resultCount = [albums count];
    if (_albumCount == 0) {
      _albumCount = total;
    }
    
    [_rdioManager updateAlbums:albums toVersion:_updatingToVersion];

    _currentAlbumIndex += resultCount;
    
    RCRdioUpdateState *state = [_rdioManager updateState];
    state.albumCount = [NSNumber numberWithInteger:_albumCount];
    state.albumsProcessed = [NSNumber numberWithInteger:_currentAlbumIndex];
    [_rdioManager saveCollection];
    
    if (_currentAlbumIndex < _albumCount) {
      [self updateAlbumsFromIndex:_currentAlbumIndex];
    } else {
      [self updateTracksFromIndex:_currentTrackIndex];
    }
  }
}

#pragma mark - Update Tracks routine
- (void)updateTracksFromIndex:(NSInteger)index
{
  RDAPIRequestDelegate *rdioDelegate = [RDAPIRequestDelegate delegateToTarget:self
                                                                 loadedAction:@selector(collectionRequest:didLoadTrackData:)
                                                                 failedAction:@selector(collectionRequest:didFailWithError:)];
  [_rdio callAPIMethod:@"getTracksInCollection"
        withParameters:@{@"extras": @"-*,artistKey,albumKey,key,name,duration,trackNum",
                         @"start": [NSString stringWithFormat:@"%d", _currentTrackIndex],
                         @"count": [NSString stringWithFormat:@"%d", RDIO_REQUEST_INCREMENT],
                         @"v": @"20130828"}
              delegate:rdioDelegate];
}

- (void)collectionRequest:(RDAPIRequest*)request didLoadTrackData:(NSDictionary *)trackData
{
  NSLog(@"Track data: %@", trackData);
  NSInteger total = [(NSNumber *)[trackData objectForKey:@"total"] integerValue];
  NSArray *tracks = [trackData objectForKey:@"items"];
  if (tracks) {
    // sanity check
    NSInteger resultCount = [tracks count];
    if (_trackCount == 0) {
      _trackCount = total;
    }
    
    [_rdioManager updateTracks:tracks toVersion:_updatingToVersion];
    _currentTrackIndex += resultCount;
    RCRdioUpdateState *state = [_rdioManager updateState];
    state.trackCount = [NSNumber numberWithInteger:_trackCount];
    state.tracksProcessed = [NSNumber numberWithInteger:_currentTrackIndex];
    [_rdioManager saveCollection];
    
    if (_currentTrackIndex < _trackCount) {
      [self updateTracksFromIndex:_currentTrackIndex];
    } else {
      [self completeCollectionUpdater];
    }
  }
}

#pragma mark - CoreData manipulation following API requests

- (void)completeCollectionUpdater
{
  NSLog(@"finished updating Rdio!!");
  
  // do stuff
  [_rdioManager clearUpdateState];
  [_rdioManager saveCollection];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setInteger:_updatingToVersion forKey:@"libraryVersion"];
  [defaults synchronize];
  
  // and then,
  [self resetState];
}


@end
