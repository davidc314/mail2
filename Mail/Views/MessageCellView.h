//
//  CellView.h
//  Mail
//
//  Created by Informatique on 27.01.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MessageCellView : NSTableCellView

@property IBOutlet NSTextField *fromField;
@property IBOutlet NSTextField *subjectField;
@property IBOutlet NSImageView *bullet;
@property IBOutlet NSImageView *forwarded;
@property IBOutlet NSImageView *replied;

@end
