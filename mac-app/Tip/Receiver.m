//
//  EncryptorClass.m
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "AppDelegate.h"
#import "Receiver.h"
#import <AppKit/NSPasteboard.h>
#import <Cocoa/Cocoa.h>
#import "BaseTipper.h"
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

    NSMutableArray<NSString*>* args = [NSMutableArray arrayWithObject:input];
    NSRunningApplication* currentApplication = [AppDelegate getCurrentApplication];
    
    if (currentApplication != nil) {
        [args addObject:@"--bundle-identifier"];
        [args addObject:currentApplication.bundleIdentifier];
    }
    [self.tipper activateTip:args];
}

@end
