//
//  PWOMediaItemsTableViewController.h
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/12/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWOMediaItemsTableViewController : UITableViewController

@property (strong, nonatomic, readonly) NSArray *dataCells;
@property (strong, nonatomic, readonly) NSArray *dataSections;

// the cell identifier should only be set by the child class
@property (strong, nonatomic) NSString *cellIdentifier;

@end
