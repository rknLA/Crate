//
//  RCRdio.m
//  Crate
//
//  Created by Kevin Nelson on 9/2/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCRdio.h"
#import "RCRdioCredentials.h"
#import "RCRdioCollectionUpdater.h"

static NSString * const kRdioAccessTokenDefaultsKey = @"rdioAccessToken";

@interface RCRdio() {
  NSString *_accessToken;
}

@property (strong, nonatomic) Rdio *rdio;

@end

@implementation RCRdio

@synthesize rdio = _rdio;

// singleton
+ (Rdio *)sharedRdio
{
  static RCRdio *_rdioWrapper = nil;
  if (_rdioWrapper == nil) {
    _rdioWrapper = [[RCRdio alloc] init];
  }
  
  return _rdioWrapper.rdio;
}

#pragma mark - Lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    _rdio = [[Rdio alloc] initWithConsumerKey:RDIO_CONSUMER_KEY andSecret:RDIO_CONSUMER_SECRET delegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    /* login to rdio if there's a token available */
    NSString *token = [defaults stringForKey:kRdioAccessTokenDefaultsKey];
    if (token) {
      _accessToken = token;
      [_rdio authorizeUsingAccessToken:_accessToken];
    }
  }
  return self;
}

#pragma mark - Rdio Delegate methods
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken
{
  NSLog(@"rdio authenticated");
  if (![_accessToken isEqualToString:accessToken]) {
    NSLog(@"Saving access token");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:kRdioAccessTokenDefaultsKey];
    [defaults synchronize];
    _accessToken = [defaults stringForKey:kRdioAccessTokenDefaultsKey];
  } else {
    NSLog(@"used stored access token");
  }
  
  id userLibraryString = [user objectForKey:@"libraryVersion"];
  if (userLibraryString && [userLibraryString isKindOfClass:[NSNumber class]]) {
    NSInteger libraryVersion = [(NSNumber *)userLibraryString integerValue];
    RCRdioCollectionUpdater *updater = [RCRdioCollectionUpdater sharedUpdater];
    [updater updateToVersion:libraryVersion];
  }
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
