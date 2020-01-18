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
#import "TipEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TipTableController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) NSArray<TipItem*>* items;
@property TipEmptyView* emptyView;
@property TipTableView* table;
@property NSTableColumn* iconColumn;
@property NSTableColumn* textColumn;

@end

NS_ASSUME_NONNULL_END
