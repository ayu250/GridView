//
//  MLHGridCollectionCell.m
//  DemoMLH
//
//  Created by 啊育 on 2018/5/8.
//  Copyright © 2018年 Helloworld. All rights reserved.
//

#import "MLHGridCollectionCell.h"
#import "MLHGridView.h"

@interface MLHGridCollectionCell()



@end

@implementation MLHGridCollectionCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.leftLine.backgroundColor = MLH_lineColor;
    self.rightLine.backgroundColor = MLH_lineColor;
    self.textLabel.font = [UIFont systemFontOfSize:MLH_textFontSize];
}

// MARK: -

-(void)setFirst:(BOOL)first{
    if (first) {
        self.leftLine.hidden = NO;
        self.rightLine.hidden = NO;
    }else{
        self.leftLine.hidden = YES;
        self.rightLine.hidden = NO;
    }
}

@end
