//
//  MLParameters.h
//  MiniLive
//
//  Created by HEHE on 2017/12/25.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLParameter : NSObject
@property (nonatomic, retain, readonly) NSString* title;
@property (nonatomic, retain, readonly) NSArray* displayNameList;
@property (nonatomic, retain, readonly) NSArray* valueList;
@property (nonatomic, readonly) NSUInteger valCount;
@property (nonatomic) NSUInteger curSel;
@end

@interface MLParameters : NSObject
+(instancetype) shareInstance;
// video
@property (nonatomic, retain) MLParameter* videoResolution;
@property (nonatomic, retain) MLParameter* videoBitrate;
@property (nonatomic, retain) MLParameter* videoFrameRate;

// audio
@property (nonatomic, retain) MLParameter* audioSampleRate;
@property (nonatomic, retain) MLParameter* audioBitrate;

// other
@property (nonatomic, retain) MLParameter* camera;
@end
