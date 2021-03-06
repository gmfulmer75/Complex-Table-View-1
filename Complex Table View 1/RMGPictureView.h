//
//  RMGPictureView.h
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/21/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMGPictureView : NSImageView <NSDraggingSource>
{
    NSImage *_picture;
    NSDraggingSession *_dragSession;
}

@property (copy, nonatomic) NSImage *picture;
@property (nonatomic) NSDraggingSession *dragSession;

@end
