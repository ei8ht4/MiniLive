//
//  MLResponse.m
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLResponse.h"

#define PRE_PARSE           \
if(![super parseDict:dict]) \
{                           \
    return NO;              \
}                           \
if(!self.status)            \
{                           \
    return YES;             \
}

// Response Base
@implementation MLResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    self.status = NO;
    id statusVal = dict[@"Status"];
    id messageVal = dict[@"Message"];
    
    if(!statusVal || !messageVal)
    {
        self.lastError = @"未找到status或message";
        return NO;
    }
    
    self.status = statusVal;
    self.message = messageVal;
    
    return YES;
}

@end

// Login Response
@implementation MLLoginResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    PRE_PARSE
    
    id tokenVal = dict[@"Token"];
    id idVal = dict[@"Id"];
    id roomIdVal = dict[@"RoomId"];
    
    if(!tokenVal || !idVal || !roomIdVal)
    {
        self.lastError = @"未找到token,id或roomid";
        return NO;
    }
    
    self.token = tokenVal;
    self.id = idVal;
    self.roomID = roomIdVal;
    
    return YES;
}

@end

// GetRoomList Response
@implementation MLGetRoomListResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    [self.roomList removeAllObjects];
    
    PRE_PARSE
    
    // TODO: 继续解析数组
    return NO;
}

@end

// Room Response
@implementation MLRoomResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    PRE_PARSE
    
    // TODO: 继续解析对象
    return NO;
}

@end

// Alive Response
@implementation MLAliveResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    self.action = @"";
    self.reason = @"";
    
    PRE_PARSE
    
    id actionVal = dict[@"Action"];
    id reasonVal = dict[@"Reason"];
    
    if(actionVal)
    {
        self.action = actionVal;
    }
    if(reasonVal)
    {
        self.reason = reasonVal;
    }
    
    return YES;
}

@end
