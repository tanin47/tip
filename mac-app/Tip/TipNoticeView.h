//
//  TipNoticeView.h
//  Tip
//
//  Created by Tanin Na Nakorn on 1/20/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipNoticeView : NSView

- (instancetype)initWithFrame:(NSRect)frameRect icon:(NSString*)icon message:(NSString*) message color:(NSColor*)color;

@end

NS_ASSUME_NONNULL_END
