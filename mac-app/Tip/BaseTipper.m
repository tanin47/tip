//
//  Tipper.m
//  Tip
//
//  Created by Tanin Na Nakorn on 5/30/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTipper.h"
#import "AppDelegate.h"

@implementation BaseTipper

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(popoverWillClose:)
                                                     name:NSPopoverWillCloseNotification
                                                   object:nil];
        self.noticeController = [[NoticeController alloc] init];
    }
    return self;
}

- (void) popoverWillClose:(NSNotification *)notification {
    if (_continuous == false) {
        [AppDelegate hide];
        [self.window close];
    }
    _continuous = false;
}

- (void) activateTip:(NSArray<NSString*>*) args {
    NSArray<TipItem*>* items;
    
    @try {
        items = [self makeTip:args];
    } @catch (NSException* error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self.noticeController updateWithItems:nil andError:error];
            [self showPopover];
        });
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            [self.tipTableController updateItems:items];
            [self.noticeController updateWithItems:items andError:nil];
            
            if (items.count == 0 && self.continuous == true) {
                self.continuous = false;
                [AppDelegate hide];
                return;
            }

            if (self.tipTableController.items.count > 0 && self.tipTableController.items[0].autoExecuteIfFirst) {
                if (self.tipTableController.items[0].type == TipItemTypeUrl) {
                    [self executeFirst];
                    return;
                } else {
                    [self performSelector:@selector(executeFirst)
                        withObject:nil
                        afterDelay:0.5];
                }
            }

            
            [self showPopover];
        } @catch (NSException* error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self.noticeController updateWithItems:nil andError:error];
            [self showPopover];
        }
    });
}

- (NSArray<TipItem *> *) makeTip: (NSArray<NSString*>*) args {
    [NSException raise:@"NotImplementedException" format:@"makeTip is not implemented"];
    return nil;
}

- (void) executeFirst {
    [_tipTableController performAction:0];
}

- (void)showPopover {
    NSPoint loc;
    if (self.continuous && self.window != nil) {
        loc = self.window.frame.origin;
    } else {
        loc = [NSEvent mouseLocation];
        loc = NSMakePoint(loc.x, loc.y - 10);
    }

    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(loc.x, loc.y, 1, 1)
                                                    styleMask:NSWindowStyleMaskBorderless
                                                      backing:NSBackingStoreBuffered
                                                        defer:NO];
    [self.window setReleasedWhenClosed:false];
    [self.window setBackgroundColor:[NSColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self.window makeKeyAndOrderFront:NSApp];

    self.popover = [[NSPopover alloc] init];
    self.popover.behavior = NSPopoverBehaviorTransient;
    self.popover.animates = YES;
    if (self.noticeController.shouldShowNotice) {
        self.popover.contentViewController = self.noticeController;
    } else {
        self.popover.contentViewController = self.tipTableController;
    }
    [self.popover showRelativeToRect:self.window.contentView.bounds
                              ofView:self.window.contentView
                       preferredEdge:NSMinYEdge];
}

@end
