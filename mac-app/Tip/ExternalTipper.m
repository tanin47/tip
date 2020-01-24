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

-(id)initWithProvider:(NSString *)provider_ 
{
    self = [super init];
    if (self) {
        self.provider = provider_;
    }
    return self;
}

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
    
    NSException* exception = [NSException
                              exceptionWithName:@"MalformedJsonException"
                              reason:@"JSON is malformed"
                              userInfo:[NSDictionary
                                        dictionaryWithObject:[[NSString alloc] initWithData:data                                encoding:NSUTF8StringEncoding]
                                        forKey:@"json"]
                              ];
    
    if (error) {
        NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        @throw exception;
    }
    
    if (![json isKindOfClass:[NSArray class]]) {
        NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        @throw exception;
    }
    
    NSMutableArray<TipItem*>* items = [NSMutableArray new];
    for (id maybeDict in (NSArray *)json) {
        if (![maybeDict isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            @throw exception;
        }
        
        NSDictionary* dict = (NSDictionary*)maybeDict;
        
        NSString* type = [dict objectForKey:@"type"];
        NSString* value = [dict objectForKey:@"value"];
        NSString* label = [dict objectForKey:@"label"];
        
        if (type == nil || value == nil) {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            @throw exception;
        }
        
        TipItem *item = [TipItem new];
        
        if ([type isEqualToString:@"url"]) {
            item.type = TipItemTypeUrl;
        } else if ([type isEqualToString:@"text"]) {
            item.type = TipItemTypeText;
        } else {
            NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            @throw exception;
        }
        item.value = value;
        if (item.type == TipItemTypeText) {
            item.label = value;
        } else {
            if (label == nil) {
                NSLog(@"Malformed JSON: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                @throw exception;
            }
            item.label = label;
        }
        [items addObject:item];
    }
    
    return items;
}

- (NSData*) execute: (NSString*) input {
    NSPipe* outputPipe = [NSPipe pipe];
    NSPipe* errorPipe = [NSPipe pipe];
    
    NSTask *task = [[NSTask alloc] init];
    task.standardOutput = outputPipe;
    task.standardError = errorPipe;
    
    task.launchPath = self.provider;
    
    if (![self fileExists:task.launchPath]) {
        @throw [NSException
                exceptionWithName:@"ProviderNotExistException"
                reason:[NSString stringWithFormat:@"%@ doesn't exist.", task.launchPath]
                userInfo:[NSDictionary
                          dictionaryWithObject:task.launchPath
                          forKey:@"provider"]
                ];
    }
    
    if (![self hasExecutablePermission:task.launchPath]) {
        @throw [NSException
                exceptionWithName:@"ProviderNotExecutableException"
                reason:[NSString stringWithFormat:@"%@ isn't executable.", task.launchPath]
                userInfo:[NSDictionary
                          dictionaryWithObject:task.launchPath
                          forKey:@"provider"]];
    }
    
    task.arguments = @[input];
    NSLog(@"Run: %@ with args: %@", task.launchPath, task.arguments);
    
    [task launch];
    [task waitUntilExit];
    
    NSData *stdout = [outputPipe.fileHandleForReading readDataToEndOfFile];
    [outputPipe.fileHandleForReading closeFile];
    NSLog(@"Stdout: %@", [[NSString alloc] initWithData:stdout encoding:NSUTF8StringEncoding]);
    
    NSData *stderr = [errorPipe.fileHandleForReading readDataToEndOfFile];
    [errorPipe.fileHandleForReading closeFile];
    NSLog(@"StdErr: %@", [[NSString alloc] initWithData:stderr encoding:NSUTF8StringEncoding]);
    
    if ([task terminationStatus] != 0) {
        @throw [NSException
                exceptionWithName:@"ProviderErrorException"
                reason:[[NSString alloc] initWithData:stderr encoding:NSUTF8StringEncoding]
                userInfo:[NSDictionary
                          dictionaryWithObject:task.launchPath
                          forKey:@"provider"]];
    }
    
    return stdout;
}

- (BOOL) fileExists:(NSString*) path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


- (BOOL) hasExecutablePermission:(NSString*) path {
    NSUInteger permissions = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] filePosixPermissions];
    
    return (permissions & 0111) > 0;
   
}
@end
