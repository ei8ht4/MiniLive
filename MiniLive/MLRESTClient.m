//
//  MLRESTClient.m
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLRESTClient.h"
#import "COMMON_MACRO.h"
#import "AFNetworking.h"

@implementation MLRESTClient
SINGLETON_IMPLEMETATION(MLRESTClient)

-(void) requestWithURL:(NSString*)url
                method:(HttpRequestMethod)method
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                     @"application/json",
                                                     @"text/html",
                                                     @"text/json",
                                                     @"text/javascript", nil];
    
    [mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // do nothing with progress
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(success) {
//            success(responseObject);
//        }
        NSLog(@"11111111111111111111\n");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
        
        WEAK_SELF;
        [weakSelf requestFailed:error];
    }];
    
    NSLog(@"2222222222222222222222222\n");
}

-(void)requestFailed:(NSError*)error
{
    NSString *strError = nil;
    
    switch(error.code)
    {
        case NSURLErrorTimedOut:
            strError = @"访问服务超时";
            break;
        case NSURLErrorUnsupportedURL:
            strError = @"不支持的URL";
            break;
        case NSURLErrorNotConnectedToInternet:
            strError = @"未连接到网络";
            break;
        case NSURLErrorBadServerResponse:
            strError = @"404";
            break;
        default:
            strError = @"未知";
            break;
    }
    
    NSLog(@"--------------\n%ld(%@): %@", (long)error.code, strError, error.debugDescription);
}
@end
