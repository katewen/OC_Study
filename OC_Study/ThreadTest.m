//
//  ThreadTest.m
//  OC_Study
//
//  Created by Erik on 2021/3/7.
//

#import "ThreadTest.h"

@implementation ThreadTest

// oc 中的多线程
// 1、NSThread
- (void)threadTest {
//    动态创建NSThread
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:@"NSThread1 动态创建"];
//  需手动开启线程
    [thread1 start];
    
//   静态创建线程 无需开启
    [NSThread detachNewThreadSelector:@selector(threadMethod) toTarget:self withObject:@"NSThread2 静态创建"];
//    隐式创建 无需开启
    [self performSelector:@selector(threadMethod) withObject:@"NSThread3 隐式创建"];
//   退出线程
    [NSThread exit];
//   主线程
    [NSThread mainThread];
//   当前线程
    [NSThread currentThread];
    
}

// 2、GCD

- (void)gcdTest {
//  串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("q1.erik.com", NULL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("q2.erik.com", DISPATCH_QUEUE_SERIAL);
//  并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("q3.erik.com", DISPATCH_QUEUE_CONCURRENT);
//  全局并行队列    DISPATCH_QUEUE_PRIORITY_DEFAULT 优先级
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//  主队列获取 类似于主线程
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
//  同步执行串行队列任务 不会开启新的线程
    for (int i = 0; i < 5; i ++) {
        dispatch_sync(serialQueue, ^{
            NSLog(@"%d %@",i,[NSThread currentThread]);
        });
    }
    
//  同步执行并发队列任务 不会开启新线程
    for (int i = 0; i < 10; i ++) {
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"%d %@",i,[NSThread currentThread]);
        });
    }
    
//  异步执行串行队列任务 异步执行会开启新线程 串行队列顺序执行
    for (int i = 0; i < 10; i ++) {
        dispatch_async(serialQueue, ^{
            NSLog(@"%d %@",i,[NSThread currentThread]);
        });
    }
    
//  异步执行并发队列任务 会开新线程 并发队列无序执行
    for (int i = 0; i < 10; i ++) {
        dispatch_async(concurrentQueue, ^{
            NSLog(@"%d %@",i,[NSThread currentThread]);
        });
    }
    
//  创建一个调度组
    dispatch_group_t group = dispatch_group_create();
//  获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
//  为队列添加任务，并且和给定的调度组关联
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务2");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:.5];
        NSLog(@"任务3");
    });

//  所有任务执行完毕通知
    dispatch_group_notify(group, queue, ^{
        NSLog(@"全部结束");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"主线程更新UI");
        });
    });
    
    
}

- (void)operationTest {
//  NSBlockOperation
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation");
    }];
//  NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
//  创建队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//  添加任务
    [operationQueue addOperation:blockOperation];
    [operationQueue addOperation:invocationOperation];
    [operationQueue addOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [operationQueue addOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
//   任务组 添加依赖
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务1");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2");
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:.5];
        NSLog(@"任务3");
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"更新UI");
    }];
    [op4 addDependency:op1];
    [op4 addDependency:op2];
    [op4 addDependency:op3];
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperations:@[op1,op2,op3,op4] waitUntilFinished:NO];
    
    
}
// 下载图片
- (void)downloadImage {
    NSString *imageUrl = @"https://pics3.baidu.com/feed/f7246b600c3387442ab9255675bbfff1d62aa0dc.jpeg?token=ab03a40f019fff097ad8bed17507fca5&s=E9104F9C0877F3ED54189109030060E3";
    [NSThread detachNewThreadWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    }];
    
    dispatch_async(dispatch_queue_create("queue.image.com", NULL), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    });
    
    NSBlockOperation *downImage = [NSBlockOperation blockOperationWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    }];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    [operationQueue addOperationWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    }];
    [operationQueue addOperation:downImage];
    
}

- (void)threadMethod {
    NSLog(@"执行任务，当前线程%@",[NSThread currentThread]);
}

@end
