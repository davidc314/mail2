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
        Account *account = [[Account alloc] init];
        _session = [account connectToIMAP];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}



@end
