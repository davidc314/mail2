//
//  Folder.m
//  Mail
//
//  Created by David Coninckx on 20.03.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import "Folder.h"
#import "ConnectionManager.h"

#define GMAIL_DEFAULT_FOLDER @"[Gmail]"
#define TAB @"  "

@implementation Folder

-(id) initWithName:(NSString *)name flags:(MCOIMAPFolderFlag) flags {
    self = [super init];
    if (self) {
        _flags = flags;
        _name = name;
        _label = _name;
        _folders = [NSMutableArray array];
    }

    return self;
}
- (NSString *) description {
    return self.label;
}

- (void)fetchMessagesHeadersForAccount:(Account *)account
{
    NSLog(@"Fetching headers for account/folder:%@/%@",account,self);
    
    MCOIMAPMessagesRequestKind requestKind = MCOIMAPMessagesRequestKindHeaders | MCOIMAPMessagesRequestKindFlags | MCOIMAPMessagesRequestKindStructure;
    MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];
    MCOIMAPFetchMessagesOperation *fetchOperation = [account.imapSession fetchMessagesByUIDOperationWithFolder:self.name requestKind:requestKind uids:uids];
    
    [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
        if(error) {
            NSLog(@"Error downloading message headers for account/folder:%@/%@",account,self);
            return;
        }
        NSMutableArray *messages = [NSMutableArray array];
        NSUInteger unread = 0;
        
        for (MCOIMAPMessage *msg in fetchedMessages) {
            Message *message = [[Message alloc] initWithMCOIMAPMessage:msg];
            [messages addObject:message];
            if (!message.seen) {
                unread++;
            }
        }
        self.nbUnseenMessages = unread;
        self.messages = messages;
    }];
}

- (BOOL) isLeaf {
    return self.folders.count==0;
}
    
- (NSImage *)image {
    
    if ([self.label isEqualToString:@"Inbox"]) {
        return [NSImage imageNamed:@"inbox"];
    }
    else if ([self.label isEqualToString:@"Sent"]) {
        return [NSImage imageNamed:@"outbox"];
    }
    else if ([self.label isEqualToString:@"Trash"]) {
        return [NSImage imageNamed:@"trash"];
    }
    else if ([self.label isEqualToString:@"Drafts"]) {
        return [NSImage imageNamed:@"draft"];
    }
    else if ([self.label isEqualToString:@"Spam"]) {
        return [NSImage imageNamed:@"spam"];
    }
    else if ([self.label isEqualToString:@"Starred"]) {
        return [NSImage imageNamed:@"starred"];
    }
    else if ([self.label isEqualToString:@"Important"]) {
        return [NSImage imageNamed:@"important"];
    }
    else {
        return [NSImage imageNamed:@"open"];
    }
}
@end
