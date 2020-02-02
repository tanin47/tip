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
        
        _tipper = [[ExternalTipper alloc] initWithProvider:providerPath];
        _receiver = [[Receiver alloc] initWithTipper:_tipper];
        _receiver.controller = [[TipTableController alloc] init];
        [NSApp setServicesProvider:_receiver];
    }
    return self;
}

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(terminate)
                                                 name:NSPopoverDidCloseNotification
                                               object:nil];
    
    _statusItem = [NSStatusBar.systemStatusBar statusItemWithLength:25];
           
    _statusItem.button.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
    _statusItem.button.title = @"\uf05a";
    _statusItem.button.enabled = YES;
    
    _statusItem.menu = [[NSMenu alloc] initWithTitle:@"Tip"];
    _statusItem.menu.delegate = self;
    [_statusItem.menu addItemWithTitle:@"How to setup Tip" action:@selector(openInstallationUrl) keyEquivalent:@""];
    [_statusItem.menu addItemWithTitle:@"Help & Documentation" action:@selector(openGithubProject) keyEquivalent:@""];
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

- (void)openGithubProject {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/tanin47/tip"]];
}

- (void)terminate {
    [NSApp terminate:nil];
}


@end
