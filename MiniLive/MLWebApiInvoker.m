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
            parameters:(id)parameters
           requestType:(NSString*)requestType
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
    [self requestWithUrl:url parameters:nil requestType:@"login" callback:finish];
}

-(void) logout:(NSString*)token finish:(FinishBlock)finish
{
    
}

-(void) getRoomList:(NSString*)token finish:(FinishBlock)finish
{
    
}

-(void) room:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    
}

-(void) start:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    
}

-(void) stop:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    
}

-(void) alive:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish
{
    
}

#pragma mark 私有方法
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
            MLLoginResponse *response = [[MLLoginResponse alloc] init];
            if(![response parseDict:responseObject])
            {
                finish(false, nil, response.lastError);
            }
            finish(true, response, nil);
        }
        else if([type isEqualToString:@"logout"])
        {
        }
        else if([type isEqualToString:@"getRoomList"])
        {
        }
        else if([type isEqualToString:@"room"])
        {
        }
        else if([type isEqualToString:@"start"])
        {
        }
        else if([type isEqualToString:@"stop"])
        {
        }
        else if([type isEqualToString:@"alive"])
        {
        }
    }
}


@end
