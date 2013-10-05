//
//  Artist.h
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) NSSet *albums;
@property (nonatomic, retain) NSSet *tracks;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(NSManagedObject *)value;
- (void)removeAlbumsObject:(NSManagedObject *)value;
- (void)addAlbums:(NSSet *)values;
- (void)removeAlbums:(NSSet *)values;

- (void)addTracksObject:(NSManagedObject *)value;
- (void)removeTracksObject:(NSManagedObject *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end

@interface Artist (RCAdditions)

+ (Artist *)artistWithKey:(NSString *)key inContext:(NSManagedObjectContext *)context;
+ (NSArray *)artistsInContext:(NSManagedObjectContext *)context;

@end
