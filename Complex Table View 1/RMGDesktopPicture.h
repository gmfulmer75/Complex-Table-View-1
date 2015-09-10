//
//  RMGDesktopPicture.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/5/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RMGSolidColorView;

@interface RMGDesktopPicture : NSObject
{
    NSString *_pictureName;
    NSImage *_pictureImage;
    
    NSColor *_solidColor;
    
    NSDate *_creationDate;
    NSDate *_lastAccessed;
    
    NSDate *_lastModification;
    
    BOOL _isDirectory;
}

+ (RMGDesktopPicture *)desktopPictureWithURL:(NSURL *)pictURL;
- (RMGDesktopPicture *)initWithURL:(NSURL *)pictURL;

@property (copy, nonatomic) NSString *pictureName;
@property (copy, nonatomic) NSImage *pictureImage;

@property (copy, nonatomic) NSDate *lastModification;
@property (copy, nonatomic) NSDate *creationDate;
@property (copy, nonatomic) NSDate *lastAccessed;
@property (copy, nonatomic) NSColor *solidColor;

@property (nonatomic) BOOL isDirectory;

@end
