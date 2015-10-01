//
//  RMGPictureView.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/21/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "RMGPictureView.h"
#import "RMGDesktopPicture.h"
#import "AppDelegate.h"

@interface RMGPictureView ()

- (NSArray *)setUpDraggingItems;

@property (weak) IBOutlet AppDelegate *appDelegate;

@end

@implementation RMGPictureView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];    
}

#pragma mark Mouse-Event Methods

- (void)mouseDown:(NSEvent *)theEvent
{
    NSArray *dragItems = [self setUpDraggingItems];
    self.dragSession = [self beginDraggingSessionWithItems:dragItems event:theEvent source:self];
}

#pragma mark NSDraggingSource Protocol Methods

- (NSDragOperation)draggingSession:(NSDraggingSession *)session
sourceOperationMaskForDraggingContext:(NSDraggingContext)context
{
    switch (context)
    {
        case NSDraggingContextWithinApplication:
            
            return NSDragOperationCopy;
            
        case NSDraggingContextOutsideApplication:
            
            return NSDragOperationNone;
    };
}

#pragma mark Class-Extension Methods

- (NSArray *)setUpDraggingItems
{
    NSInteger rowIndex = [self.appDelegate.tableView rowForView:self];
    RMGDesktopPicture *picture = [[self.appDelegate desktopPictures] objectAtIndex:rowIndex];
    
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:picture];
    dragItem.draggingFrame = [self bounds];
    
    NSArray <NSDraggingImageComponent *> *(^imageProvider)(void) = ^NSArray *(void)
    {
        NSDraggingImageComponent *imageComp = [[NSDraggingImageComponent alloc]
                                               initWithKey:NSDraggingImageComponentIconKey];
        
        imageComp.contents = picture.pictureImage;
        imageComp.frame = [self bounds];
        
        NSArray *singleImageComp = [NSArray arrayWithObject:imageComp];
        return singleImageComp;
    };
    
    dragItem.imageComponentsProvider = imageProvider;
    NSArray *singleDragItem = [NSArray arrayWithObject:dragItem];
    
    return singleDragItem;
}

@synthesize picture = _picture, dragSession = _dragSession;

@end
