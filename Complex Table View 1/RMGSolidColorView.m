//
//  RMGSolidColorView.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/4/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGSolidColorView.h"

@implementation RMGSolidColorView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [_solidColor set];
    [NSBezierPath fillRect:[self bounds]];
}

@synthesize solidColor = _solidColor;

@end
