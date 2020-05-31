//
//  Tipper.h
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipTableController.h"
#import "NoticeController.h"
#import "TipItem.h"
#import "Tipper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTipper: NSObject<Tipper>

@property (nonatomic) TipTableController* tipTableController;
@property (nonatomic) NoticeController* noticeController;
@property (nonatomic, retain, nullable) NSWindow* window;
@property (nonatomic, retain, nullable) NSPopover* popover;

@property BOOL continuous;

- (NSArray<TipItem *> *) makeTip: (NSArray<NSString*>*) args;

- (void) activateTip:(NSArray<NSString*>*) args;

@end

NS_ASSUME_NONNULL_END
