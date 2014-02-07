//
//  Bolts.h
//  Bolts
//
//  Created by Bryan Klimt on 10/7/13.
//  Copyright (c) 2013 Parse Inc. All rights reserved.
//

#import "BoltsVersion.h"
#import "BFExecutor.h"
#import "BFTask.h"
#import "BFTaskCompletionSource.h"

/*! @abstract 80175001: There were multiple errors. */
extern NSInteger const kBFMultipleErrorsError;

@interface Bolts : NSObject

/*!
 Returns the version of the Bolts Framework as an NSString.
 */
+ (NSString *)version;

@end
