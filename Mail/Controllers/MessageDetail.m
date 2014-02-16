//
//  MessageDetail.m
//  Mail
//
//  Created by Informatique on 05.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "MessageDetail.h"
#import "Message.h"

@implementation MessageDetail
{
    Message *msg;
}
- (id) initWithMessage:(Message *)message {
    self = [super initWithWindowNibName:@"MessageDetail"];
    msg = message;
    [msg fetchBody:@"test" completion:^(NSString *body){
        [[_body mainFrame] loadHTMLString:body baseURL:nil];
        [self.progress stopAnimation:self];
    }];
    return self;
}
- (void) windowDidLoad {
    self.window.title = [msg subject];
    self.from.stringValue  = [NSString stringWithFormat:@"From : %@",[msg from]];
    self.subject.stringValue = [NSString stringWithFormat:@"Subject : %@",[msg subject]];
    [self.progress startAnimation:self];
    
}
//lama451836
//grandlama
@end

