//
//  ConnectionManager.h
//  Mail
//
//  Created by Informatique on 06.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>

@interface ConnectionManager : NSObject

@property (strong,readonly) MCOIMAPSession *session;

+ (id)sharedManager;
@end
