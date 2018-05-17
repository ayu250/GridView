//
//  MLHGridTableCell.h
//  DemoMLH
//
//  Created by 啊育 on 2018/5/8.
//  Copyright © 2018年 Helloworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLHGridViewDataSource;

@interface MLHGridTableCell : UITableViewCell

@property(nonatomic,weak) id<MLHGridViewDataSource> delegate;
@property(nonatomic,assign) NSInteger rowIndex;

@end
