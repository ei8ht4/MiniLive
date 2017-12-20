//
//  MLWebApiInvoker.m
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLWebApiInvoker.h"
#import "COMMON_MACRO.h"
#import "AFNetworking.h"

@implementation MLWebApiInvoker
SINGLETON_IMPLEMETATION(MLWebApiInvoker)

-(void) requestWithUrl:(NSString*)url
            parameters:(id)parameters
               request:(NSString*)request
              callback:(FinishBlock)callback

{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.f;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                     @"application/json",
                                                     @"text/json", nil];
    
    [mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // do nothing with progress
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // do something with success
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // do something with failure
    }];
}

-(void) login:(NSString*)userID password:(NSString*)password FINISH_BLOCK
{
    
}

-(void) logout:(NSString*)token FINISH_BLOCK
{
    
}

-(void) getRoomList:(NSString*)token FINISH_BLOCK
{
    
}

-(void) room:(NSString*)roomID token:(NSString*)token FINISH_BLOCK
{
    
}

-(void) start:(NSString*)roomID token:(NSString*)token FINISH_BLOCK
{
    
}

-(void) stop:(NSString*)roomID token:(NSString*)token FINISH_BLOCK
{
    
}

-(void) alive:(NSString*)roomID token:(NSString*)token FINISH_BLOCK
{
    
}

@end
