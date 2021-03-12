//
//  main.m
//  OC_Study
//
//  Created by Erik on 2021/3/7.
//

#import <Foundation/Foundation.h>
#import "ThreadTest.h"
#import "LockTest.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//        [[ThreadTest alloc] threadTest];
//        [[ThreadTest alloc] gcdTest];
//        [[ThreadTest alloc] operationTest];
//        [[ThreadTest alloc] downloadImage];
//        [[LockTest alloc] OSAtomicLock];
//        [[LockTest alloc]semaphore];
        [[LockTest alloc] pthreadlock];
        
    }
    return 0;
}
