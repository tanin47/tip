//
//  ForTest.m
//  Tip
//
//  Created by Tanin Na Nakorn on 1/19/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#ifdef DEBUG

#import <Cocoa/Cocoa.h>
#import "ForTest.h"

@implementation ForTest

- (void) registerUrlSchemeForTest {
    [[NSAppleEventManager sharedAppleEventManager]
    setEventHandler:self
        andSelector:@selector(handleAppleEvent:withReplyEvent:)
      forEventClass:kInternetEventClass
         andEventID:kAEGetURL];
}

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSPasteboard* clipboard = [NSPasteboard generalPasteboard];
    [clipboard clearContents];
    [clipboard setString:[event paramDescriptorForKeyword:keyDirectObject].stringValue forType:NSPasteboardTypeString];
}

@end

#endif
