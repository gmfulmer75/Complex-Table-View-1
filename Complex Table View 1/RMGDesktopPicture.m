//
//  RMGDesktopPicture.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/5/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGDesktopPicture.h"
#import "RMGSolidColorView.h"
#import "RMGConstsTypedef.h"


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
            
            [pictURL getResourceValue:&returnedValue forKey:NSURLContentModificationDateKey error:nil];
            self.lastModification = returnedValue;
            
            _pictureImage = [[NSImage alloc] initWithContentsOfURL:pictURL];
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            
            NSMutableArray *colors = [[NSMutableArray alloc] init];
            
            NSNumber *randomColorCount = [standardDefaults objectForKey:RMGRandomColorCacheCountUserDefaultsKey];
            NSUInteger colorCount = [randomColorCount integerValue];
            
            for (NSUInteger index = 0; index < colorCount; index++)
            {
                [colors addObject:[self generateRandomColor]];
            }
            
            _currentColor = [colors objectAtIndex:0];
            _solidColors = [colors copy];
        }
    }
    
    return self;
}

#pragma mark General Functionality

- (void)adjustSolidColorsWithChange:(NSInteger)changeDelta
{
    NSMutableArray *colorsToAdd = [[NSMutableArray alloc] init];
    
    if (changeDelta > 0)
    {
        do {
            
            [colorsToAdd addObject:[self generateRandomColor]];
            changeDelta--;
            
        } while (changeDelta > 0);
        
        _solidColors = [_solidColors arrayByAddingObjectsFromArray:colorsToAdd];
    }
    else if (changeDelta < 0)
    {
        NSRange reducedRange = NSMakeRange(0, [_solidColors count] + changeDelta);
        _solidColors = [_solidColors subarrayWithRange:reducedRange];
    }
    
    [self setColorIndex:0];
}

#pragma mark NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_lastModification forKey:@"lastModification"];
    [aCoder encodeObject:_pictureImage forKey:@"pictureImage"];
    [aCoder encodeObject:_lastAccessed forKey:@"lastAccessed"];
    [aCoder encodeObject:_currentColor forKey:@"currentColor"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:_pictureName forKey:@"pictureName"];
    [aCoder encodeObject:_solidColors forKey:@"solidColors"];
    [aCoder encodeInteger:_colorIndex forKey:@"colorIndex"];
    [aCoder encodeBool:_isDirectory forKey:@"isDirectory"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _lastModification = [aDecoder decodeObjectForKey:@"lastModification"];
        _pictureImage = [aDecoder decodeObjectForKey:@"pictureImage"];
        _lastAccessed = [aDecoder decodeObjectForKey:@"lastAccessed"];
        _currentColor = [aDecoder decodeObjectForKey:@"currentColor"];
        _creationDate = [aDecoder decodeObjectForKey:@"creationDate"];
        _pictureName = [aDecoder decodeObjectForKey:@"pictureName"];
        _solidColors = [aDecoder decodeObjectForKey:@"solidColors"];
        _colorIndex = [aDecoder decodeIntegerForKey:@"colorIndex"];
        _isDirectory = [aDecoder decodeBoolForKey:@"isDirectory"];
    }
    
    return self;
}

#pragma mark NSPasteboardWriting Protocol Methods

- (NSArray *)writableTypesForPasteboard:(NSPasteboard *)pasteboard
{
    return nil;
}

- (id)pasteboardPropertyListForType:(NSString *)type
{
    return nil;
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
@synthesize lastAccessed = _lastAccessed, currentColor = _currentColor, isDirectory = _isDirectory;
@synthesize lastModification = _lastModification, colorIndex = _colorIndex, solidColors = _solidColors;

@end
