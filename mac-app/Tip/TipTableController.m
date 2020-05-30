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
        
        _noticeView = [[TipNoticeView alloc] init];
        [self.view addSubview:_noticeView];
        
        NSDictionary *noticeViewDict = NSDictionaryOfVariableBindings(_noticeView);
        _noticeViewConstraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=2)-[_noticeView]-(>=2)-|" options:0 metrics:nil views:noticeViewDict]
                                  arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=2)-[_noticeView]-(>=2)-|" options:0 metrics:nil views:noticeViewDict]
                                  ];
        [self.view addConstraints:_noticeViewConstraints];
        
        _table = [[TipTableView alloc] init];
        _table.tipper = tipper;
        [self.view addSubview:_table];
        
        NSDictionary *tableDict = NSDictionaryOfVariableBindings(_table);
        _tableConstraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_table]-0-|" options:0 metrics:nil views:tableDict]
                             arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_table]-0-|" options:0 metrics:nil views:tableDict]
                             ];
        [self.view addConstraints:_tableConstraints];
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

- (void) setError:(NSException*)error {
    _error = error;
    [self updateWithItems:[[NSMutableArray alloc] init] andError:error];
}

- (NSArray<TipItem*>*)items {
    return _table.items;
}

- (void)setItems:(nonnull NSArray<TipItem *> *)items {
    [self updateWithItems:items andError:nil];
}

- (void)updateWithItems:(nonnull NSArray<TipItem *> *)items andError:(NSException*)error {
    _table.items = items;
    [_noticeView updateWithItems:items andError:error];
    
    if (error || items.count == 0) {
        _noticeView.hidden = NO;
        _table.hidden = YES;
    } else {
        _noticeView.hidden = YES;
        _table.hidden = NO;
    }

    for (NSLayoutConstraint* c in _tableConstraints) {
        c.active = !_table.hidden;
    }
    for (NSLayoutConstraint* c in _noticeViewConstraints) {
        c.active = !_noticeView.hidden;
    }
}


@end
