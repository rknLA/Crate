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
    
    _updatingToVersion = 0;
    _updating = NO;
    
    _artistCount = 0;
    _currentArtistIndex = 0;
    
    _albumCount = 0;
    _currentAlbumIndex = 0;
    
    _trackCount = 0;
    _currentTrackIndex = 0;
  }
  return self;
}


- (void)updateToVersion:(NSInteger)newVersion
{
  _updating = YES;
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger currentVersion = [defaults integerForKey:@"libraryVersion"];
  
  if (newVersion > currentVersion) {
    // the update method continues to call itself in pages until artists are finished,
    // then it kicks off the same update process for albums, and then tracks.
    [self updateArtistsFromIndex:_currentArtistIndex];
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
  NSInteger start = [(NSNumber *)[artistData objectForKey:@"start"] integerValue];
  NSInteger total = [(NSNumber *)[artistData objectForKey:@"total"] integerValue];
  NSArray *artists = [artistData objectForKey:@"items"];
  if (artists) {
    // sanity check
    NSInteger resultCount = [artists count];
    if (_artistCount == 0) {
      _artistCount = total;
    }
    
    // TODO add items to coredata
    
    _currentArtistIndex += resultCount;
    
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
  NSInteger start = [(NSNumber *)[albumData objectForKey:@"start"] integerValue];
  NSInteger total = [(NSNumber *)[albumData objectForKey:@"total"] integerValue];
  NSArray *albums = [albumData objectForKey:@"items"];
  if (albums) {
    // sanity check
    NSInteger resultCount = [albums count];
    if (_albumCount == 0) {
      _albumCount = total;
    }
    
    // TODO add items to coredata
    
    _currentAlbumIndex += resultCount;
    
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
  NSInteger start = [(NSNumber *)[trackData objectForKey:@"start"] integerValue];
  NSInteger total = [(NSNumber *)[trackData objectForKey:@"total"] integerValue];
  NSArray *tracks = [trackData objectForKey:@"items"];
  if (tracks) {
    // sanity check
    NSInteger resultCount = [tracks count];
    if (_trackCount == 0) {
      _trackCount = total;
    }
    
    // TODO add items to coredata
    
    _currentTrackIndex += resultCount;
    
    if (_currentTrackIndex < _trackCount) {
      [self updateTracksFromIndex:_currentTrackIndex];
    } else {
      NSLog(@"finished updating Rdio!!");
    }
  }
}


@end
