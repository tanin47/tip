//
//  TipNoticeView.m
//  Tip
//
//  Created by Tanin Na Nakorn on 1/20/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

#import "TipNoticeView.h"
#import "VeritcallyAlignNSTextFieldCell.h"
#import "WrappedTextView.h"

@implementation TipNoticeView

- (instancetype)init{
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        
        _iconField = [[NSTextField alloc] init];
        _iconField.identifier = @"iconField";
        _iconField.translatesAutoresizingMaskIntoConstraints = NO;
        _iconField.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:16];
        _iconField.editable = NO;
        _iconField.selectable = NO;
        _iconField.bezeled = NO;
        _iconField.drawsBackground = NO;
        _iconField.alignment = NSTextAlignmentCenter;
        [self addSubview:_iconField];
        
        _textField = [[WrappedTextView alloc] init];
        _textField.identifier = @"textField";
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.font = [NSFont fontWithName:@"RobotoMono-Regular" size:13];
        _textField.editable = NO;
        _textField.selectable = NO;
        _textField.drawsBackground = NO;
        _textField.alignment = NSTextAlignmentLeft;
        [self addSubview:_textField];
        
        NSDictionary *viewDict = NSDictionaryOfVariableBindings(_iconField, _textField);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[_iconField]-1-[_textField]-2-|" options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_iconField]-(>=0)-|" options:0 metrics:nil views:viewDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_textField]-5-|" options:0 metrics:nil views:viewDict]];
        
        [_iconField setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [_iconField setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];

        [_textField setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [_textField setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
    }
    
    return self;
}

- (void) updateWithItems:(NSArray *)items andError:(NSException *)error {
    if (error) {
        NSString *message = nil;
        TipNoticeViewAction action = TipNoticeViewActionNone;
        
        if ([error.name isEqualToString:@"MalformedJsonException"]) {
            message = @"Malformed JSON returned from provider. Click to see logs in Console. You'll need to set the filter Process=Tip.";
            action = TipNoticeViewActionOpenConsole;
        } else if ([error.name isEqualToString:@"ProviderNotExistException"]) {
            message = [NSString stringWithFormat:@"%@ doesn't exist. Please make a provider script. Click to see instruction.", [error.userInfo objectForKey:@"provider"]];
            action = TipNoticeViewActionOpenProviderInstruction;
        } else if ([error.name isEqualToString:@"ProviderNotExecutableException"]) {
            message = [NSString stringWithFormat:@"Provider isn't executable. Please chmod 755 %@", [error.userInfo objectForKey:@"provider"]];
        } else {
            message = @"Error occurred. Click to see logs in Console. You'll need to set the filter Process=Tip.";
            action = TipNoticeViewActionOpenConsole;
        }
        
        [self updateWithMessage:message
                           icon:0xf06a
                         action:action];
    } else if (items.count == 0) {
        [self updateWithMessage:@"No tips. You can add tips through your provider script. Click to see the instruction."
                           icon:0xf59a
                         action:TipNoticeViewActionOpenProviderInstruction];
    } else {
        [self updateWithMessage:@"No error."
                           icon:0xf06a
                         action:TipNoticeViewActionOpenConsole];
    }
}

- (void) updateWithMessage:(NSString*)message
                      icon:(UniChar)icon
                    action:(TipNoticeViewAction)action {
    self.action = action;
    
    _textField.string = message;
    _iconField.stringValue = [NSString stringWithFormat:@"%C", icon];
  
    _preferredSize = CGSizeMake(3 + _iconField.intrinsicContentSize.width + 1 + _textField.intrinsicContentSize.width + 2,  2 + _textField.intrinsicContentSize.height + 5);
}

- (NSSize)intrinsicContentSize {
    return _preferredSize;
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
