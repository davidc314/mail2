//
//  ConnectionManager.m
//  Mail
//
//  Created by Informatique on 06.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "ConnectionManager.h"
#import "Account.h"


@implementation ConnectionManager

+ (id)sharedManager {
    static ConnectionManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _accounts = [NSMutableArray array];
        Account *account = [[Account alloc] init];
        [_accounts addObject:account];
        //_imapSession = [account connectToIMAP];
        //_smtpSession = [account connectToSMTP];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



@end
