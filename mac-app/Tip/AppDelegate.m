//
//  AppDelegate.m
//  Tip
//
//  Created by Tanin Na Nakorn on 2/1/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import "AppDelegate.h"
#import <Cocoa/Cocoa.h>

#ifdef DEBUG
#import "ForTest.h"
#endif


@implementation AppDelegate

- (instancetype) init {
    if (self = [super init]) {
        NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
        NSString* providerPath = [args stringForKey:@"provider"];
        
        if (!providerPath) {
            NSURL *scriptsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSApplicationScriptsDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
            providerPath = [NSString stringWithFormat:@"%@/provider.script", scriptsDirectory.path];
        }
    }
    return self;
}

- (void) setCurrentApplication:(NSNotification*) notif {
    currentApplication = [notif.userInfo objectForKey:NSWorkspaceApplicationKey];
}

+ (NSRunningApplication*) getCurrentApplication {
    return currentApplication;
}

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
    _statusItem = [NSStatusBar.systemStatusBar statusItemWithLength:25];
           
    _statusItem.button.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
    _statusItem.button.title = @"\uf05a";
    _statusItem.button.enabled = YES;
    
    _statusItem.menu = [[NSMenu alloc] initWithTitle:@"Tip"];
    _statusItem.menu.delegate = self;
    [_statusItem.menu addItemWithTitle:@"How to setup Tip" action:@selector(openInstallationUrl) keyEquivalent:@""];
    [_statusItem.menu addItemWithTitle:@"Help & Documentation" action:@selector(openGithubProject) keyEquivalent:@""];
    [_statusItem.menu addItem:NSMenuItem.separatorItem];
    [_statusItem.menu addItemWithTitle:@"Hide this menu" action:@selector(hideStatusItem) keyEquivalent:@""];
    [_statusItem.menu addItem:NSMenuItem.separatorItem];
    [_statusItem.menu addItemWithTitle:@"Quit" action:@selector(terminate) keyEquivalent:@""];
    
    NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
    NSString* testInput = [args stringForKey:@"test"];
    if (testInput) {
        NSPasteboard* pboard = [NSPasteboard pasteboardWithUniqueName];
        [pboard setString:testInput forType:NSPasteboardTypeString];
        NSString *error = nil;
        [_receiver openTips:pboard userData:@"" error:&error];
    }
}
 
- (void)openInstallationUrl {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/tanin47/tip#installation"]];
}

- (void) hideStatusItem {
    _statusItem.visible = NO;
}

- (void)openGithubProject {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/tanin47/tip"]];
}

- (void)terminate {
    [NSApp terminate:nil];
}

+ (void) hide {
    // Trigger hiding in order to give the focus back to the previous app.
    // Trigger hiding during NSPopoverWillCloseNotification is slicker.
    [NSApp hide:nil];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    // Tip.app is activated by user double-clicking on the binary.
    // If it's activated by Mac's service, the tooltip will show.
    // This means there's a window in orderedWindows.
    if ([NSApp orderedWindows].count == 0) {
        _statusItem.visible = YES;
    }
}

@end
