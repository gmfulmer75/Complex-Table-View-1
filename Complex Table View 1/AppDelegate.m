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
#define INITIAL_COLOR_CAPACITY      5

#define ARRAY_LOWER_LIMIT           0

@interface AppDelegate ()

- (NSMutableArray *)populateDesktopPictures;

@property (weak) IBOutlet NSImageView *detailedView;
@property (weak) IBOutlet NSTextField *detailedPictName;
@property (weak) IBOutlet NSTextField *detailedCreationDate;
@property (weak) IBOutlet NSTextField *detailedLastAccessed;
@property (weak) IBOutlet NSTextField *detailedLastContentModification;
@property (weak) IBOutlet NSTableView *tableView;
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
    RMGDesktopPicture *displayPicture = [_desktopPictures objectAtIndex:0];
    
    self.detailedView.image = [displayPicture pictureImage];
    self.detailedPictName.stringValue = [displayPicture pictureName];
    
    self.detailedCreationDate.objectValue = [displayPicture creationDate];
    self.detailedLastAccessed.objectValue = [displayPicture lastAccessed];
    self.detailedLastContentModification.objectValue = [displayPicture lastModification];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

#pragma mark Action Methods

- (IBAction)incrementCurrentColor:(NSButton *)sender
{
    NSUInteger rowClicked = [self.tableView rowForView:sender];
    RMGDesktopPicture *currentPicture = [_desktopPictures objectAtIndex:rowClicked];
    
    NSUInteger colorIndex = [currentPicture colorIndex];
    NSUInteger arrayUpperLimit = [[currentPicture solidColors] count] - 1;
    
    if (colorIndex < arrayUpperLimit)
    {
        colorIndex++;
        
        [currentPicture setColorIndex:colorIndex];
        currentPicture.currentColor = [[currentPicture solidColors] objectAtIndex:colorIndex];
        
        NSIndexSet *rowIndexes = [NSIndexSet indexSetWithIndex:rowClicked];
        NSIndexSet *columnIndexes = [NSIndexSet indexSetWithIndex:1];
        
        [self.tableView reloadDataForRowIndexes:rowIndexes columnIndexes:columnIndexes];
    }
}

- (IBAction)decrementCurrentColor:(NSButton *)sender
{
    NSUInteger rowClicked = [self.tableView rowForView:sender];
    RMGDesktopPicture *currentPicture = [_desktopPictures objectAtIndex:rowClicked];
    
    NSUInteger colorIndex = [currentPicture colorIndex];
    
    if (colorIndex > ARRAY_LOWER_LIMIT)
    {
        colorIndex--;
        
        [currentPicture setColorIndex:colorIndex];
        currentPicture.currentColor = [[currentPicture solidColors] objectAtIndex:colorIndex];
        
        NSIndexSet *rowIndexes = [NSIndexSet indexSetWithIndex:rowClicked];
        NSIndexSet *columnIndexes = [NSIndexSet indexSetWithIndex:1];
        
        [self.tableView reloadDataForRowIndexes:rowIndexes columnIndexes:columnIndexes];
    }
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
                
                if ([subview.identifier isEqualToString:@"pictureName"])
                {
                    NSTextField *subviewField = (NSTextField *)subview;
                    RMGDesktopPicture *deskPicture = [_desktopPictures objectAtIndex:row];
                    
                    subviewField.stringValue = [deskPicture pictureName];
                }
                else if ([subview.identifier isEqualToString:@"solidColorView"])
                {
                    RMGDesktopPicture *picture = [_desktopPictures objectAtIndex:row];
                    NSColor *colorForView = picture.currentColor;
                    
                    RMGSolidColorView *colorView = (RMGSolidColorView *)subview;
                    colorView.solidColor = colorForView;
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

- (void)tableViewSelectionDidChange:(nonnull NSNotification *)aNotification
{
    NSTableView *tableView = [aNotification object];
    NSInteger selectedRow = [tableView selectedRow];
    
    RMGDesktopPicture *displayPicture = [_desktopPictures objectAtIndex:selectedRow];
    
    self.detailedView.image = [displayPicture pictureImage];
    self.detailedPictName.stringValue = [displayPicture pictureName];
    
    self.detailedCreationDate.objectValue = [displayPicture creationDate];
    self.detailedLastAccessed.objectValue = [displayPicture lastAccessed];
    self.detailedLastContentModification.objectValue = [displayPicture lastModification];
}

#pragma mark Class Extension Methods

- (NSMutableArray *)populateDesktopPictures
{
    NSMutableArray *pictures = [[NSMutableArray alloc] init];
    NSURL *baseURL = [NSURL fileURLWithPath:@"/Library/Desktop Pictures" isDirectory:YES];
    
    NSArray *propertyKeys = [NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLIsDirectoryKey, NSURLCreationDateKey, NSURLContentAccessDateKey, NSURLContentModificationDateKey, nil];
    
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
