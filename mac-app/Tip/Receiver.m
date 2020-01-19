//
//  EncryptorClass.m
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "Receiver.h"
#import <AppKit/NSPasteboard.h>
#import <Cocoa/Cocoa.h>
#import "Tipper.h"
#import "ExternalTipper.h"

@implementation Receiver

- (id)initWithTipper:(ExternalTipper *)tipper_ {
    self = [super init];
    if (self) {
        self.tipper = tipper_;
    }
    return self;
}

- (NSString*) readInput:(NSPasteboard*)pboard
               userData:(NSString *)userData
                  error:(NSString **)error {
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if (![pboard canReadObjectForClasses:classes options:options]) {
        *error = @"Error: NSPasteboard can't give string.";
        return nil;
    }
    
    return [pboard stringForType:NSPasteboardTypeString];
}

- (void)openTips:(nonnull NSPasteboard *)pboard
        userData:(nonnull NSString *)userData
           error:(NSString *_Nullable*_Nonnull)error {
    NSString *input = [self readInput:pboard userData:userData error:error];
    
    if (!input) {
        return;
    }
    
    [self showPopover:[self.tipper makeTip:input]];
}

- (void)showPopover: (NSArray<TipItem *> *) items {
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSRect frame = NSMakeRect(mouseLoc.x, mouseLoc.y-10, 1, 1);
    NSWindow* window  = [[NSWindow alloc] initWithContentRect:frame
                                                    styleMask:NSWindowStyleMaskBorderless
                                                      backing:NSBackingStoreBuffered
                                                        defer:NO];
    [window setBackgroundColor:[NSColor blueColor]];
    [window makeKeyAndOrderFront:NSApp];
    
    _controller.items = items;
    NSPopover *entryPopover = [[NSPopover alloc] init];
    entryPopover.contentViewController = _controller;
    entryPopover.behavior = NSPopoverBehaviorTransient;
    entryPopover.animates = YES;
    
    [entryPopover showRelativeToRect:window.contentView.bounds
                              ofView:window.contentView
                       preferredEdge:NSMinYEdge];
}

@end
