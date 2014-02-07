//
//  BFExecutor.h
//  Bolts
//
//  Created by Bryan Klimt on 10/9/13.
//  Copyright (c) 2013 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFExecutor : NSObject

/*!
 Returns a default executor, which runs continuations immediately until the call stack gets too
 deep, then dispatches to a new GCD queue.
 */
+ (BFExecutor *)defaultExecutor;

/*!
 Returns an executor that runs continuations on the thread where the previous task was completed.
 */
+ (BFExecutor *)immediateExecutor;

/*!
 Returns an executor that runs continuations on the main thread.
 */
+ (BFExecutor *)mainThreadExecutor;

/*!
 Returns a new executor that uses the given block execute continations.
 */
+ (BFExecutor *)executorWithBlock:(void(^)(void(^block)()))block;

/*!
 Returns a new executor that runs continuations on the given queue.
 */
+ (BFExecutor *)executorWithDispatchQueue:(dispatch_queue_t)queue;

/*!
 Returns a new executor that runs continuations on the given queue.
 */
+ (BFExecutor *)executorWithOperationQueue:(NSOperationQueue *)queue;

/*!
 Runs the given block using this executor's particular strategy.
 */
- (void)execute:(void(^)())block;

@end
