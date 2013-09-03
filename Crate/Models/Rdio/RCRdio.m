//
//  RCRdio.m
//  Crate
//
//  Created by Kevin Nelson on 9/2/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCRdio.h"
#import "RCRdioCredentials.h"

@implementation RCRdio

+ (Rdio *)sharedRdio
{
  static Rdio *_rdioInstance = nil;
  static RCRdio *_rdioWrapper = nil;
  if (_rdioWrapper == nil) {
    _rdioWrapper = [[RCRdio alloc] init];
  }

  if (_rdioInstance == nil) {
    _rdioInstance = [[Rdio alloc] initWithConsumerKey:RDIO_CONSUMER_KEY andSecret:RDIO_CONSUMER_SECRET delegate:_rdioWrapper];
  }

  return _rdioInstance;
}

#pragma mark - Rdio Delegate methods
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken
{
  NSLog(@"rdio authenticated");
}

- (void)rdioAuthorizationCancelled
{
  NSLog(@"auth was cancelled");
}

- (void)rdioAuthorizationFailed:(NSString *)error
{
  NSLog(@"auth failed with error: %@", error);
}

- (void)rdioDidLogout
{
  NSLog(@"rdio logged out");
}

@end
