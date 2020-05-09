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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(popoverWillClose)
                                                     name:NSPopoverWillCloseNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(popoverDidClose)
                                                     name:NSPopoverDidCloseNotification
                                                   object:nil];
    }
    return self;
}

- (void) popoverWillClose {
    // Trigger hiding in order to give the focus back to the previous app.
    // Trigger hiding during NSPopoverWillCloseNotification is slicker.
    [NSApp hide:nil];
}

- (void) popoverDidClose {
    [self.window close];
    self.window = nil;
    self.popover = nil;
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
    
    NSArray<TipItem *> * items;
    @try {
         items = [self.tipper makeTip:input];
    } @catch (NSException* error) {
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        _controller.error = error;
        [self showPopover];
        return;
    }
    _controller.items = items;
    if (items.count == 1 && items[0].executeIfOnlyOne) {
        [_controller performAction:0];
        return;
    }

    [self showPopover];
}

- (void)showPopover {
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSRect frame = NSMakeRect(mouseLoc.x, mouseLoc.y-10, 1, 1);
    self.window  = [[NSWindow alloc] initWithContentRect:frame
                                                    styleMask:NSWindowStyleMaskBorderless
                                                      backing:NSBackingStoreBuffered
                                                        defer:NO];
    [self.window setReleasedWhenClosed:false];
    [self.window setBackgroundColor:[NSColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self.window makeKeyAndOrderFront:NSApp];
    
    self.popover = [[NSPopover alloc] init];
    self.popover.contentViewController = _controller;
    self.popover.behavior = NSPopoverBehaviorTransient;
    self.popover.animates = YES;
    
    [self.popover showRelativeToRect:self.window.contentView.bounds
                              ofView:self.window.contentView
                       preferredEdge:NSMinYEdge];
}

@end
