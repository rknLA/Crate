//
//  RCRdioArtist.m
//  Crate
//
//  Created by Kevin Nelson on 10/6/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCRdioArtist.h"
#import "RCRdioAlbum.h"
#import "RCRdioTrack.h"


@implementation RCRdioArtist

@dynamic name;
@dynamic rdioKey;
@dynamic libraryVersion;
@dynamic albums;
@dynamic tracks;

+ (RCRdioArtist *)artistWithKey:(NSString *)key inContext:(NSManagedObjectContext *)context
{
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RCRdioArtist"];
  NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"rdioKey like %s", key];
  [fetchRequest setPredicate:filterPredicate];
  
  NSError *fetchError;
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (results != nil && [results count]) {
    return [results objectAtIndex:0];
  }
  return nil;
}

+ (NSArray *)artistsInContext:(NSManagedObjectContext *)context
{
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RCRdioArtist"];
  NSError *fetchError;
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (results) {
    return results;
  } else {
    NSLog(@"ERROR FETCHING ARTISTS! %@", [fetchError localizedDescription]);
    return @[];
  }
}

@end

