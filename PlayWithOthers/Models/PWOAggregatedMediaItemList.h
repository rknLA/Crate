//
//  PWOAggregatedMediaItemList.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWOAggregatedMediaItemList : NSObject <UITableViewDataSource>

+ (PWOAggregatedMediaItemList *)sharedCollection;

- (NSArray *)itemsOfType:(NSString*)mediaType;
- (NSArray *)sectionsForType:(NSString *)mediaType;

@end
