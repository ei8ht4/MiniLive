//
//  MLParameters.m
//  MiniLive
//
//  Created by HEHE on 2017/12/25.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "MLParameters.h"
#import "COMMON_MACRO.h"

@implementation MLParameter

-(instancetype) initWithTitle:(NSString*)title andNameArray:(NSArray*)displayNameArray andValueArray:(NSArray*)valueArray
{
    self = [super init];
    if(self)
    {
        _curSel = 0;
        _title = [title copy];
        _displayNameList = [displayNameArray copy];
        _valueList = [valueArray copy];
    }
    return self;
}

-(NSUInteger) valCount {
    if(!_valueList)
        return 0;
    return _valueList.count;
}
@end

@implementation MLParameters
SINGLETON_IMPLEMETATION(MLParameters)

-(instancetype) init
{
    self = [super init];
    if(self)
    {
        // video
        NSArray *videoResolutionNameArray = @[@"720p", @"540p", @"360p"];
        NSArray *videoResolutionValueArray = @[@1,@2,@3];
        _videoResolution = [[MLParameter alloc] initWithTitle:@"分辨率" andNameArray:videoResolutionNameArray andValueArray:videoResolutionValueArray];
        _videoResolution.curSel = 0;
        
        NSArray *videoBitrateNameArray = @[@"0.8m", @"1m", @"1.5", @"2m"];
        NSArray *videoBitrateValueArray = @[@800, @1000, @1500, @2000];
        _videoBitrate = [[MLParameter alloc] initWithTitle:@"码率" andNameArray:videoBitrateNameArray andValueArray:videoBitrateValueArray];
        _videoBitrate.curSel = 2;
        
        NSArray *videoFramerateNameArray = @[@"25fps", @"30fps"];
        NSArray *videoFramerateValueArray = @[@25, @30];
        _videoFrameRate = [[MLParameter alloc] initWithTitle:@"帧率" andNameArray:videoFramerateNameArray andValueArray:videoFramerateValueArray];
        _videoFrameRate.curSel = 0;
        
        // audio
        NSArray *audioSamplerateNameArray = @[@"44.1kHz", @"48kHz"];
        NSArray *audioSamplerateValueArray = @[@44100, @48000];
        _audioSampleRate = [[MLParameter alloc] initWithTitle:@"采样率" andNameArray:audioSamplerateNameArray andValueArray:audioSamplerateValueArray];
        _audioSampleRate.curSel = 0;
        
        NSArray *audioBitrateNameArray = @[@"64k", @"128k", @"192k"];
        NSArray *audioBitrateValueArray = @[@64000, @128000, @192000];
        _audioBitrate = [[MLParameter alloc] initWithTitle:@"码率" andNameArray:audioBitrateNameArray andValueArray:audioBitrateValueArray];
        _audioBitrate.curSel = 1;
        
        // other
        NSArray *cameraNameArray = @[@"前", @"后"];
        NSArray *cameraValueArray = @[@0, @1];
        _camera = [[MLParameter alloc] initWithTitle:@"摄像头" andNameArray:cameraNameArray andValueArray:cameraValueArray];
        _camera.curSel = 0;
    }
    return self;
}

@end
