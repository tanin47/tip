//
//  main.m
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Receiver.h"
#import "ExternalTipper.h"

#ifdef DEBUG
#import "ForTest.h"
#endif

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    NSApplication* app = NSApplication.sharedApplication;
    
    NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
    NSString* providerPath = [args stringForKey:@"provider"];
    
    if (!providerPath) {
        NSString *home = NSHomeDirectory();
        assert(home);
        providerPath = [NSString stringWithFormat:@"%@/.tip/provider", home];
    }
 
    ExternalTipper *tipper = [[ExternalTipper alloc] initWithProvider:providerPath];
    Receiver *receiver = [[Receiver alloc] initWithTipper:tipper];
    receiver.controller = [[TipTableController alloc] init];
    [NSApp setServicesProvider:receiver];

    NSStatusBar* statusBar = NSStatusBar.systemStatusBar;
    NSStatusItem *statusItem = [statusBar statusItemWithLength:25];
    
    statusItem.button.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
    statusItem.button.title = @"\uf05a";
    statusItem.button.enabled = YES;
    
    statusItem.menu = [[NSMenu alloc] initWithTitle:@"Tip"];
    [statusItem.menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    
    NSString* testInput = [args stringForKey:@"test"];
    if (testInput) {
        NSPasteboard* pboard = [NSPasteboard pasteboardWithUniqueName];
        [pboard setString:testInput forType:NSPasteboardTypeString];
        NSString *error = nil;
        [receiver openTips:pboard userData:@"" error:&error];
    }
    
#ifdef DEBUG
    NSLog(@"DEBUG MODE: Register ForTest as a URL handler for tanintip://");
    ForTest* forTest = [[ForTest alloc] init];
    [forTest registerUrlSchemeForTest];
#endif
    
    [app run];
}


void terminate() {
    [NSApp terminate:nil];
}
