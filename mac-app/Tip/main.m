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
#import "AppDelegate.h"

#ifdef DEBUG
#import "ForTest.h"
#endif


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
        
    #ifdef DEBUG
        NSLog(@"DEBUG MODE: Register ForTest as a URL handler for tanintip://");
        ForTest* forTest = [[ForTest alloc] init];
        [forTest registerUrlSchemeForTest];
    #endif
    
    NSApplication* app = NSApplication.sharedApplication;
    AppDelegate *delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    [app run];
}




