//
//  RMGDesktopPicture.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/5/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGDesktopPicture.h"
#import "RMGSolidColorView.h"

@interface RMGDesktopPicture ()

- (NSColor *)generateRandomColor;

@end

@implementation RMGDesktopPicture

#pragma mark Class Methods

+ (RMGDesktopPicture *)desktopPictureWithURL:(NSURL *)pictURL
{
    return [[RMGDesktopPicture alloc] initWithURL:pictURL];
}

- (RMGDesktopPicture *)initWithURL:(NSURL *)pictURL
{
    self = [super init];
    
    if (self)
    {
        NSNumber *isDirectory;
        [pictURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        id returnedValue;
        
        _isDirectory = [isDirectory boolValue];
        
        if (!_isDirectory)
        {
            [pictURL getResourceValue:&returnedValue forKey:NSURLLocalizedNameKey error:nil];
            self.pictureName = returnedValue;
            
            [pictURL getResourceValue:&returnedValue forKey:NSURLCreationDateKey error:nil];
            self.creationDate = returnedValue;
            
            [pictURL getResourceValue:&returnedValue forKey:NSURLContentAccessDateKey error:nil];
            self.lastAccessed = returnedValue;
            
            _pictureImage = [[NSImage alloc] initWithContentsOfURL:pictURL];
            _solidColor = [self generateRandomColor];
        }
    }
    
    return self;
}

#pragma mark Class Extension Methods

- (NSColor *)generateRandomColor
{
    NSColor *randomColor;
    double randomRed, randomGreen, randomBlue;
    
    randomRed = (random() % 100) / 100.0;
    randomGreen = (random() % 100) / 100.0;
    randomBlue = (random() % 100) / 100.0;
    
    randomColor = [NSColor colorWithCalibratedRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
    return randomColor;
}

@synthesize pictureName = _pictureName, pictureImage = _pictureImage, creationDate = _creationDate;
@synthesize lastAccessed = _lastAccessed, solidColor = _solidColor, isDirectory = _isDirectory;

@end
