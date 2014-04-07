//
//  MenuViewController.h
//  Mail
//
//  Created by David Coninckx on 03.04.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FormatView.h"

@interface MenuViewController : NSViewController
@property (strong) NSString *label;
@property (strong) NSString *number;
@property (assign) BOOL numberHidden;

- (id) initWithLabel:(NSString *)label number:(NSUInteger)number;

@end
