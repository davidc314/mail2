//
//  Account.h
//  Mail
//
//  Created by David Coninckx on 11.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface Account : NSObject

@property (strong,readonly) NSString  *name;
@property (strong,readonly) NSString  *mail;

@property (strong,readonly) NSString  *username;
@property (strong,readonly) NSString  *password;

@property (strong,readonly) NSString  *imapHostname;
@property (assign,readonly) int  imapPort;
@property (assign,readonly) MCOConnectionType imapConnectionType;

@property (strong,readonly) NSString  *smtpHostname;
@property (assign,readonly) int  smtpPort;
@property (assign,readonly) MCOConnectionType smtpConnectionType;


- (id) connectToIMAP;
@end
