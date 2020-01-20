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

NS_ASSUME_NONNULL_BEGIN

@interface TipTableController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) NSArray<TipItem*>* items;
@property (nonatomic) bool showError;
@property (nullable) NSPasteboard* pboard;
@property (nullable) NSPopover* popover;
@property TipNoticeView* errorView;
@property TipNoticeView* emptyView;
@property TipTableView* table;
@property NSTableColumn* iconColumn;
@property NSTableColumn* textColumn;

@end

NS_ASSUME_NONNULL_END
