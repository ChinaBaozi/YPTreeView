//
//  RoadTreeView.m
//  Inroad
//
//  Created by cyp on 16/1/12.
//  Copyright © 2016年 cyp. All rights reserved.
//

#import "YPTreeView.h"
#import "YPTreeTableViewCell.h"

@interface YPTreeView()<UITableViewDataSource,UITableViewDelegate,YPTreeCellDelegate>{
    
    YPTreeTableViewCell * _selectCell;

}

@property(nonatomic, strong) NSMutableDictionary *relationDic;

@property(nonatomic, strong) NSMutableArray *showSource;

@property(nonatomic, strong) UITableView *table;

@end

@implementation YPTreeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        self.table.dataSource=self;
        self.table.delegate=self;
        self.table.bounces=NO;
        self.backgroundColor=[UIColor whiteColor];
        self.table.backgroundColor=[UIColor clearColor];
        self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:self.table];
    }
    return self;
}


#pragma mark
#pragma mark --YPTreeCellDelegate

-(void)YPTreeTableViewCell:(YPTreeTableViewCell *)view clickBtnWithCellData:(YPTreeNode *)node{
    //    YPTreeNode *node = self.showSource[indexPath.row];
    NSIndexPath* indexPath=[self.table indexPathForCell:view];
    
    if (node.isOpen) {
        //减
        NSUInteger index=indexPath.row+1;
        
        [self minusNodesByNode:node atIndex:index];
    }
    else{
        //加一个
        NSUInteger index=indexPath.row+1;
        
        [self addSubNodesByFatherNode:node atIndex:index];
    }
      
    if ([self.delegate respondsToSelector:@selector(YPTreeTableView:didClicked:)]) {
    
        [self.delegate YPTreeTableView:self didClicked:node];
    }
    
    
    
    
}
//添加子节点
- (void)addSubNodesByFatherNode:(YPTreeNode *)fatherNode atIndex:(NSInteger )index
{
    if (fatherNode)
    {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *cellIndexPaths = [NSMutableArray array];
        NSUInteger count = index;
        
        for(YPTreeNode *node in (NSArray*)[self.relationDic objectForKey:fatherNode.treeId]) {
            
            node.level=fatherNode.level+1;
//            node.selected=fatherNode.selected;
            [array addObject:node];
            [cellIndexPaths addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        }
        
//        for(YPTreeNode *node in self.dataArray) {
//            if ([node.parentId isEqualToString:fatherNode.treeId]) {
////                node.originX = fatherNode.originX + 10/*space*/;
//                node.level=fatherNode.level+1;
//                [array addObject:node];
//                [cellIndexPaths addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
//            }
//        }
        
        if (array.count) {
            fatherNode.isOpen = YES;
            fatherNode.subNodes = array;
            
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index,[array count])];
            [self.showSource insertObjects:array atIndexes:indexes];
            [self checkNodesHaveChild:(NSArray*)[self.relationDic objectForKey:fatherNode.treeId]];
            [self.table insertRowsAtIndexPaths:cellIndexPaths withRowAnimation:UITableViewRowAnimationFade];
//            [self reloadData];
        }
    }
}

