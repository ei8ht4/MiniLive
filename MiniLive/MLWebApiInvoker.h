//
//  MLWebApiInvoker.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLResponse.h"

typedef void (^FinishBlock)(BOOL success, MLResponse* reponse, NSString *error);
#define FINISH_BLOCK finish:(FinishBlock)finish

@interface MLWebApiInvoker : NSObject
+(instancetype) shareInstance;

@property (nonatomic, strong) NSString* baseUrl;
@property (nonatomic, strong) NSString* lastError;

-(void) login:(NSString*)userID password:(NSString*)password FINISH_BLOCK;
-(void) logout:(NSString*)token FINISH_BLOCK;
-(void) getRoomList:(NSString*)token FINISH_BLOCK;
-(void) room:(NSString*)roomID token:(NSString*)token FINISH_BLOCK;
-(void) start:(NSString*)roomID token:(NSString*)token FINISH_BLOCK;
-(void) stop:(NSString*)roomID token:(NSString*)token FINISH_BLOCK;
-(void) alive:(NSString*)roomID token:(NSString*)token FINISH_BLOCK;
@end
