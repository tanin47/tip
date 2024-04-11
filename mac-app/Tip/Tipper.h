//
//  Tipper.h
//  Tip
//
//  Created by Tanin Na Nakorn on 5/30/20.
//  Copyright © 2020 Tanin Na Nakorn. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@protocol Tipper

@required
- (void) activateTip:(NSArray<NSString*>*) args;

@required
- (void) setContinuous:(BOOL) continuous;

@end

NS_ASSUME_NONNULL_END
