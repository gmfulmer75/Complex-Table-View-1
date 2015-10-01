//
//  RMGMainDisplayView.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/17/15.
//  Copyright (c) 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGMainDisplayView.h"
#import "RMGDesktopPicture.h"
#import "RMGConstsTypedef.h"

@implementation RMGMainDisplayView

#pragma mark Lifecycle Methods

- (void)awakeFromNib
{
    NSArray *singleType = [NSArray arrayWithObject:RMGDesktopPictureUTI];
    [self registerForDraggedTypes:singleType];
}

#pragma mark General Functionality

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];    
}

#pragma mark NSDraggingDestination Protocol Methods

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard *dragPasteboard = [sender draggingPasteboard];
    NSData *pictureAsData = [dragPasteboard dataForType:RMGDesktopPictureUTI];
    
    RMGDesktopPicture *picture = [NSKeyedUnarchiver unarchiveObjectWithData:pictureAsData];
    self.image = picture.pictureImage;
    
    return YES;
}

@end
