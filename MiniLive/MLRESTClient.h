//
//  MLRESTClient.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HttpRequestMethod)
{
    POST = 0,
    GET,
    PUT,
    PATCH,
    DELETE
};

@interface MLRESTClient : NSObject
+(instancetype) shareInstance;

-(void) requestWithURL:(NSString*)url
                method:(HttpRequestMethod)method
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;
@end
