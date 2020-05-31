//
//  TipTableView.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#include <stdlib.h>

#import "TipTableController.h"
#import "TipTableView.h"
#import "TipNoticeView.h"

@implementation TipTableController

- (instancetype) initWithReceiver:(id<Tipper>)tipper {
    if (self = [super init]) {
        self.view = [[NSView alloc] init];
        
        _table = [[TipTableView alloc] init];
        _table.tipper = tipper;
        [self.view addSubview:_table];
        
        NSDictionary *tableDict = NSDictionaryOfVariableBindings(_table);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_table]-0-|" options:0 metrics:nil views:tableDict]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_table]-0-|" options:0 metrics:nil views:tableDict]];
    }
    return self;
}

- (void) viewDidAppear {
    [super viewDidAppear];
    [_table selectFirstRow];
}

- (void) performAction:(NSUInteger)row {
    [_table performAction:row];
}

- (NSArray<TipItem*>*)items {
    return _table.items;
}

- (void)updateItems:(nonnull NSArray<TipItem *> *)items {
    _table.items = items;
}

@end
