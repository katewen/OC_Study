//
//  main.m
//  OC_Study
//
//  Created by Erik on 2021/3/7.
//

#import <Foundation/Foundation.h>
#import "ThreadTest.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//        [[ThreadTest alloc] threadTest];
//        [[ThreadTest alloc] gcdTest];
        [[ThreadTest alloc] operationTest];
        [[ThreadTest alloc] downloadImage];
    }
    return 0;
}
