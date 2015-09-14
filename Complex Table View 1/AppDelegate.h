//
//  AppDelegate.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/4/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RMGPrefsWinController;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>
{
    NSMutableArray *_desktopPictures;
    RMGPrefsWinController *_preferencesController;
}

- (IBAction)incrementCurrentColor:(NSButton *)sender;
- (IBAction)decrementCurrentColor:(NSButton *)sender;
- (IBAction)openPreferencesPanel:(NSMenuItem *)sender;

@property (nonatomic) NSMutableArray *desktopPictures;

@end

