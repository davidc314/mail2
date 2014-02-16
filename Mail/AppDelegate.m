//
//  AppDelegate.m
//  Mail
//
//  Created by Informatique on 27.01.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageCellView.h"
#import <MailCore/MailCore.h>
#import "MessageDetail.h"
#import "NewMessage.h"
#import "Settings.h"
#import "ConnectionManager.h"
#import "Message.h"

@implementation AppDelegate
{
    NSMutableArray *messages;
    NSMutableArray *filter;
    
    MessageDetail *detail;
    Settings *settings;
    NewMessage *newMessage;
    
    NSTimer *refreshTimer;
    NSStatusItem *status;
}
- (id)init {
    self = [super init];
   
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
    //init status bar
    status = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [status setImage:[NSImage imageNamed:@"closedmail_64_black"]];
    
    [self refresh:nil];
    
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.inboxTable setDoubleAction:@selector(doubleClicked)];
    [self.progress startAnimation:self];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [filter count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row  {
    MessageCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    Message *message =  filter[row];
    [self.window setTitle:[NSString stringWithFormat:@"Mail (%lu)",filter.count]];
    
    cellView.fromField.stringValue = message.from;
    cellView.subjectField.stringValue = message.subject;
  
    [cellView.bullet setHidden:message.seen];
    [cellView.replied setHidden:!message.replied];
    [cellView.forwarded setHidden:!message.forwarded];
    
    return cellView;
}

- (IBAction)delete:(id)sender {
    NSIndexSet *indexSet = [self.inboxTable selectedRowIndexes];
    [messages removeObjectsAtIndexes:indexSet];
    [self.inboxTable removeRowsAtIndexes:indexSet withAnimation: NSTableViewAnimationSlideRight];
}
- (IBAction)refresh:(id)sender {
    if(![self.search stringValue]) {
        [Message fetchMessagesInFolder:@"INBOX" completion:^(NSArray *msgs) {
            messages = [[[msgs  reverseObjectEnumerator] allObjects] mutableCopy];
            filter = messages;
            [self.inboxTable reloadData];
            [self.progress stopAnimation:self];
        }];
    }
    
    [status setMenu:self.statusMenu];
}

- (void)doubleClicked
{
    if([self.inboxTable clickedRow] != -1) {
        NSInteger row = [self.inboxTable clickedRow];
        detail = [[MessageDetail alloc] initWithMessage:filter[row]];
        [detail showWindow:self];
    }
        
   
}
- (IBAction)openSettings:(id)sender {
    settings = [[Settings alloc] initWithWindowNibName:@"Settings"];
    [settings showWindow:self];
}
- (IBAction)newMessage:(id)sender {
    newMessage = [[NewMessage alloc] init];
}
- (IBAction)filter:(id)sender {
    sender = (NSSearchField *)sender;
    
    if([sender stringValue].length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(from contains[cd] %@) OR (subject contains[cd] %@)",[sender stringValue],[sender stringValue]];
        filter = [[messages filteredArrayUsingPredicate:predicate] mutableCopy];
        [self.inboxTable reloadData];
    }
    else {
        filter = messages;
        [self.inboxTable reloadData];
    }
}

@end
