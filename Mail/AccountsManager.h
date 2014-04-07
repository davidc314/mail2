//
//  AccountsManager.h
//  Mail
//
//  Created by David Coninckx on 27.03.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountsManager : NSObject

@property (strong) NSMutableArray *accounts;

+ (id)sharedManager;

- (void) addAccount;
- (void) removeAccountsAtIndexes:(NSIndexSet *)indexes;
- (BOOL) saveAccounts;

@end
