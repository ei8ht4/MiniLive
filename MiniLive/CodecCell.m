//
//  CodecCell.m
//  MiniLive
//
//  Created by hehe on 2017/12/21.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "CodecCell.h"
#import "MLParameters.h"

@interface CodecCell()
@property (weak, nonatomic) IBOutlet UISegmentedControl *valueSegment;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation CodecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) updateContentWithParameter:(MLParameter*)paramter
{
    if(!paramter)
        return;
    
    self.titleLabel.text = paramter.title;
    [self.valueSegment removeAllSegments];
    for(int i = 0; i < paramter.valCount; ++i)
    {
        [self.valueSegment insertSegmentWithTitle:paramter.displayNameList[i] atIndex:self.valueSegment.numberOfSegments animated:YES];
        self.valueSegment.selectedSegmentIndex = paramter.curSel;
    }
}

@end
