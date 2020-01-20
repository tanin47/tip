//
//  TipNoticeView.m
//  Tip
//
//  Created by Tanin Na Nakorn on 1/20/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import "TipNoticeView.h"
#import "VeritcallyAlignNSTextFieldCell.h"

@implementation TipNoticeView

- (instancetype)initWithFrame:(NSRect)frameRect
                         icon:(NSString*) icon
                      message:(NSString*) message
                        color:(NSColor*) color {
    if (self = [super initWithFrame:frameRect]) {
        NSTextField* iconTextfield = [[NSTextField alloc] initWithFrame:NSMakeRect(
                                                                          frameRect.origin.x + 5, frameRect.origin.y+1, 25, 25)];
        iconTextfield.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
        iconTextfield.editable = NO;
        iconTextfield.selectable = NO;
        iconTextfield.bezeled = NO;
        iconTextfield.drawsBackground = NO;
        iconTextfield.stringValue = icon;
        iconTextfield.alignment = NSTextAlignmentCenter;
        iconTextfield.textColor = color;
        [self addSubview:iconTextfield];
        
        NSTextField* textField = [[NSTextField alloc] initWithFrame:NSMakeRect(
                                                                               frameRect.origin.x +30, frameRect.origin.y, frameRect.size.width - 30,
                                                                               frameRect.size.height)];
        textField.cell = [VeritcallyAlignNSTextFieldCell new];
        textField.cell.font = [NSFont fontWithName:@"RobotoMono-Regular" size:12];
        textField.editable = NO;
        textField.selectable = NO;
        textField.bezeled = NO;
        textField.drawsBackground = NO;
        textField.stringValue = message;
        textField.alignment = NSTextAlignmentLeft;
        textField.textColor = color;
        [self addSubview:textField];
    }
    
    return self;
}

@end
