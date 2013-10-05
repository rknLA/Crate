//
//  RCRdioCollectionManager.h
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCMediaManagerProtocol.h"

#import "RCRdioUpdateState.h"

@interface RCRdioCollectionManager : NSObject <RCMediaManager>

- (RCRdioUpdateState *)updateState;
- (void)clearUpdateState;

- (void)updateArtists:(NSArray *)artistsData toVersion:(NSInteger)version;
- (void)updateAlbums:(NSArray *)albumsData toVersion:(NSInteger)version;
- (void)updateTracks:(NSArray *)tracksData toVersion:(NSInteger)version;

- (void)saveCollection;

@end
