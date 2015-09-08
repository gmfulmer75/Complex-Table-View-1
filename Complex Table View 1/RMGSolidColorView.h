//
//  RMGSolidColorView.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/4/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMGSolidColorView : NSView
{
    NSColor *_solidColor;
}

@property (copy, nonatomic) NSColor *solidColor;

@end
