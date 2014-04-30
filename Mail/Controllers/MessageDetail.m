//
//  MessageDetail.m
//  Mail
//
//  Created by Informatique on 05.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "MessageDetail.h"

@implementation MessageDetail
{
    Message *msg;
}
- (id) initWithMessage:(Message *)message folder:(Folder *)folder account:(Account *)account {
    self = [super initWithWindowNibName:@"MessageDetail"];
    msg = message;

    [msg fetchBodyForFolder:folder account:account completion:^(NSString *msgBody, NSMutableArray *attachments) {
        [[_body mainFrame] loadHTMLString:msgBody baseURL:nil];
        [self.progress stopAnimation:self];
        [self.progress setHidden:YES];
        self.attachments = attachments;
    }]; 
    
    return self;
}
- (void) windowDidLoad {
    self.window.title = [msg subject];
    self.from.stringValue  = [msg from];
    self.subject.stringValue = [msg subject];
    [self.progress startAnimation:self];
}

-(IBAction)attachmentPopupMenu:(id)sender {
    NSLog(@"Popup");
    
    NSRect frame = [(NSButton *)sender frame];
    NSPoint menuOrigin = [[(NSButton *)sender superview] convertPoint:
                          NSMakePoint(frame.origin.x, frame.origin.y+self.attachmentPopupMenu.size.height+frame.size.height) toView:nil];
    
    NSEvent *event =  [NSEvent mouseEventWithType:NSLeftMouseDown
                                         location:menuOrigin
                                    modifierFlags:NSLeftMouseDownMask
                                        timestamp:0
                                     windowNumber:[[(NSButton *)sender window] windowNumber]
                                          context:[[(NSButton *)sender window] graphicsContext]
                                      eventNumber:0
                                       clickCount:1
                                         pressure:1];
    
    for (NSMenuItem *item in self.attachmentPopupMenu.itemArray) {
        [item.image setTemplate:YES];
    }
    
    [NSMenu popUpContextMenu:self.attachmentPopupMenu withEvent:event forView:(NSButton *)sender];
}
- (IBAction)openAttachment:(id)sender {
    
}
- (IBAction)saveAttachment:(id)sender {
}
@end

