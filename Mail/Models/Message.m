//
//  Message.m
//  Mail
//
//  Created by Informatique on 06.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "Message.h"
#import "Attachment.h"
#import "ConnectionManager.h"

@implementation Message
    
- (id) init {
    self = [super init];
    _from = @"test";
    _subject = @"test";
    _date = [[NSDate alloc] init];
    
    return self;
}
-  (id)initBuildMessageWithTo: (NSArray *)to CC:(NSArray *)cc BCC:(NSArray *)bcc Subject:(NSString *)subject Body:(NSString *)body{
    self = [super init];
    _to = to;
    _bcc = bcc;
    _cc = cc;
    _subject = subject;
    _htmlBody = body;
    return self;
}
- (id)initWithMCOIMAPMessage:(MCOIMAPMessage *)msg {
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
            _subject = @"(No object)";
        }
        _uid = [msg uid];
        _date = [header date];
        
        //Message flags
        _flags = [msg flags];
        
        _seen = _flags  & MCOMessageFlagSeen;
        _replied = _flags & MCOMessageFlagAnswered;
        _forwarded = _flags & MCOMessageFlagForwarded;
        
        //Attachments
        _hasAttachments = [[msg attachments] count] > 0;
        
        if (_hasAttachments) {
            _attachments = [[NSMutableArray alloc] init];
        }
        
    }
    
    
    return self;
}


//Get message body
- (void)fetchBodyForFolder:(Folder *)folder account:(Account *)account completion:(void (^)(NSString *, NSMutableArray *))handler {
    MCOIMAPFetchContentOperation *fetchContentOperation = [account.imapSession fetchMessageByUIDOperationWithFolder:folder.name uid:(int)self.uid];
    
    [fetchContentOperation start:^(NSError *error,NSData *data){
        MCOMessageParser * msg = [MCOMessageParser messageParserWithData:data];
        MCOIMAPOperation *setFlagsSeen = [account.imapSession storeFlagsOperationWithFolder:folder.name uids:[MCOIndexSet indexSetWithIndex:self.uid] kind:MCOIMAPStoreFlagsRequestKindAdd flags:MCOMessageFlagSeen];
        
        [setFlagsSeen start:^(NSError *error){}];
        
        //Get message body
        NSString * msgBody = [msg htmlBodyRendering];
        
        //Get message attachments
        self.attachments = [NSMutableArray array];
        
        for (MCOAttachment *attachment in [msg attachments]) {
            NSData *data = [attachment data];
            NSURL *fileURL = [NSURL URLWithString:[attachment filename]];
            NSString *fileName = [[fileURL lastPathComponent] stringByDeletingPathExtension];
            Attachment *newAttachment = [[Attachment alloc] initWithName:fileName ext:[fileURL pathExtension]  size:[data length]];
            [self.attachments addObject:newAttachment];
        }
        if (error) {
            NSLog(@"Fetch body %@",error);
        }
        
        //Callback
        handler(msgBody,self.attachments);
    }];
}

//Send new message
- (void) sendMessage {
    ConnectionManager *connection = [ConnectionManager sharedManager];
    
    MCOMessageBuilder * builder = [[MCOMessageBuilder alloc] init];
    
    [[builder header] setFrom:[MCOAddress addressWithDisplayName:nil mailbox:connection.smtpSession.username]];
    [[builder header] setTo:self.to];
    [[builder header] setCc:self.cc];
    [[builder header] setBcc:self.bcc];
    [[builder header] setSubject:self.subject];
    [builder setHTMLBody:self.htmlBody];
    
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation = [connection.smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        NSLog(@"Message send");
    }];
}
- (NSString *) description {
    return [NSString stringWithFormat:@"%@/%@",self.from,self.subject];
}

@end
