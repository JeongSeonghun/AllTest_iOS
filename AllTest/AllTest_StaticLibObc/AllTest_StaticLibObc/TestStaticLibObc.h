//
//  TestStaticLibObc.h
//  AllTest_StaticLibObc
//  
//  Created by jsh on 2021/10/01
//  custom header comment

#import <Foundation/Foundation.h>

/**
 static library 테스트
 외부에서 사용하기 위해서는 target - build phases - copy files에 해당 해더 추가 필요
 */
@interface TestStaticLibObc : NSObject
+ (void) checkFunc;
@end
