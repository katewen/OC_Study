//
//  LockTest.m
//  OC_Study
//
//  Created by 技术 on 2021/3/10.
//

#import "LockTest.h"
#import <pthread/pthread.h>
@implementation LockTest

//osatomicLock 线程锁
- (void)OSAtomicLock{
    __block OSSpinLock oslock = OS_SPINLOCK_INIT;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        OSSpinLockLock(&oslock);
        NSLog(@"线程1");
//        OSSpinLockUnlock(&oslock);
        NSLog(@"线程1 解锁成功");
        NSLog(@"----------------");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        OSSpinLockLock(&oslock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程2 解锁成功");
    });
    
}

// dispatch_semaphore 信号量
- (void)semaphore {
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);// 传入值必须>=0 若为0阻塞当前线程 并等待timeout才会执行后面语句
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC );
    // 线程 1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 等待ing");
        dispatch_semaphore_wait(signal, overTime); // 信号量 signal值 -1
        NSLog(@"线程1");
        dispatch_semaphore_signal(signal);//发送信号量 signal值  +1
        NSLog(@"线程1 发送信号量");
        NSLog(@"-------------------");
    });
    // 线程 2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 等待ing");
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
        NSLog(@"线程2 发送信号量");
    });
    
    
}

- (void)pthreadlock {
    
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    //线程 1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 上锁");
        pthread_mutex_lock(&pLock);
        sleep(3);
        NSLog(@"线程1");
        pthread_mutex_unlock(&pLock);

    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 上锁");
        pthread_mutex_lock(&pLock);
        NSLog(@"线程2");
        pthread_mutex_unlock(&pLock);
    });
    
}

@end
