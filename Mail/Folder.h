//
//  Folder.h
//  Mail
//
//  Created by David Coninckx on 20.03.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/MailCore.h>
#import "Message.h"

@interface Folder : NSObject

@property (strong) NSString *label;
@property (strong) NSString *name;
@property (assign) NSUInteger indent;
@property (nonatomic,assign) MCOIMAPFolderFlag flags;

@property (strong) NSMutableArray *messages;
@property (assign) NSUInteger nbUnseenMessages;

- (id) initWithName:(NSString *)name indent:(NSUInteger)indent flags:(MCOIMAPFolderFlag) flags;
- (void)fetchMessagesHeadersForAccount:(Account *)account;

@end
