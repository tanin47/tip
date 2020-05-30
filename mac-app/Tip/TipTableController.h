//
//  TipTableView.h
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TipItem.h"
#import "TipTableView.h"
#import "TipNoticeView.h"
#import "Tipper.h"

NS_ASSUME_NONNULL_BEGIN

@interface TipTableController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property TipNoticeView* noticeView;
@property TipTableView* table;

@property (nonatomic) NSException* error;
@property (nonatomic) NSArray<TipItem*>* items;

- (instancetype) initWithReceiver:(id<Tipper>) tipper;

- (void) performAction:(NSUInteger)row;

- (void)setItems:(nonnull NSArray<TipItem *> *)items;

@end

NS_ASSUME_NONNULL_END
