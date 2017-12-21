//
//  MLToast.m
//  MiniLive
//
//  Created by HEHE on 2017/12/21.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLToast.h"
#import <UIKit/UIKit.h>

@implementation MLToast

+(void) toast:(NSString*)message withTitle:(NSString*)title viewController:(UIViewController*)viewController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}
@end
