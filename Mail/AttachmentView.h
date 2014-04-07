//
//  AttachmentView.h
//  attachmentsCollectionView
//
//  Created by Informatique on 17.03.14.
//  Copyright (c) 2014 Informatique. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AttachmentViewDelegate <NSObject>

- (void) doubleClick:(id)sender ;

@end

@interface AttachmentView : NSView
@property IBOutlet id delegate;
@end
