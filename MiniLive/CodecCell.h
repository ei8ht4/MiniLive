//
//  CodecCell.h
//  MiniLive
//
//  Created by hehe on 2017/12/21.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLParameter;

@interface CodecCell : UITableViewCell

-(void) updateContentWithParameter:(MLParameter*)paramter;
@end
