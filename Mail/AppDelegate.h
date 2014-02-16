//
//  AppDelegate.h
//  Mail
//
//  Created by Informatique on 27.01.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TableView.h"
#import "SearchField.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet TableView *inboxTable;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSProgressIndicator *progress;
@property (weak) IBOutlet SearchField *search;

@end
