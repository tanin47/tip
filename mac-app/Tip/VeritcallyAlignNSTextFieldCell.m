//
//  TipItemIcon.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/30/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "VeritcallyAlignNSTextFieldCell.h"

@implementation VeritcallyAlignNSTextFieldCell

- (NSRect)drawingRectForBounds:(NSRect)rect
{
    NSRect newRect = [super drawingRectForBounds:rect];
    NSSize size = [self cellSizeForBounds:rect];

    float delta = newRect.size.height - size.height;
    if (delta > 0) {
        newRect.size.height -= delta;
        newRect.origin.y += (delta / 2);
    }
    
    return newRect;
}

@end
