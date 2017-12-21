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
#import "MLResponse.h"

@implementation MLWebApiInvoker
SINGLETON_IMPLEMETATION(MLWebApiInvoker)

// 设置基础URL
-(void) setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = [[NSString alloc] initWithFormat:@"%@/iBokerApi/minilive", baseUrl];
}

// 调用webapi
-(void) requestWithUrl:(NSString*)url
                 token:(NSString*)token
            parameters:(id)parameters
           requestType:(NSString*)requestType
              callback:(FinishBlock)callback

{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.f;
    if(token && token.length > 0)
    {
        [mgr.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                     @"application/json",
                                                     @"text/json", nil];
    
    [mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // do nothing with progress
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WEAK_SELF;
        __weak typeof(requestType) weakRequestType = requestType;
        __weak typeof(callback) weakCallback = callback;
        
        [weakSelf handleResponse:responseObject ofType:weakRequestType withError:nil finish:weakCallback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WEAK_SELF;
        __weak typeof(requestType) weakRequestType = requestType;
        __weak typeof(callback) weakCallback = callback;
        
        [weakSelf handleResponse:nil ofType:weakRequestType withError:error.description finish:weakCallback];
    }];
}

-(void) login:(NSString*)userID password:(NSString*)password finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/login?mobile=%@&password=%@", self.baseUrl, userID, password];
    [self requestWithUrl:url token:nil parameters:nil requestType:@"login" callback:finish];
}

-(void) logout:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/logout", self.baseUrl];
    [self requestWithUrl:url token:token parameters:nil requestType:@"logout" callback:finish];
}

-(void) getRoomList:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/getroomlist", self.baseUrl];
    [self requestWithUrl:url token:token parameters:nil requestType:@"getroomlist" callback:finish];
}

-(void) getRoom:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/getroom?id=%@", self.baseUrl, roomID];
    [self requestWithUrl:url token:token parameters:nil requestType:@"getroom" callback:finish];
}

-(void) start:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/start?id=%@", self.baseUrl, roomID];
    [self requestWithUrl:url token:token parameters:nil requestType:@"start" callback:finish];
}

-(void) stop:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/stop?id=%@", self.baseUrl, roomID];
    [self requestWithUrl:url token:token parameters:nil requestType:@"stop" callback:finish];
}

-(void) alive:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@/alive?id=%@", self.baseUrl, roomID];
    [self requestWithUrl:url token:token parameters:nil requestType:@"alive" callback:finish];
}

#pragma mark 私有方法

#define PROCESS_RESPONSE(RESPONSE_TYPE)                 \
RESPONSE_TYPE *response = [[RESPONSE_TYPE alloc] init]; \
if([response parseDict:responseObject])                 \
{                                                       \
    finish(true, response, nil);                        \
}                                                       \
else                                                    \
{                                                       \
    finish(false, nil, response.lastError);             \
}

-(void) handleResponse:(id)responseObject ofType:(NSString*)type withError:(NSString*)error finish:(FinishBlock)finish
{
    if(!finish)
        return;
    
    if(!responseObject) // 请求失败
    {
        finish(false, nil, error);
    }
    else if(![responseObject isKindOfClass:[NSDictionary class]])
    {
        finish(false, nil, @"服务器返回的格式不正确");
    }
    else
    {
        if([type isEqualToString:@"login"])
        {
            PROCESS_RESPONSE(MLLoginResponse)
        }
        else if([type isEqualToString:@"logout"])
        {
            PROCESS_RESPONSE(MLLogoutResponse)
        }
        else if([type isEqualToString:@"getroomlist"])
        {
            PROCESS_RESPONSE(MLGetRoomListResponse)
        }
        else if([type isEqualToString:@"getroom"])
        {
            PROCESS_RESPONSE(MLRoomResponse)
        }
        else if([type isEqualToString:@"start"])
        {
            PROCESS_RESPONSE(MLStartResponse)
        }
        else if([type isEqualToString:@"stop"])
        {
            PROCESS_RESPONSE(MLStopResponse)
        }
        else if([type isEqualToString:@"alive"])
        {
            PROCESS_RESPONSE(MLAliveResponse)
        }
    }
}


@end
