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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    NSApplication* app = NSApplication.sharedApplication;
 
    Receiver *receiver = [[Receiver alloc] init];
    receiver.controller = [[TipTableController alloc] init];
    [NSApp setServicesProvider:receiver];

//     TipItem *item1 = [[TipItem alloc] init];
//     item1.type = TipItemTypeText;
//     item1.value = @"[first] 29 Dec 2019 06:34:03.000 PST (-0800)";
//
//    TipItem *item2 = [[TipItem alloc] init];
//    item2.type = TipItemTypeUrl;
//    item2.value = @"http://google.com";
//
//    [receiver showPopover:[NSArray arrayWithObjects:item1, item2, nil]];
//    [receiver showPopover:[NSArray arrayWithObjects:nil]];
    
    NSStatusBar* statusBar = NSStatusBar.systemStatusBar;
    
    NSStatusItem *statusItem = [statusBar statusItemWithLength:25];
    
    statusItem.button.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
    statusItem.button.title = @"\uf05a";
    statusItem.button.enabled = YES;
    
    statusItem.menu = [[NSMenu alloc] initWithTitle:@"Tip"];
    [statusItem.menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];

    [app run];
}

void terminate() {
    [NSApp terminate:nil];
}
