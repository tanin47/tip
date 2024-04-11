//
//  AppDelegate.h
//  Tip
//
//  Created by Tanin Na Nakorn on 2/1/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Receiver.h"
#import "ExternalTipper.h"

#ifdef DEBUG
#import "ForTest.h"
#endif

NS_ASSUME_NONNULL_BEGIN

static NSRunningApplication* currentApplication = nil;

@interface AppDelegate : NSObject<NSApplicationDelegate, NSMenuDelegate>

@property NSStatusItem* statusItem;
@property ExternalTipper* tipper;
@property Receiver* receiver;

+ (NSRunningApplication*) getCurrentApplication;

+ (void) hide;

@end

NS_ASSUME_NONNULL_END
