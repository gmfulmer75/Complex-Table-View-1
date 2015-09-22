//
//  RMGPrefsWinController.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/12/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGPrefsWinController.h"
#import "RMGDesktopPicture.h"
#import "RMGConstsTypedef.h"
#import "AppDelegate.h"

@interface RMGPrefsWinController ()

@property (weak) IBOutlet NSTextField *randomColorCountTextfield;
@property (weak) IBOutlet NSButton *makeActiveButton;

@end

@implementation RMGPrefsWinController

#pragma mark Life-Cycle Methods

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *randomColorCountDefaultValue = [defaults objectForKey:RMGRandomColorCacheCountUserDefaultsKey];
    
    [self.randomColorCountTextfield setIntegerValue:[randomColorCountDefaultValue integerValue]];
}

#pragma mark Action Methods

- (IBAction)changeRandomColorCount:(NSTextField *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *defaultCountAsNumber, *enteredCountAsNumber;
    
    defaultCountAsNumber = [defaults objectForKey:RMGRandomColorCacheCountUserDefaultsKey];
    enteredCountAsNumber = [[sender formatter] numberFromString:sender.stringValue];
    
    NSInteger defaultColorCount = [defaultCountAsNumber integerValue];
    NSInteger enteredColorCount = [enteredCountAsNumber integerValue];
    
    if (enteredColorCount > MAX_COLOR_COUNT)
    {
        NSAlert *alertToRun = [[NSAlert alloc] init];
        [alertToRun setMessageText:@"Error: Maximum of 15 items exceeded."];
        
        [alertToRun runModal];
        
        enteredColorCount = MAX_COLOR_COUNT;
        [self.randomColorCountTextfield setStringValue:@"15"];
    }
    else if (enteredColorCount < MIN_COLOR_COUNT)
    {
        NSAlert *alertToRun = [[NSAlert alloc] init];
        [alertToRun setMessageText:@"Error: cache must have one or more items."];
        
        [alertToRun runModal];
        
        enteredColorCount = MIN_COLOR_COUNT;
        [self.randomColorCountTextfield setStringValue:@"1"];
    }
    
    if (defaultColorCount != enteredColorCount)
    {
        _colorCountDelta = enteredColorCount - defaultColorCount;
        [self.makeActiveButton setEnabled:YES];
    }
}

- (IBAction)executeMakeActive:(NSButton *)sender
{
    [self.appDelegate adjustDesktopPicturesColorsWithChange:_colorCountDelta];
    [self.makeActiveButton setEnabled:NO];
    
    RMGDesktopPicture *picture = [[self.appDelegate desktopPictures] objectAtIndex:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSArray *solidColors = [picture solidColors];
    
    [defaults setObject:[NSNumber numberWithInteger:solidColors.count]
                 forKey:RMGRandomColorCacheCountUserDefaultsKey];
}

@synthesize appDelegate = _appDelegate, colorCountDelta = _colorCountDelta;

@end
