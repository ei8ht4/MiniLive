//
//  MLWebApiInvoker.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MLResponse;
typedef void (^FinishBlock)(BOOL success, MLResponse* response, NSString *error);

@interface MLWebApiInvoker : NSObject
+(instancetype) shareInstance;

@property (nonatomic, strong) NSString* baseUrl;
@property (nonatomic, strong) NSString* lastError;

-(void) login:(NSString*)userID password:(NSString*)password finish:(FinishBlock)finish;
-(void) logout:(NSString*)token finish:(FinishBlock)finish;
-(void) getRoomList:(NSString*)token finish:(FinishBlock)finish;
-(void) getRoom:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish;
-(void) start:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish;
-(void) stop:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish;
-(void) alive:(NSString*)roomID token:(NSString*)token finish:(FinishBlock)finish;
@end
