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
    CGFloat height = MAX(16, textSize.height);
    
    self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, width, height);
    
    [self removeConstraint:_widthConstraint];
    [self removeConstraint:_heightConstraint];
    _widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:_widthConstraint];
    [self addConstraint:_heightConstraint];
    self.needsLayout = true;
}

- (CGSize) getTextSize:(NSString *) text {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    CGSize size = [as size];
    size.width += 4;
    return size;
}

@end
