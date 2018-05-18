# GridView
自定义iOS网格组件，基于UITableView 和 UICollectionView 构建的 GridView

warning : 请使用优化版本 [iOS-GridView](https://github.com/ayu250/iOS-GridView)


1、初始化  

MLHGridView *grid = [[MLHGridView alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width-20, CGRectGetHeight(self.view.bounds) - 64)];  

grid.delegate = self;  


2、实现delegate  

- (NSInteger)numberOfColumnsForGridView:(MLHGridView *)gridView;  

-(NSInteger)numberOfRowsForGridView:(MLHGridView *)gridView;  

-(NSArray *)gridView:(MLHGridView *)gridView dataForRow:(NSInteger)row;  


  
  
封装结构如图  

![image](https://github.com/ayu250/GridView/blob/master/QQ20180517-152547.png)


展示效果如图  

![image](https://github.com/ayu250/GridView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%208%20-%202018-05-16%20at%2018.25.18.png)
