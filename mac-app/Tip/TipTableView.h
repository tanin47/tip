//
//  TipTableView.h
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TipItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TipTableView : NSTableView<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) NSArray<TipItem*>* items;

@property NSTableColumn* iconColumn;
@property NSTableColumn* textColumn;

@property CGSize preferredSize;

- (void) selectFirstRow;

- (void) performAction:(NSUInteger)row;

- (void) recomputePreferredSize;

@end

NS_ASSUME_NONNULL_END
