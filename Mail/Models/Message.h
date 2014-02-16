//
//  Message.h
//  Mail
//
//  Created by Informatique on 06.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface Message : NSObject

@property (assign,readonly) NSInteger uid;
@property (strong,readonly) NSString  *from;
@property (strong,readonly) NSString  *to;
@property (strong,readonly) NSString  *subject;
@property (strong,readonly) NSString  *htmlBody;
@property (strong,readonly) NSString  *folder;
@property (assign,readonly) BOOL seen;
@property (assign,readonly) BOOL replied;
@property (assign,readonly) BOOL forwarded;

+ (void)fetchMessagesInFolder:(NSString *)folder completion:(void (^)(NSArray * messages))handler;

- (id)initWithMCOIMAPMessage:(MCOIMAPMessage *)msg folder:(NSString *)folder;
- (void)fetchBody:(NSString *)swag completion:(void (^)(NSString * msgBody))handler;

@end
