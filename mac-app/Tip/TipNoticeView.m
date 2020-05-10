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

- (instancetype)initWithFrame:(NSRect)frame{
    if (self = [super initWithFrame:frame]) {
        _iconField = [[NSTextField alloc] initWithFrame:frame];
        _iconField.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:14];
        _iconField.editable = NO;
        _iconField.selectable = NO;
        _iconField.bezeled = NO;
        _iconField.drawsBackground = NO;
        _iconField.alignment = NSTextAlignmentCenter;
        [self addSubview:_iconField];

        _textField = [[NSTextField alloc] init];
        _textField.cell = [VeritcallyAlignNSTextFieldCell new];
        _textField.cell.font = [NSFont fontWithName:@"RobotoMono-Regular" size:13];
        _textField.editable = NO;
        _textField.selectable = NO;
        _textField.bezeled = NO;
        _textField.drawsBackground = NO;
        _textField.alignment = NSTextAlignmentLeft;
        [self addSubview:_textField];
    }
    
    return self;
}

- (void) updateWithMessage:(NSString*)message
                      icon:(UniChar)icon
                    action:(TipNoticeViewAction)action {
    self.action = action;
    
    _textField.stringValue = message;

    _iconField.stringValue = [NSString stringWithFormat:@"%C", icon];
    
    NSSize size = [_textField.cell cellSizeForBounds:NSMakeRect(0, 0, self.frame.size.width - 40, FLT_MAX)];
    _textField.frame = NSMakeRect(
                                 self.frame.origin.x + 30,
                                 self.frame.origin.y + 8,
                                 size.width,
                                 size.height);
    _iconField.frame = NSMakeRect(self.frame.origin.x + 5, size.height + 10 - 30, 25, 25);
    self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height + 15);
    
    [self removeConstraint:_widthConstraint];
    [self removeConstraint:_heightConstraint];
    
    _widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.frame.size.width];
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.frame.size.height];
    [self addConstraint:_widthConstraint];
    [self addConstraint:_heightConstraint];
    self.needsLayout = YES;
}

- (void)resetCursorRects {
    if (self.action == TipNoticeViewActionNone) { return; }
    [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
}

- (void)mouseUp:(NSEvent *)event {
#ifdef DEBUG
    NSPasteboard* pboard = [NSPasteboard generalPasteboard];
    [pboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];
    NSString* s = @"Unset";
    
    if (self.action == TipNoticeViewActionNone) { s = @"None"; }
    else if (self.action == TipNoticeViewActionOpenConsole) { s = @"OpenConsole"; }
    else if (self.action == TipNoticeViewActionOpenProviderInstruction) { s = @"OpenProviderInstruction"; }
    
    [pboard setString:s forType:NSPasteboardTypeString];
    return;
#endif
    
    if (self.action == TipNoticeViewActionOpenConsole) {
        [[NSWorkspace sharedWorkspace] launchApplication:@"Console"];
    } else if (self.action == TipNoticeViewActionOpenProviderInstruction) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/tanin47/tip/blob/master/PROVIDER.md"]];
    }
    
}
@end
