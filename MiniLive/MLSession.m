//
//  MLSession.m
//  MiniLive
//
//  Created by HEHE on 2017/12/20.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLSession.h"
#import "COMMON_MACRO.h"

@implementation MLSession
SINGLETON_IMPLEMETATION(MLSession)

-(void) clear {
    self.token = @"";
    self.userID = @"";
    self.roomID = @"";
}
@end
