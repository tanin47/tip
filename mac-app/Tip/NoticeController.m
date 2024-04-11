//
//  NoticeController.m
//  Tip
//
//  Created by Tanin Na Nakorn on 5/31/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import "NoticeController.h"

@implementation NoticeController

- (instancetype) init {
    if (self = [super init]) {
        self.view = [[NSView alloc] init];
        
        _noticeView = [[TipNoticeView alloc] init];
        [self.view addSubview:_noticeView];
        
        NSDictionary *noticeViewDict = NSDictionaryOfVariableBindings(_noticeView);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=2)-[_noticeView]-(>=2)-|" options:0 metrics:nil views:noticeViewDict]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=2)-[_noticeView]-(>=2)-|" options:0 metrics:nil views:noticeViewDict]];
    }
    return self;
}

- (void) viewDidAppear {
    [super viewDidAppear];
    [_noticeView.window makeFirstResponder:_noticeView.textField];
}

- (void)updateWithItems:(nullable NSArray<TipItem *> *)items andError:(nullable NSException*)error {
    [_noticeView updateWithItems:items andError:error];
}

- (BOOL) shouldShowNotice {
    return _noticeView.shouldShowNotice;
}

@end
