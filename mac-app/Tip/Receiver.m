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
        selector:@selector(popoverDidClose:)
        name:NSPopoverDidCloseNotification
        object:nil];
    
    }
    return self;
}

- (void) popoverDidClose: (NSNotification *) notification {
    NSLog(@"NSPopover has been closed");
    [NSApp stopModal];
    _controller.pboard = nil;
    _controller.popover = nil;
}

- (NSString*) readInput:(NSPasteboard*)pboard {
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if (![pboard canReadObjectForClasses:classes options:options]) {
        @throw [NSException
         exceptionWithName:@"InvalidPasteboardDataException"
         reason:@"NSPasteboard can't give string. Possible cause: the selection isn't text."
                userInfo:nil
        ];
    }
    
    return [pboard stringForType:NSPasteboardTypeString];
}

- (void)openTips:(nonnull NSPasteboard *)pboard
        userData:(nonnull NSString *)userData
           error:(NSString *_Nullable*_Nonnull)error {
    [self showPopover:pboard];
    NSLog(@"Return service.");
}

- (void)showPopover: (nonnull NSPasteboard*)pboard {
    
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSRect frame = NSMakeRect(mouseLoc.x, mouseLoc.y-10, 1, 1);
    NSWindow* window  = [[NSWindow alloc] initWithContentRect:frame
                                                    styleMask:NSWindowStyleMaskBorderless
                                                      backing:NSBackingStoreBuffered
                                                        defer:NO];
    
    [window setBackgroundColor:[NSColor blueColor]];
    [window makeKeyAndOrderFront:NSApp];
    
    @try {
        NSString* input = [self readInput:pboard];
        NSArray<TipItem *> * items = [self.tipper makeTip:input];
        _controller.items = items;
        _controller.pboard = pboard;
    }
    @catch (NSException *error) {
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        _controller.showError = YES;
    }
    NSPopover *entryPopover = [[NSPopover alloc] init];
    _controller.popover = entryPopover;
    entryPopover.contentViewController = _controller;
    entryPopover.behavior = NSPopoverBehaviorTransient;
    entryPopover.animates = YES;
    
    [entryPopover showRelativeToRect:window.contentView.bounds
                              ofView:window.contentView
                       preferredEdge:NSMinYEdge];
    // TODO: it's brittle. I can't make it focus on popover immediately.
    [NSApp runModalForWindow:window];
}

@end
