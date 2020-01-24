//
//  TipNoticeView.h
//  Tip
//
//  Created by Tanin Na Nakorn on 1/20/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TipNoticeViewAction) {
    TipNoticeViewActionNone,
    TipNoticeViewActionOpenConsole,
    TipNoticeViewActionOpenProviderInstruction
};

@interface TipNoticeView : NSView

- (instancetype)initWithFrame:(NSRect)frame;
- (void) updateWithMessage:(NSString*) message icon:(UniChar)icon color:(NSColor*)color action:(TipNoticeViewAction)action;

@property NSTextField* textField;
@property NSTextField* iconField;

@property TipNoticeViewAction action;

@end

NS_ASSUME_NONNULL_END
