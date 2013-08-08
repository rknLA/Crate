//
//  PWOAggregatedMediaItemList.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "PWOAggregatedMediaItemList.h"

static PWOAggregatedMediaItemList *_sharedCollection = nil;

@implementation PWOAggregatedMediaItemList


+ (PWOAggregatedMediaItemList *)sharedCollection
{
  if (!_sharedCollection) {
    _sharedCollection = [[PWOAggregatedMediaItemList alloc] init];
  }

  return _sharedCollection;
}

- (NSArray *)itemsOfType:(NSString*)mediaType
{
  return @[@"aaa", @"A", @"aa", @"aardvark", @"B", @"b", @"ba", @"ab"];
}

- (NSArray *)sectionsForType:(NSString *)mediaType
{
  return @[@"a", @"b"];
}

@end
