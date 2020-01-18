//
//  TipEmptyView.m
//  Tip
//
//  Created by Tanin Na Nakorn on 12/30/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "TipEmptyView.h"
#import "VeritcallyAlignNSTextFieldCell.h"

@implementation TipEmptyView

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        NSTextField* textField = [[NSTextField alloc] initWithFrame:frameRect];
        textField.cell = [VeritcallyAlignNSTextFieldCell new];
        textField.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
        textField.editable = NO;
        textField.selectable = NO;
        textField.bezeled = NO;
        textField.drawsBackground = NO;
        textField.stringValue = @"No applicable tips";
        textField.alignment = NSTextAlignmentCenter;
        [self addSubview:textField];
    }
    
    return self;
}

@end
