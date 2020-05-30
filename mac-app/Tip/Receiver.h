//
//  EncryptorClass.h
//  test2
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExternalTipper.h"

NS_ASSUME_NONNULL_BEGIN

@interface Receiver : NSObject

@property ExternalTipper* tipper;

- (id)initWithTipper:(ExternalTipper *)tipper_;
- (void)openTips:(nonnull NSPasteboard *)pboard
        userData:(nonnull NSString *)userData
           error:(NSString * _Nullable * _Nonnull)error;

@end

NS_ASSUME_NONNULL_END
