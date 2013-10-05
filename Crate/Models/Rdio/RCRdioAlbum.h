//
//  RCRdioAlbum.h
//  Crate
//
//  Created by Kevin Nelson on 10/6/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCRdioArtist, RCRdioTrack;

@interface RCRdioAlbum : NSManagedObject

@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSData * artwork;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) NSSet *tracks;
@property (nonatomic, retain) RCRdioArtist *artist;
@end

@interface RCRdioAlbum (CoreDataGeneratedAccessors)

- (void)addTracksObject:(RCRdioTrack *)value;
- (void)removeTracksObject:(RCRdioTrack *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end
