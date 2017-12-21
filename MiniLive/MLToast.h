//
//  MLToast.h
//  MiniLive
//
//  Created by HEHE on 2017/12/21.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface MLToast : NSObject
+(void) toast:(NSString*)message withTitle:(NSString*)title viewController:(UIViewController*)viewController;
@end
