//
//  MLSession.h
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLSession : NSObject
+(instancetype) shareInstance;

@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) NSString* roomID;

@property (nonatomic, strong) NSArray*  roomList;

@property (nonatomic, readonly) NSString* roomName;
@property (nonatomic, readonly) NSString* roomUrl;

-(void) clear;
@end

