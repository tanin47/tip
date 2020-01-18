//
//  EncryptorClass.h
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipTableController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Receiver : NSObject

@property TipTableController* controller;

- (void)showPopover: (NSArray<TipItem *> *) text;

@end

NS_ASSUME_NONNULL_END
