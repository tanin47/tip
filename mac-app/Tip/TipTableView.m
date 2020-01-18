//
//  TipTableView.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "TipTableView.h"

@implementation TipTableView

- (void)keyUp:(NSEvent *)event
{
    if (event.keyCode == 36 || event.keyCode == 76) {
        if (_enterPressedAction) {
            IMP imp = [self.target methodForSelector:_enterPressedAction];
            void (*func)(id, SEL) = (void *) imp;
            func(self.target, _enterPressedAction);
        }
    }
}

- (void)resetCursorRects {
    [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
}

@end
