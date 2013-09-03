//
//  PWOSettingsViewController.m
//  PlayWithOthers
//
//  Created by Kevin Nelson on 8/7/13.
//  Copyright (c) 2013 R. Kevin Nelson. All rights reserved.
//

#import "RCSettingsViewController.h"
#import "RCRdio.h"

@interface RCSettingsViewController ()

@end

@implementation RCSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    [self setup];
  }
  return self;
}

- (void)setup
{
  self.title = @"Settings";
  UIButton *connectRdioButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [connectRdioButton setTitle:@"Connect Rdio" forState:UIControlStateNormal];
  CGRect buttonFrame = CGRectMake(20, 20, 100, 40);
  [connectRdioButton setFrame:buttonFrame];
  [connectRdioButton addTarget:self action:@selector(linkRdioPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:connectRdioButton];
}

#pragma mark - UI Handlers
- (void)linkRdioPressed
{
  Rdio *sharedRdio = [RCRdio sharedRdio];
  [sharedRdio authorizeFromController:self];
}



@end
