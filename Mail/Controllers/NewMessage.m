//
//  NewMessage.m
//  Mail
//
//  Created by David Coninckx on 08.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "NewMessage.h"

@interface NewMessage ()

@end

@implementation NewMessage

- (id)init
{
    self = [super initWithWindowNibName:@"NewMessage"];
    [self showWindow:self];
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (IBAction)attachment:(id)sender {
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    if([openPanel runModal] == NSOKButton) {
        self.attachmentFileName.stringValue = [[[openPanel URL] pathComponents] lastObject];
    };
    
    
}

@end
