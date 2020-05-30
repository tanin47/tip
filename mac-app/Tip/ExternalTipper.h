//
//  ExternalTipper.h
//  tip
//
//  Created by Tanin Na Nakorn on 12/29/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseTipper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExternalTipper : BaseTipper

@property NSString* provider;

-(instancetype)initWithProvider:(NSString *)provider_;

@end

NS_ASSUME_NONNULL_END
