//
//  RMGTableView.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 10/1/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGTableView.h"

@implementation RMGTableView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (BOOL)validateProposedFirstResponder:(NSResponder *)responder forEvent:(NSEvent *)event
{
    NSView *responderView = (NSView *)responder;
    
    if ([[responderView identifier] isEqualToString:@"deskPict"])
    {
        return YES;
    }
    
    return NO;
}

@end