//根据节点减去子节点
- (void)minusNodesByNode:(YPTreeNode *)node atIndex:(NSInteger )index
{
    if (node) {
      
        NSMutableArray *delectArray=[self getNodeChilds:node];
        
        [self.showSource removeObjectsInArray:delectArray];
        NSUInteger count=delectArray.count;
        NSMutableArray *cellIndexPaths = [NSMutableArray array];
        
        for (int i=0; i<count; i++) {
              [cellIndexPaths addObject:[NSIndexPath indexPathForRow:index+i inSection:0]];
        }
      

        [self.table deleteRowsAtIndexPaths:cellIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        
        if (node.isOpen) {
            node.isOpen = NO;
            node.subNodes=nil;
        }
        
//        [self reloadData];
    }
}


/**
 *  获取子节点，并且准备删除
 *
 *  @param prentNode 父节点
 *
 *  @return 子节点数组
 */
-(NSMutableArray *)getNodeChilds:(YPTreeNode *)prentNode{
    NSMutableArray *childArray=[NSMutableArray array];
    
//    XXBLog(@"开始取%@的子节点,name:%@",prentNode,prentNode.name);
    
    NSArray *dataChildArray=prentNode.subNodes;
    
    for (int i=0;i<dataChildArray.count;i++){
        
        YPTreeNode *childNode=[dataChildArray objectAtIndex:i];
        
//        XXBLog(@"------child:%@,name:%@",childNode,childNode.name);

        [childArray addObject:childNode];
        
        if (childNode.isOpen) {
            childNode.isOpen=NO;
            [childArray addObjectsFromArray:[self getNodeChilds:childNode]];
        }

    }
    
    return childArray;
}
#pragma mark
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.showSource count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

        
        return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
 
    YPTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[YPTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.isCanMultipleChoice=self.isCanMultipleChoice;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    YPTreeNode *data= [self.showSource objectAtIndex:indexPath.row];
    if (self.textColor) {
        cell.textColor=self.textColor;
    }
    if (self.lineColor) {
        cell.lineColor=self.lineColor;
    }
    if (self.rightButtonHide) {
        cell.selectBtn.hidden=YES;
    }
//    cell.textLabel.text =[NSString stringWithFormat:@"%@(%ld)",data.name,(long)data.level];
//    cell.textLabel.textColor = BACK_COLOR;
    
//    UIView * v = [[UIView alloc] init];
//    v.backgroundColor = [UIColor grayColor];
//    cell.selectedBackgroundView = v;
    [cell setData:data];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPTreeTableViewCell *cell = (YPTreeTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.check=!cell.check;
    if (!self.isCanMultipleChoice) {
        _selectCell.check=NO;
    }
    _selectCell=cell;
    
    YPTreeNode *node = self.showSource[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(YPTreeTableView:didSelected:)]) {
        [self.delegate YPTreeTableView:self didSelected:node];
    }
    
    
}



-(void)setDataArray:(NSArray *)dataArray{
  
    if (dataArray!=nil&&dataArray.count>0) {
        NSObject * fristobj=[dataArray objectAtIndex:0];
        if (![fristobj isKindOfClass:[YPTreeNode class]]) {
        
            NSLog(@"数据源类型错误，必须是TreeData类型");
            return;
        
        }else{
            
            [self resolveDataArray:dataArray];
            [self.table reloadData];
        }
    }
      _dataArray=dataArray;
}


-(void)resolveDataArray:(NSArray *)dataArray{

    NSMutableArray *keyArray=[NSMutableArray array];
    NSMutableDictionary *dataDic=[NSMutableDictionary dictionary];
    
    NSString *rootId=[self findRootId:dataArray];

    
    for (YPTreeNode *data in dataArray) {
     
        if ([data.parentId isEqualToString:rootId]) {
            data.level=1;
        }
        
       if ([keyArray containsObject:data.parentId]) {
            
            NSMutableArray *valueArray=(NSMutableArray *)[dataDic objectForKey:data.parentId];
            [valueArray addObject:data];
            [dataDic setObject:valueArray forKey:data.parentId];
            
        }else{
            NSMutableArray *valueArray=[NSMutableArray array];
            [valueArray addObject:data];
            [dataDic setObject:valueArray forKey:data.parentId];
            [keyArray addObject:data.parentId];
            
        }
    }
    
    self.relationDic=dataDic;
    

    YPTreeNode * rootNode=[YPTreeNode new];
    rootNode.treeId=rootId;
    rootNode.level=0;
//    rootNode.isHaveChild=YES;
    
    self.showSource=[self findChildArrayWithThreeID:rootNode];


    
//    =[dataDic objectForKey:rootId];
//    
//
    
}


//    NSString * str=@"";
//
//    BOOL haveParent=NO;
//    NSMutableArray *haveExistenceArray=[NSMutableArray array];
//
//    for (YPTreeNode *data in array ) {
//
//        [haveExistenceArray addObject:data.treeId];
//
//        if (![haveExistenceArray containsObject:data.parentId]) {
//
//            for (YPTreeNode *otherdata in array) {
//
//                if([otherdata.treeId isEqualToString:data.parentId]){
//                    haveParent=YES;
//                    break;
//                }
//            }
//
//            if (!haveParent) {
//                str=data.parentId;
//            }
//
//        }
//    }
//
//    return str;

-(NSString*)findRootId:(NSArray*)array{
    
        NSMutableDictionary *gxDic=[NSMutableDictionary dictionary];
    
        for (YPTreeNode *data in array ) {
            [gxDic setObject:data.parentId forKey:data.parentId];
        }
    
        for (YPTreeNode *data in array ) {
            [gxDic setObject:data.parentId forKey:data.treeId];
        }
    
        NSString *str=((YPTreeNode*)[array firstObject]).parentId;
    
        while ([gxDic objectForKey:str] != str) {
    
            str=[gxDic objectForKey:str] ;
        }
        return str;

}

-(NSMutableArray*)findChildArrayWithThreeID:(YPTreeNode*)node{

    NSMutableArray *array=[NSMutableArray array];
    
//    XXBLog(@"寻找%@节点（%@）的子节点",node.name,node.treeId);
    
    NSMutableArray * childArray=[self.relationDic objectForKey:node.treeId];
    [self checkNodesHaveChild:childArray];

    for (YPTreeNode *data in childArray ) {
        data.level=node.level +1;
        [array addObject:data];

        if (data.isHaveChild) {
            NSArray * dataChildArray=[self findChildArrayWithThreeID:data];
            
            data.subNodes=[self.relationDic objectForKey:data.treeId];
          
            [array addObjectsFromArray:dataChildArray];
            data.isOpen=YES;
        }else{
        
            data.subNodes=nil;
            data.isOpen=NO;

        }
        

    }
    
//    XXBLog(@"------%@节点（%@）的子节点有%d个",node.name,node.treeId,array.count);

    return  array;

}
-(BOOL)isArrayHaveString:(NSArray *)array String:(NSString*)str{

    for (NSString * valueStr in array) {
        if ([valueStr isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}

-(void)checkNodesHaveChild:(NSArray*)nodeArray{

    for (YPTreeNode *node in nodeArray) {
        if ([[self.relationDic allKeys] containsObject:node.treeId])
             node.isHaveChild=YES;
    }
    
}
- (void)setIsCanMultipleChoice:(BOOL)isCanMultipleChoice{

    _isCanMultipleChoice=isCanMultipleChoice;
    [self.table reloadData];
    
}

- (NSArray *)chooseArry{

    NSMutableArray *array=[NSMutableArray array];
    
    for (YPTreeNode *data in self.dataArray) {
        if (data.selected) {
            [array addObject:data];
        }
    }
    
    return array;
}
-(NSMutableArray *)showSource{

    if (_showSource==nil) {
        _showSource=[NSMutableArray array];
    }
    return _showSource;
}
@end
