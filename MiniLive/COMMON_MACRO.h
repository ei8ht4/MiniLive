//
//  COMMON_MACRO.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#ifndef COMMON_MACRO_h
#define COMMON_MACRO_h

// WEAK_SELF
#define WEAK_SELF __weak typeof(self) weakSelf = self

// SINGLETON
#define SINGLETON_DECLARE   \
+(instancetype) shareInstance;

#define SINGLETON_IMPLEMETATION(CLASS_NAME) \
static CLASS_NAME *_instance = nil;                         \
+(instancetype) shareInstance                               \
{                                                           \
static dispatch_once_t onceToken;                       \
dispatch_once(&onceToken, ^{                            \
_instance = [[super allocWithZone:NULL] init];      \
});                                                     \
return _instance;                                       \
}                                                           \
+(instancetype) allocWithWithZone:(struct _NSZone *)zone    \
{                                                           \
return [CLASS_NAME shareInstance];                      \
}                                                           \
-(instancetype) copyWithZone:(struct _NSZone *)zone         \
{                                                           \
return [CLASS_NAME shareInstance];                      \
}

#endif /* COMMON_MACRO_h */
