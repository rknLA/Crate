//
//  RCRdioTrack.h
//  Crate
//
//  Created by Kevin Nelson on 10/6/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCRdioAlbum, RCRdioArtist;

@interface RCRdioTrack : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * rdioKey;
@property (nonatomic, retain) NSNumber * trackNumber;
@property (nonatomic, retain) NSNumber * libraryVersion;
@property (nonatomic, retain) RCRdioAlbum *album;
@property (nonatomic, retain) RCRdioArtist *artist;

@end
