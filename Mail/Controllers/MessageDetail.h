//
//  MessageDetail.h
//  Mail
//
//  Created by Informatique on 05.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "Message.h"

@interface MessageDetail : NSWindowController

@property (weak) IBOutlet WebView *body;
@property (weak) IBOutlet NSProgressIndicator *progress;
@property (weak) IBOutlet NSTextField *from;
@property (weak) IBOutlet NSTextField *subject;

- (id) initWithMessage:(Message *)message;

@end
