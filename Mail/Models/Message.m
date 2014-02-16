//
//  Message.m
//  Mail
//
//  Created by Informatique on 06.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "Message.h"

#import "ConnectionManager.h"

@implementation Message {
}
+ (void)fetchMessagesInFolder:(NSString *)folder completion:(void (^)(NSArray * messages))handler
{
    NSMutableArray *messages = [NSMutableArray array];
    
    MCOIMAPMessagesRequestKind requestKind = MCOIMAPMessagesRequestKindHeaders | MCOIMAPMessagesRequestKindFlags | MCOIMAPMessagesRequestKindGmailLabels;
    MCOIndexSet *uids = [MCOIndexSet indexSetWithRange:MCORangeMake(1, UINT64_MAX)];
    ConnectionManager *connection = [ConnectionManager sharedManager];
    MCOIMAPFetchFoldersOperation *fetchFolders = [connection.session fetchAllFoldersOperation];
    [fetchFolders start:^(NSError *error, NSArray *folders) {
        
        //NSLog(@"%@",folders);
        
    }];
    MCOIMAPFetchMessagesOperation *fetchOperation = [connection.session fetchMessagesByUIDOperationWithFolder:folder requestKind:requestKind uids:uids];
    
    [fetchOperation start:^(NSError * error, NSArray * fetchedMessages, MCOIndexSet * vanishedMessages) {
        if(error) {
            NSLog(@"Error downloading message headers:%@", error);
        }
        
        for (MCOIMAPMessage *msg in fetchedMessages) {
            [messages addObject:[[Message alloc] initWithMCOIMAPMessage:msg folder:folder]];
        }
        
        handler(messages);

    }];
}
-  (id)initMessageWithTo: (NSString *)to Subject:(NSString *)subject{
    return self;
}
- (id)initWithMCOIMAPMessage:(MCOIMAPMessage *)msg folder:(NSString *)folder {
    self = [super init];
    
    MCOMessageHeader *header = [msg header];
    
    if (self) {
        MCOAddress *fromAddress = [header from];
        
        if ([[header from] displayName]) {
            _from = [NSString stringWithFormat:@"%@ <%@>",[fromAddress displayName],[fromAddress mailbox]];
        } else {
            _from = [NSString stringWithFormat:@"<%@>",[fromAddress mailbox]];
        }
        if ([header subject]) {
            _subject = [header subject];
        }
        else {
            _subject = @"-";
        }
        _uid = [msg uid];
        _folder = folder;
        
        //Message flags
        _seen = [msg flags] & MCOMessageFlagSeen;
        _replied = [msg flags] & MCOMessageFlagAnswered;
        _forwarded = [msg flags] & MCOMessageFlagForwarded;
        
    }
    return self;
}

- (void)fetchBody:(NSString *)swag completion:(void (^)(NSString * msgBody))handler{
    ConnectionManager *connection = [ConnectionManager sharedManager];
    MCOIMAPFetchContentOperation *fetchContentOperation = [connection.session fetchMessageByUIDOperationWithFolder:self.folder uid:(int)self.uid];
    
    [fetchContentOperation start:^(NSError *error,NSData *data){
        MCOMessageParser * msg = [MCOMessageParser messageParserWithData:data];
        NSString * msgBody = [msg htmlBodyRendering];
        handler(msgBody);
    }];
}

@end
