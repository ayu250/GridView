//
//  MLHGridCollectionCell.h
//  DemoMLH
//
//  Created by 啊育 on 2018/5/8.
//  Copyright © 2018年 Helloworld. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MLHGridCollectionCell : UICollectionViewCell

@property(nonatomic,weak) IBOutlet UILabel *textLabel;
@property(nonatomic,weak) IBOutlet UILabel *rightLine;
@property(nonatomic,weak) IBOutlet UILabel *leftLine;

-(void)setFirst:(BOOL)first;

@end
