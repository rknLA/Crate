//
//  Album.h
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSData * artwork;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) NSSet *tracks;
@property (nonatomic, retain) Artist *artist;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addTracksObject:(NSManagedObject *)value;
- (void)removeTracksObject:(NSManagedObject *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end
