//
//  TipItem.h
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum TipItemType : NSUInteger {
    TipItemTypeText,
    TipItemTypeUrl,
    TipItemTypeExecute
} TipItemType;

@interface TipItem : NSObject

@property TipItemType type;
@property NSString *label;
@property NSString *value;
@property NSArray<NSString*>* args;
@property BOOL autoExecuteIfFirst;

@end

NS_ASSUME_NONNULL_END
