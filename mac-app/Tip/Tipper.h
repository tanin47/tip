//
//  Tipper.h
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Tipper
@required
- (NSArray<TipItem *> *) makeTip: (NSString*) input;
@end

NS_ASSUME_NONNULL_END
