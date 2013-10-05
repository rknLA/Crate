//
//  Track.h
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album, Artist;

@interface Track : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSNumber * trackNumber;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) Album *album;
@property (nonatomic, retain) Artist *artist;

@end
