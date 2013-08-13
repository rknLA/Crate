//
//  PWOAggregatedMediaItemList.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PWOMediaManagerProtocol.h"

@interface PWOAggregatedMediaItemList : NSObject <PWOMediaManager>

+ (PWOAggregatedMediaItemList *)sharedCollection;

- (NSArray *)itemsOfType:(NSString*)mediaType;
- (NSArray *)sectionsForType:(NSString *)mediaType;

- (NSArray *)artistSectionsInLibrary;
- (NSArray *)playlistSectionsInLibrary;
- (NSArray *)albumSectionsByArtist:(NSString *)artist;
- (NSArray *)songSectionsByArtist:(NSString *)artist;

@end
