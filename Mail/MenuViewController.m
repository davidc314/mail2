//
//  MenuViewController.m
//  Mail
//
//  Created by David Coninckx on 03.04.14.
//  Copyright (c) 2014 Coninckx. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id) initWithLabel:(NSString *)label number:(NSUInteger)number {
    self = [super initWithNibName:@"MenuViewController" bundle:nil];
    
    _label = label;
    _number = [NSString stringWithFormat:@"%lu",number];
    
    if (number > 0) {
        _numberHidden = NO;
    }
    else {
        _numberHidden = YES;
    }
    
    return self;
}

@end
