//
//  Account.m
//  Mail
//
//  Created by David Coninckx on 11.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "Account.h"

@implementation Account

- (id) init {
    _imapHostname = @"imap.gmail.com";
    _imapPort = 993;
    _username = @"lama451836@gmail.com";
    _password = @"grandlama";
    _imapConnectionType = MCOConnectionTypeTLS;
    return self;
}

- (id) connectToIMAP {
    MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
    
    [session setHostname:self.imapHostname];
    [session setPort:self.imapPort];
    [session setUsername:self.username];
    [session setPassword:self.password];
    [session setConnectionType:self.imapConnectionType];
    return session;
}

@end
