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

// Room Info
@implementation MLRoom
-(BOOL) isValid
{
    if(self.id.length == 0)
        return NO;
    if(self.name.length == 0)
        return NO;
    if(self.liveUrl.length == 0)
        return NO;
    
    return YES;
}
@end

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
    
    self.status = [statusVal boolValue];
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
    self.roomList = nil;
    PRE_PARSE
    
    NSArray *roomList = dict[@"RoomList"];
    if(!roomList)
    {
        self.lastError = @"未找到room列表";
        return NO;
    }
    
    if(roomList.count == 0)
    {
        self.lastError = @"room列表为空";
        return NO;
    }
    
    NSMutableArray *roomArr = [[NSMutableArray alloc] init];
    
    for(NSDictionary *roomObj in roomList)
    {
        id idVal = roomObj[@"Id"];
        id nameVal = roomObj[@"Name"];
        id liveUrlVal = roomObj[@"LiveUrl"];
        
        if(idVal && nameVal && liveUrlVal)
        {
            MLRoom *room = [[MLRoom alloc] init];
            
            room.id = idVal;
            room.name = nameVal;
            room.liveUrl = liveUrlVal;
            
            if([room isValid])
            {
                [roomArr addObject:room];
            }
            else
            {
                room = nil;
            }
        }
    }
    
    if(roomArr.count == 0)
    {
        self.lastError = @"没有找到有效的房间";
        roomArr = nil;
        return NO;
    }
    
    self.roomList = roomArr;
    
    return YES;
}

@end

// Room Response
@implementation MLRoomResponse

-(BOOL) parseDict:(NSDictionary *)dict
{
    self.room = nil;
    PRE_PARSE
    
    NSDictionary *roomObj = dict[@"Room"];
    if(!roomObj)
    {
        self.lastError = @"未找到room节点";
        return NO;
    }
    
    id idVal = roomObj[@"Id"];
    id nameVal = roomObj[@"Name"];
    id liveUrlVal = roomObj[@"LiveUrl"];
    
    if(!idVal || !nameVal || !liveUrlVal)
    {
        self.lastError = @"未找到id,name或liveurl";
        return NO;
    }
    
    MLRoom *room = [[MLRoom alloc] init];
    
    room.id = idVal;
    room.name = nameVal;
    room.liveUrl = liveUrlVal;
    
    if(![room isValid])
    {
        self.lastError = @"房间信息无效";
        return NO;
    }
    
    self.room = room;
    
    return YES;
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
    
    if([actionVal isKindOfClass:[NSString class]])
    {
        self.action = actionVal;
    }
    if([reasonVal isKindOfClass:[NSString class]])
    {
        self.reason = reasonVal;
    }
    
    return YES;
}

@end
