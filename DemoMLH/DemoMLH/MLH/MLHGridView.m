//
//  MLHDataGridView.m
//  DemoMLH
//
//  Created by 啊育 on 2018/5/7.
//  Copyright © 2018年 Helloworld. All rights reserved.
//

#import "MLHGridView.h"
#import "MLHGridTableCell.h"

@interface MLHGridView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *contentView;

@end

@implementation MLHGridView

+(MLHGridView *)gridViewFromSubView:(UIView *)subView
{
    UIView *view = subView.superview;
    if (view == nil) {
        return nil;
    }else{
        if( [view isKindOfClass:MLHGridView.class]){
            return (MLHGridView*)view;
        }else{
            return [self gridViewFromSubView:view];
        }
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if( self ){

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.contentView.frame  = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
}

// MARK: - init

-(UITableView *)contentView{
    if(_contentView == nil){
        _contentView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.tableFooterView = [UIView new];
        _contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.scrollEnabled = self.scrollEnabled;
        [_contentView registerClass:[MLHGridTableCell class] forCellReuseIdentifier:@"contentCell"];
        [self addSubview:_contentView];
    }
    return _contentView;
}

// MARK: -

///计算行高
-(CGFloat)rowHeight:(NSInteger)row{
    CGRect frame = self.frame;
    return [self rowHeightInRect:frame atRow:row];
}

-(CGFloat)rowHeightInRect:(CGRect)rect atRow:(NSInteger)row{
    NSInteger columns = [self.delegate numberOfColumnsForGridView:self];
    //方格文字宽度
    CGFloat textWidth = (CGRectGetWidth(rect) - MLH_fix*(columns-1))/columns;
    textWidth = textWidth - MLH_textToLeft - MLH_textToRight;
    
    UIFont *font = [UIFont systemFontOfSize:MLH_textFontSize];
    NSArray *arr = [self.delegate gridView:self dataForRow:row];
    float maxHeight = 0;
    CGSize maxSize = CGSizeMake(textWidth, MAXFLOAT);
    for (NSString *item in arr) {
        CGSize textSize = [item boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        if (maxHeight < textSize.height) {
            maxHeight = ceil( textSize.height);
        }
    }
    maxHeight = maxHeight + MLH_textToTop + MLH_textToBottom;
    return maxHeight < 44.0 ? 44.0 : maxHeight;
}

-(void)reloadData{
    [self.contentView reloadData];
    [self setNeedsDisplay];
}

// MARK: - UITableViewDelegate,UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(gridView:heightForRow:)]){
        return [self.delegate gridView:self heightForRow:indexPath.row];
    }else{
        return [self rowHeight:indexPath.row];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.delegate) {
        return [self.delegate numberOfRowsForGridView:self];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLHGridTableCell *cell = (MLHGridTableCell*)[tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    cell.delegate = self.delegate;
    cell.rowIndex = indexPath.row;
    [cell setNeedsDisplay];
    return cell;
}

@end
