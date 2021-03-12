//
//  LockTest.h
//  OC_Study
//
//  Created by 技术 on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LockTest : NSObject

- (void)OSAtomicLock;
- (void)semaphore;
- (void)pthreadlock;

@end

NS_ASSUME_NONNULL_END
