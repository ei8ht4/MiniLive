//
//  MLResponse.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

// Room Info
@interface MLRoom : NSObject
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* liveUrl;
@end

// Response Base
@interface MLResponse : NSObject
@property (nonatomic) BOOL status;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* lastError;

-(BOOL) parseDict:(NSDictionary*)dict;
@end

// Login Response
@interface MLLoginResponse : MLResponse
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* roomID;

//-(BOOL) parseDict:(NSDictionary *)dict;
@end

// GetRoomList Response
@interface MLGetRoomListResponse : MLResponse
@property (nonatomic, strong) NSMutableArray* roomList;

//-(BOOL) parseDict:(NSDictionary *)dict;
@end

// Room Response
@interface MLRoomResponse : MLResponse
@property (nonatomic, strong) MLRoom* room;

//-(BOOL) parseDict:(NSDictionary *)dict;
@end

// Start Response
typedef MLResponse MLStartResponse;

// Stop Response
typedef MLResponse MLStopResponse;

// Logout Response
typedef MLResponse MLLogoutResponse;

// Alive Response
@interface MLAliveResponse : MLResponse
@property (nonatomic, strong) NSString* action;
@property (nonatomic, strong) NSString* reason;

//-(BOOL) parseDict:(NSDictionary *)dict;
@end
