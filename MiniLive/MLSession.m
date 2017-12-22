//
//  MLSession.m
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLSession.h"
#import "COMMON_MACRO.h"
#import "MLResponse.h"

@implementation MLSession
SINGLETON_IMPLEMETATION(MLSession)

-(NSString*) roomName {
    if(!self.roomList || !self.roomID)
        return nil;
    
    for(MLRoom *room in self.roomList)
    {
        if([room.id isEqualToString:self.roomID])
            return room.name;
    }
    return nil;
}

-(NSString*) roomUrl {
    if(!self.roomList || !self.roomID)
        return nil;
    
    for(MLRoom *room in self.roomList)
    {
        if([room.id isEqualToString:self.roomID])
            return room.liveUrl;
    }
    return nil;
}

-(void) clear {
    self.token = @"";
    self.userID = @"";
    self.roomID = @"";
    self.roomList = nil;
}
@end
