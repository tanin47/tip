//
//  TipNoticeView.h
//  Tip
//
//  Created by Tanin Na Nakorn on 1/20/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TipItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TipNoticeViewAction) {
    TipNoticeViewActionNone,
    TipNoticeViewActionOpenConsole,
    TipNoticeViewActionOpenProviderInstruction
};

@interface TipNoticeView : NSView


@property NSTextView* textField;
@property NSTextField* iconField;

@property TipNoticeViewAction action;
 
- (void) updateWithItems:(nonnull NSArray<TipItem *> *)items andError:(NSException *) error;

@property CGSize preferredSize;

@end

NS_ASSUME_NONNULL_END
