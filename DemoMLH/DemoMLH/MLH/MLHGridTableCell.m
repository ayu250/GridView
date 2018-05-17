//
//  MLHGridTableCell.m
//  DemoMLH
//
//  Created by 啊育 on 2018/5/8.
//  Copyright © 2018年 Helloworld. All rights reserved.
//

#import "MLHGridTableCell.h"
#import "MLHGridCollectionCell.h"
#import "MLHGridView.h"

@interface MLHGridTableCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UILabel *bottomLine;
@property(nonatomic,strong) UILabel *topLine;
@end

@implementation MLHGridTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
    
    NSInteger columns = [self.delegate numberOfColumnsForGridView:[MLHGridView gridViewFromSubView:self]];
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake((CGRectGetWidth(rect) - MLH_fix*(columns-1))/columns, CGRectGetHeight(rect));
    layout.minimumInteritemSpacing =  0;
    layout.minimumLineSpacing = 0;

    self.collectionView.backgroundColor = [self bgColor];
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(rect) - MLH_linewidth, CGRectGetWidth(rect), MLH_linewidth);
    self.topLine.frame = CGRectMake(0,  0, CGRectGetWidth(rect), MLH_linewidth);
    
    if (_rowIndex == 0) {
        self.topLine.hidden = NO;
        self.bottomLine.hidden = NO;
    }else{
        self.topLine.hidden = YES;
        self.bottomLine.hidden = NO;
    }
    [self.collectionView reloadData];
}

// MARK: - init

-(UICollectionView *)collectionView{
    if( _collectionView == nil ){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"MLHGridCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}


-(UILabel *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [self getLine];
    }
    return _bottomLine;
}

-(UILabel *)topLine{
    if (_topLine == nil) {
        _topLine = [self getLine];
    }
    return _topLine;
}

// MARK: -

-(UILabel *)getLine{
    UILabel* line = [[UILabel alloc]initWithFrame:CGRectZero];
    line.text = nil;
    line.textColor = MLH_lineColor;
    line.backgroundColor = MLH_lineColor;
    [self.contentView addSubview:line];
    return line;
}

-(UIColor *)bgColor{
    if ([self.delegate respondsToSelector:@selector(gridView:backgroundColorForRow:)]) {
        return [self.delegate gridView:[MLHGridView gridViewFromSubView:self] backgroundColorForRow:self.rowIndex];
    }
    return [UIColor whiteColor];
}

// MARK: -  UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.delegate numberOfColumnsForGridView:[MLHGridView gridViewFromSubView:self]];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MLHGridCollectionCell *cell = (MLHGridCollectionCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [self bgColor];
    [cell setFirst:indexPath.row == 0];
    
    if(self.delegate){
        NSArray *arr = [self.delegate gridView:[MLHGridView gridViewFromSubView:self] dataForRow:self.rowIndex];
        if (indexPath.row < arr.count) {
            cell.textLabel.text = arr[indexPath.row];
        }else{
            cell.textLabel.text = @"";
        }
        
        //设置字体颜色
        if ([self.delegate respondsToSelector:@selector(gridView:textColorForRow:)]) {
            UIColor *textColor = [self.delegate gridView:[MLHGridView gridViewFromSubView:self] textColorForRow:self.rowIndex];
            if( textColor){
                cell.textLabel.textColor = textColor;
            }
        }
        //设置竖向分隔线的颜色
        if(indexPath.row < (arr.count - 1)){
            if([self.delegate respondsToSelector:@selector(gridView:verticalSeparatorColorForRow:column:)]){
                UIColor *lineColor = [self.delegate gridView:[MLHGridView gridViewFromSubView:self] verticalSeparatorColorForRow:self.rowIndex column:indexPath.row];
                if (lineColor) {
                    cell.rightLine.backgroundColor = lineColor;
                }else{
                    cell.rightLine.backgroundColor = MLH_lineColor;
                }
            }
        }else{
            cell.rightLine.backgroundColor = MLH_lineColor;
        }
    }
    return cell;
}

@end
