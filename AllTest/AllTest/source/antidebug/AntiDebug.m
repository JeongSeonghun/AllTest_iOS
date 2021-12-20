//
//  AntiDebug.m
//  AllTest
//  
//  Created by jsh on 2021/12/17
//  custom header comment

// https://netcanis.tistory.com/114
// swift에서 사용 시 Bridge header에 추가 필요

#import <Foundation/Foundation.h>
#import "AntiDebug.h"
#import <UIKit/UIKit.h>

// 배포시 자동으로 디버깅 차단 활성화
#ifdef DEBUG
#define ANTI_DEBUG   (0) // 개발 시 디버깅
#else
#define ANTI_DEBUG   (1) // 배포 시 디버깅 차단
#endif

// Antidebug
#if ANTI_DEBUG

// debuger prace
#import <dlfcn.h>
#import <sys/types.h>

// debuger_sysctl
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <stdlib.h>

// ioctl
#include <termios.h>
#include <sys/ioctl.h>

// task_get_exception_port
#include <mach/task.h>
#include <mach/mach_init.h>

// kdebug_signport
#include <sys/kdebug_signpost.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);

#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif // !defined(PT_DENY_ATTACH)

// http://www.coredump.gr/articles/ios-anti-debugging-protections-part-2
void debugger_ptrace()
{
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

// https://developer.apple.com/library/mac/qa/qa1361/_index.html
// http://www.coredump.gr/articles/ios-anti-debugging-protections-part-2
static bool debugger_sysctl(void)
{
    int mib[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);

    info.kp_proc.p_flag = 0;

    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();

    if (sysctl(mib, 4, &info, &info_size, NULL, 0) == -1)
    {
        perror("perror sysctl");
        exit(-1);
    }

    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

static bool antiDebug(void)
{
    debugger_ptrace();
    NSLog(@"Bypassed ptrace()");

    if (debugger_sysctl())
    {
        return NO;
    } else {
        NSLog(@"Bypassed sysctl()");
    }

    #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0

    syscall(26, 31, 0, 0);
    NSLog(@"Bypassed sysctl()");
    #endif

    struct ios_execp_info
    {
        exception_mask_t masks[EXC_TYPES_COUNT];
        mach_port_t ports[EXC_TYPES_COUNT];
        exception_behavior_t behaviors[EXC_TYPES_COUNT];
        thread_state_flavor_t flavors[EXC_TYPES_COUNT];
        mach_msg_type_number_t count;
    };
    struct ios_execp_info *info = malloc(sizeof(struct ios_execp_info));
    kern_return_t kr = task_get_exception_ports(mach_task_self(), EXC_MASK_ALL, info->masks, &info->count, info->ports, info->behaviors, info->flavors);
    NSLog(@"Routine task_get_exception_ports : %d", kr);
    
    for (int i = 0; i < info->count; i++)
    {
        if (info->ports[i] !=0 || info->flavors[i] == THREAD_STATE_NONE)
        {
            NSLog(@"Being debugged... task_get_exception_ports");
        } else {
            NSLog(@"task_get_exception_ports bypassed");
        }
    }

    if (isatty(1)) {
        NSLog(@"Being Debugged isatty");
    } else {
        NSLog(@"isatty() bypassed");
    }

    if (!ioctl(1, TIOCGWINSZ)) {
        NSLog(@"Being Debugged ioctl");
    } else {
        NSLog(@"ioctl bypassed");
    }
    
    #ifdef __arm__
        asm volatile (
                      "mov r0, #31/n"
                      "mov r1, #0/n"
                      "mov r2, #0/n"
                      "mov r12, #26/n"
                      "svc #80/n"
                      );
        NSLog(@"Bypassed syscall() ASM");
    #endif
    #ifdef __arm64__
    asm volatile (
           "mov x0, #26\n" // ptrace syscall (26 in XNU)
           "mov x1, #31\n" // PT_DENY_ATTACH (0x1f) - first arg
           "mov x2, #0\n"
           "mov x3, #0\n"
           "mov x16, #0\n"
           "svc #128\n"    // make syscall
       );
        NSLog(@"Bypassed syscall() ASM64");
    #endif

    return YES;
}
#endif // ANTI_DEBUG

@implementation AntiDebug

+ (BOOL)run {
    #if ANTI_DEBUG
        return antiDebug();
    #endif
        return YES;
}

@end

