//
//  ExternalTipper.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "ExternalTipper.h"
#import "TipItem.h"
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include <assert.h>

@implementation ExternalTipper

- (NSArray<TipItem *> *) makeTip: (NSString*) input {
    NSData* output = [self execute:input];
    return [self convert:output];
}

- (NSArray<TipItem*>*) convert: (NSData*) data {
    NSError *error = nil;
    id json = [NSJSONSerialization
               JSONObjectWithData:data
               options:0
               error:&error];
    
    if (error) {
        NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        return [NSArray new];
    }
    
    if (![json isKindOfClass:[NSArray class]]) {
        NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        return [NSArray new];
    }
    
    NSMutableArray<TipItem*>* items = [NSMutableArray new];
    for (id maybeDict in (NSArray *)json) {
        if (![maybeDict isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            return [NSArray new];
        }
        
        NSDictionary* dict = (NSDictionary*)maybeDict;
        
        NSString* type = [dict objectForKey:@"type"];
        NSString* value = [dict objectForKey:@"value"];
        NSString* label = [dict objectForKey:@"label"];
        
        if (type == nil || value == nil) {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            return [NSArray new];
        }
        
        TipItem *item = [TipItem new];
        
        if ([type isEqualToString:@"url"]) {
            item.type = TipItemTypeUrl;
        } else if ([type isEqualToString:@"text"]) {
            item.type = TipItemTypeText;
        } else {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            return [NSArray new];
        }
        item.value = value;
        if (item.type == TipItemTypeText) {
            item.label = value;
        } else {
            if (label == nil) {
                NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                return [NSArray new];
            }
            item.label = label;
        }
        [items addObject:item];
    }
    
    return items;
}

- (NSData*) execute: (NSString*) input {
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = pipe.fileHandleForReading;
    
    NSTask *task = [[NSTask alloc] init];
    task.standardOutput = pipe;

    NSString *home = NSHomeDirectory();
    assert(home);
    task.launchPath = [NSString stringWithFormat:@"%@/.tip/provider", home];
    
    task.arguments = @[input];
    NSLog(@"Run: %@ with args: %@", task.launchPath, task.arguments);
    
    [task launch];
    [task waitUntilExit];
    
    NSData *output = [file readDataToEndOfFile];
    [file closeFile];
    
    return output;
}

@end
