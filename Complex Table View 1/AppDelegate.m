//
//  AppDelegate.m
//  Complex Table View 1
//
//  Created by Gavin Fulmer on 9/4/15.
//  Copyright © 2015 RavenWorks Media Group, L.L.C. All rights reserved.
//

#import "AppDelegate.h"
#import "RMGSolidColorView.h"
#import "RMGDesktopPicture.h"

#define SUBVIEWS_SECOND_COLUMN      4

@interface AppDelegate ()

- (NSMutableArray *)populateDesktopPictures;
@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

#pragma mark Class Methods

+ (void)initialize
{
    srandom((unsigned int)time(NULL));
}

#pragma mark Initializers

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _desktopPictures = [self populateDesktopPictures];
    }
    
    return self;
}

#pragma mark Life-Cycle Methods

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

#pragma mark Table View Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _desktopPictures.count;
}

#pragma mark Table View Delegate Methods

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *columnIdent = [tableColumn identifier];
    NSView *viewToReturn = nil;
    
    viewToReturn = [tableView makeViewWithIdentifier:columnIdent owner:self];
    
    if (viewToReturn)
    {
        NSTableCellView *cellView = (NSTableCellView *)viewToReturn;
        NSArray *cellViewSubviews = [cellView subviews];
        
        if ([columnIdent isEqualToString:@"desktopPictures"])
        {
            NSImageView *pictImageView = cellViewSubviews[0];
            RMGDesktopPicture *pictureObject = [_desktopPictures objectAtIndex:row];
            
            NSImage *imageToDisplay = [pictureObject pictureImage];
            pictImageView.image = imageToDisplay;
        }
        else if ([columnIdent isEqualToString:@"cellViewControls"])
        {
            NSView *subview;
            
            for (NSUInteger index = 0; index < SUBVIEWS_SECOND_COLUMN; index++)
            {
                subview = [cellViewSubviews objectAtIndex:index];
                
                if ([subview.identifier isEqualToString:@"solidColorView"])
                {
                    RMGDesktopPicture *picture = [_desktopPictures objectAtIndex:row];
                    NSColor *colorForView = picture.solidColor;
                    
                    RMGSolidColorView *colorView = (RMGSolidColorView *)subview;
                    colorView.solidColor = colorForView;
                }
                else if ([subview.identifier isEqualToString:@"pictureName"])
                {
                    NSTextField *subviewField = (NSTextField *)subview;
                    RMGDesktopPicture *deskPicture = [_desktopPictures objectAtIndex:row];
                    
                    subviewField.stringValue = [deskPicture pictureName];
                }
                else
                {
                    subview = nil;
                }
            }
        }
    }
    
    return viewToReturn;
}

#pragma mark Class Extension Methods

- (NSMutableArray *)populateDesktopPictures
{
    NSMutableArray *pictures = [[NSMutableArray alloc] init];
    NSURL *baseURL = [NSURL fileURLWithPath:@"/Library/Desktop Pictures" isDirectory:YES];
    
    NSArray *propertyKeys = [NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLIsDirectoryKey, NSURLCreationDateKey,
                             NSURLContentAccessDateKey, nil];
    
    NSDirectoryEnumerationOptions enumOpts = NSDirectoryEnumerationSkipsHiddenFiles;
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    NSArray *contentsAtURL = [fm contentsOfDirectoryAtURL:baseURL includingPropertiesForKeys:propertyKeys
                                                  options:enumOpts error:nil];
    
    for (NSURL *url in contentsAtURL)
    {
        RMGDesktopPicture *picture = [RMGDesktopPicture desktopPictureWithURL:url];
        
        if (!picture.isDirectory)
        {
            [pictures addObject:picture];
        }
    }
    
    return [pictures copy];
}

@synthesize desktopPictures = _desktopPictures;

@end
