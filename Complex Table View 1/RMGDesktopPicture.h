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
    NSImageView *_desktopPictImage;
    NSTextField *_cellDescField;
    
    RMGSolidColorView *_solidColorView;
}

@property (nonatomic) NSImageView *desktopPictImage;
@property (copy, nonatomic) NSTextField *cellDescField;
@property (nonatomic) RMGSolidColorView *solidColorView;

@end
