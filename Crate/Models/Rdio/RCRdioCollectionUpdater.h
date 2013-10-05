//
//  RCRdioCollectionUpdater.h
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRdioCollectionUpdater : NSObject

+ (RCRdioCollectionUpdater *)sharedUpdater;

- (void)updateToVersion:(NSInteger)newVersion;

- (NSRange)progress;

@end
