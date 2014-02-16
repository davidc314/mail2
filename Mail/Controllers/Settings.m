//
//  Settings.m
//  Mail
//
//  Created by David Coninckx on 12.02.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "Settings.h"
#import "Account.h"
#import "AccountCellView.h"

@interface Settings ()

@end

@implementation Settings {
    NSMutableArray *accounts;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        [_table reloadData];
        accounts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (IBAction)newAccount:(id)sender {
    [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.table.numberOfRows] withAnimation:NSTableViewAnimationSlideUp];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return 5;
}

- (NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    AccountCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    return cellView;
}
@end
