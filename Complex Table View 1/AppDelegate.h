//
//  AppDelegate.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/4/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>
{
    NSMutableArray *_desktopPictures;
}

- (IBAction)incrementCurrentColor:(NSButton *)sender;
- (IBAction)decrementCurrentColor:(NSButton *)sender;

@property (nonatomic) NSMutableArray *desktopPictures;

@end

