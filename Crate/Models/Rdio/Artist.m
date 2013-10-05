//
//  Artist.m
//  Crate
//
//  Created by Kevin Nelson on 10/5/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "Artist.h"


@implementation Artist

@dynamic name;
@dynamic rdioKey;
@dynamic libraryVersion;
@dynamic albums;
@dynamic tracks;

+ (Artist *)artistWithKey:(NSString *)key inContext:(NSManagedObjectContext *)context
{
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Artist"];
  NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"rdioKey like %s", key];
  [fetchRequest setPredicate:filterPredicate];
  
  NSError *fetchError;
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (results != nil && [results count]) {
    return [results objectAtIndex:0];
  }
  return nil;
}

@end
