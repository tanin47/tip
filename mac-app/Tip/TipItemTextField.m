//
//  TipItemTextField.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "TipItemTextField.h"

@implementation TipItemTextField

- (void) setStringValue:(NSString *)stringValue {
    [super setStringValue:stringValue];
    
    CGSize textSize = [self getTextSize:stringValue];
    
    CGFloat width = textSize.width;
    CGFloat height = MAX(22, textSize.height);
    
    self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, width, height);
    self.bounds = NSMakeRect(0, 0, width, height);
    self.needsLayout = true;
}

- (CGSize) getTextSize:(NSString *) text {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    CGSize size = [as size];
    size.width += 4;
    size.height += 4;
    return size;
}

@end
