//
//  AccountsManager.m
//  Mail
//
//  Created by David Coninckx on 27.03.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import "AccountsManager.h"

#define FILE_NAME @"/accounts.plist"

@implementation AccountsManager

+ (id)sharedManager {
    static AccountsManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void) fetchAll {
    for (Account *account in _accounts) {
        [account fetchFolders];
    }
}


- (id)init {
    if (self = [super init]) {
        _accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:FILE_NAME];
        if (!_accounts)
            _accounts = [[NSMutableArray alloc] init];
        [self fetchAll];
    }
    return self;
}

- (void) addAccount {
    Account *newAccount  = [[Account alloc] init];
    [self.accounts addObject:newAccount];
    NSLog(@"Add new account %@",newAccount);
}

- (void) removeAccountsAtIndexes:(NSIndexSet *)indexes {
    [self.accounts removeObjectsAtIndexes:indexes];
}

- (BOOL) saveAccounts {
    return [NSKeyedArchiver archiveRootObject:self.accounts toFile:FILE_NAME];
}


@end
