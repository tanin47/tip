//
//  TipTableView.m
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import "TipTableView.h"
#import "TipItemTextField.h"
#import "AppDelegate.h"
#import "VeritcallyAlignNSTextFieldCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TipTableView

NSTextField *textFieldForSizing;

- (instancetype)init {
    if (self = [super init]) {
        _items = [[NSMutableArray alloc] init];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.focusRingType = NSFocusRingTypeNone;
        self.cell.bordered = NO;
        self.allowsMultipleSelection = NO;
        self.allowsColumnResizing = NO;
        self.cell.bezeled = NO;
        self.intercellSpacing = CGSizeMake(0, 0);
        self.hidden = YES;
        self.usesAutomaticRowHeights = YES;
        self.headerView = nil;
        self.cornerView = nil;
        
        self.dataSource = self;
        self.delegate = self;
        self.target = self;
        self.action = @selector(clickRow:);
        
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
        [self setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        
        _iconColumn = [[NSTableColumn alloc] initWithIdentifier:@"icon"];
        _iconColumn.width = 18;
        _textColumn = [[NSTableColumn alloc] initWithIdentifier:@"text"];
        [self addTableColumn:_iconColumn];
        [self addTableColumn:_textColumn];
        
        textFieldForSizing = [[TipItemTextField alloc] init];
    }
    return self;
}

- (void) selectFirstRow {
    if (_items && _items.count > 0) {
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _items.count;
}

- (void) performAction:(NSUInteger) row {
    TipItem* item = [_items objectAtIndex:row];
    
    if (item.type == TipItemTypeUrl) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:item.value]];
        [self hide];
    } else if (item.type == TipItemTypeExecute) {
        [_tipper setContinuous:true];
        
        NSTableRowView* rowView = [self rowViewAtRow:row makeIfNecessary:false];
        NSTextField* iconText = ((NSView*)[rowView viewAtColumn:0]).subviews.firstObject;
        iconText.stringValue = @"\uf110";
    
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotation.fromValue = [NSNumber numberWithFloat:0];
        rotation.toValue = [NSNumber numberWithFloat:(M_PI * 2)];
        rotation.duration = 0.7; // Speed
        rotation.repeatCount = INFINITY;
        rotation.removedOnCompletion = true;
        [iconText.layer addAnimation:rotation forKey:@"Spin"];
        iconText.layer.position = NSMakePoint(iconText.layer.frame.origin.x + iconText.layer.frame.size.width / 2, iconText.layer.frame.origin.y + iconText.layer.frame.size.height / 2);
        iconText.layer.anchorPoint = NSMakePoint(0.5, 0.5);
        iconText.layer.transform = CATransform3DIdentity;

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.tipper activateTip:item.args];
        });
    } else {
        NSTableRowView* rowView = [self rowViewAtRow:row makeIfNecessary:false];
        NSTextField* iconText = ((NSView*)[rowView viewAtColumn:0]).subviews.firstObject;

        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = 0.1;
            iconText.animator.alphaValue = 0;
        }
        completionHandler:^{
            iconText.alphaValue = 1;
            iconText.stringValue = @"\uf46c";

            [self performSelector:@selector(hide)
                       withObject:nil
                       afterDelay:0.15];
        }];
        
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard clearContents];
        [pasteboard setString:item.value forType:NSPasteboardTypeString];
    }
}

- (void)setItems:(NSArray<TipItem *> *)items {
    _items = items;
    [self recomputePreferredSize];
    [self reloadData];
}

- (void) recomputePreferredSize {
    CGSize newSize = CGSizeMake(0, 0);
    for (TipItem* item in _items) {
        textFieldForSizing.stringValue = item.label;
        newSize.width = MAX(newSize.width, textFieldForSizing.intrinsicContentSize.width);
        newSize.height += textFieldForSizing.intrinsicContentSize.height + 1 + 4;
    }

    newSize.width += _iconColumn.width + 6;
    _preferredSize = newSize;
    [self invalidateIntrinsicContentSize];
}

- (void) hide {
    [AppDelegate hide];
}

- (void)keyUp:(NSEvent *)event {
    if (event.keyCode == 36 || event.keyCode == 76) {
        if (self.selectedRow >= 0) {
            [self performAction:self.selectedRow];
        }
    }
}

- (void) clickRow:(id)sender {
    [self performAction:self.clickedRow];
}

- (void)resetCursorRects {
    [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
}

- (NSSize)intrinsicContentSize {
    return _preferredSize;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    NSView* result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
        
    TipItem* item = [_items objectAtIndex:row];
    
    if (!item) { return nil; }
    
    
    if (tableColumn == _iconColumn) {
        NSView* iconCol = result;
        if (iconCol == nil) {
            iconCol = [[NSView alloc] init];
            iconCol.identifier = @"iconCol";
            
            NSTextField* icon = [[NSTextField alloc] init];
            icon.identifier = @"iconText";
            icon.translatesAutoresizingMaskIntoConstraints = NO;
            icon.cell = [VeritcallyAlignNSTextFieldCell new];
            icon.cell.font = [NSFont fontWithName:@"Font Awesome 5 Free" size:12];
            icon.editable = NO;
            icon.selectable = NO;
            icon.bezeled = NO;
            icon.drawsBackground = NO;
            
            [iconCol addSubview:icon];
            
            NSDictionary *iconTextDict = NSDictionaryOfVariableBindings(icon);
            [iconCol addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[icon]-3-|" options:0 metrics:nil views:iconTextDict]];
            [iconCol addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[icon]->=4-|" options:0 metrics:nil views:iconTextDict]];
            [icon setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
            [icon setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
            [icon setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
            [icon setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        }
        
        NSTextField* iconText = iconCol.subviews.firstObject;
        [iconText.layer removeAllAnimations];
        if (item.type == TipItemTypeUrl) {
            iconText.stringValue = @"\uf35d";
        } else if (item.type == TipItemTypeExecute) {
            iconText.stringValue = @"\uf144";
        } else {
            iconText.stringValue = @"\uf0c5";
        }
        [iconCol invalidateIntrinsicContentSize];
        return iconCol;
    } else if (tableColumn == _textColumn) {
        NSView* textCol = result;
        
        if (textCol == nil) {
            textCol = [[NSView alloc] init];
            
            NSTextField* text = [[TipItemTextField alloc] init];
            text.translatesAutoresizingMaskIntoConstraints = NO;
            [textCol addSubview:text];
            
            NSDictionary *textDict = NSDictionaryOfVariableBindings(text);
            [textCol addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[text]-0-|" options:0 metrics:nil views:textDict]];
            [textCol addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[text]-3-|" options:0 metrics:nil views:textDict]];
        }
        
        NSTextField* textField = textCol.subviews.firstObject;
        textField.stringValue = item.label;
        [textCol invalidateIntrinsicContentSize];
        return textCol;
    } else {
        @throw [NSException
                exceptionWithName:@"Exception"
                reason:[NSString stringWithFormat:@"Invalid column: %@", tableColumn.identifier]
                userInfo:nil];
    }
}

@end
