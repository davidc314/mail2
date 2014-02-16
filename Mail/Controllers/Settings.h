//
//  Settings.h
//  Mail
//
//  Created by David Coninckx on 12.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Settings : NSWindowController <NSTableViewDataSource,NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *table;

@end
