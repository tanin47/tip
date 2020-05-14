//
//  WrappedTextField.m
//  Tip
//
//  Created by Tanin Na Nakorn on 5/16/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import "WrappedTextView.h"

@implementation WrappedTextView

- (void)setString:(NSString *)string {
    [super setString:string];
    
    self.textContainer.size = NSMakeSize(250, FLT_MAX);
    [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    
    NSSize size = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    _preferredSize = CGSizeMake(size.width, size.height);
}

- (NSSize)intrinsicContentSize {
    return _preferredSize;
}

@end
