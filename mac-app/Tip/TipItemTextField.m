//
//  TipItemTextField.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "TipItemTextField.h"
#import "VeritcallyAlignNSTextFieldCell.h"

@implementation TipItemTextField

- (instancetype)init {
    if (self = [super init]) {
        self.cell = [VeritcallyAlignNSTextFieldCell new];
        self.editable = NO;
        self.selectable = YES;
        self.bezeled = NO;
        self.drawsBackground = NO;
        self.font = [NSFont fontWithName:@"RobotoMono-Regular" size:12];
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
    }
    return self;
}

@end
