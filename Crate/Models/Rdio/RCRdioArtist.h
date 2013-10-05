//
//  RCRdioArtist.h
//  Crate
//
//  Created by Kevin Nelson on 10/6/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCRdioAlbum, RCRdioTrack;

@interface RCRdioArtist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) NSSet *albums;
@property (nonatomic, retain) NSSet *tracks;
@end

@interface RCRdioArtist (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(RCRdioAlbum *)value;
- (void)removeAlbumsObject:(RCRdioAlbum *)value;
- (void)addAlbums:(NSSet *)values;
- (void)removeAlbums:(NSSet *)values;

- (void)addTracksObject:(RCRdioTrack *)value;
- (void)removeTracksObject:(RCRdioTrack *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end

@interface RCRdioArtist (RCAdditions)

+ (RCRdioArtist *)artistWithKey:(NSString *)key inContext:(NSManagedObjectContext *)context;
+ (NSArray *)artistsInContext:(NSManagedObjectContext *)context;

@end