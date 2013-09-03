//
//  RCRdio.h
//  Crate
//
//  Created by Kevin Nelson on 9/2/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Rdio/Rdio.h>

@interface RCRdio : NSObject <RdioDelegate>

+ (Rdio *)sharedRdio;

@end
