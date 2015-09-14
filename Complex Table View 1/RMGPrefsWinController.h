//
//  RMGPrefsWinController.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/12/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AppDelegate;

@interface RMGPrefsWinController : NSWindowController
{
    AppDelegate __weak *_appDelegate;
}

@property (weak) AppDelegate *appDelegate; // Outlet established programmatically.

@end