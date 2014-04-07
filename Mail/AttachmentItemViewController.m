//
//  AttachmentItemViewController.m
//  attachmentsCollectionView
//
//  Created by David Coninckx on 25.03.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import "AttachmentItemViewController.h"
#import "AttachmentView.h"

@interface AttachmentItemViewController ()

@end

@implementation AttachmentItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}
- (void) doubleClick:(id)sender {
    id delegate = [self.collectionView delegate];
    if([delegate respondsToSelector:@selector(doubleClick:)]) {
        [delegate doubleClick:[self representedObject]];
    }
}

@end
