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



-(id) initWithName:(NSString *)name indent:(NSUInteger)indent flags:(MCOIMAPFolderFlag) flags {
    self = [super init];
    if (self) {
        _indent = indent;
        _flags = flags;
        NSString *nameWithIndent = @"";
        
        for (int i = 0; i < indent; i++) {
            nameWithIndent = [nameWithIndent stringByAppendingString:TAB];
        }
        nameWithIndent = [nameWithIndent stringByAppendingString:name];
        _name = nameWithIndent;
        _label = _name;
        
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
    return YES;
}

@end
