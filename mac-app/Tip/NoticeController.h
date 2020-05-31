//
//  NoticeController.h
//  Tip
//
//  Created by Tanin Na Nakorn on 5/31/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TipNoticeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeController : NSViewController

@property TipNoticeView* noticeView;
@property (nonatomic) NSException* error;

- (BOOL)shouldShowNotice;
- (void)updateWithItems:(nullable NSArray<TipItem *> *)items andError:(nullable NSException*)error;

@end

NS_ASSUME_NONNULL_END
