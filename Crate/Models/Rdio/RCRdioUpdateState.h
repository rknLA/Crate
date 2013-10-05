//
//  RCRdioUpdateState.h
//  Crate
//
//  Created by Kevin Nelson on 10/6/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RCRdioUpdateState : NSManagedObject

@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSNumber * albumCount;
@property (nonatomic, retain) NSNumber * albumsProcessed;
@property (nonatomic, retain) NSNumber * trackCount;
@property (nonatomic, retain) NSNumber * tracksProcessed;
@property (nonatomic, retain) NSNumber * artistCount;
@property (nonatomic, retain) NSNumber * artistsProcessed;

@end
