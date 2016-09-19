//
//  ViewController.m
//  YPTreeView
//
//  Created by roadPro on 16/7/6.
//  Copyright © 2016年 YPTreeView. All rights reserved.
//

#import "ViewController.h"
#import "YPTreeView.h"
#import "YPTreeNode.h"

@interface ViewController ()<YPTreeViewDelegate>

@property(nonatomic, strong) YPTreeView *treeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.treeView=[[YPTreeView alloc]initWithFrame:CGRectMake(0, 40,self.view.frame.size.width, self.view.frame.size.height-80)];
    //支持多选
    self.treeView.isCanMultipleChoice=YES;
    self.treeView.delegate=self;
    self.treeView.lineColor=[UIColor blackColor];
    self.treeView.textColor=[UIColor blackColor];
    self.treeView.backgroundColor=[UIColor colorWithRed:242/255.0 green:249/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.treeView];
    
    //可以异步 接口返回数据后赋值
    self.treeView.dataArray=[self getDataArray];
}

-(NSArray *)getDataArray{
    NSMutableArray * threeDataSoure=[NSMutableArray array];
    
    YPTreeNode *treedata=[[YPTreeNode alloc]init];
    treedata.name=@"根节点";
    treedata.treeId=@"1";
    treedata.parentId=@"0";
    treedata.value=@"root";
    treedata.isOpen=YES;
    [threeDataSoure addObject:treedata];
    
    YPTreeNode *treedata2=[[YPTreeNode alloc]init];
    treedata2.name=@"第一章";
    treedata2.treeId=@"3";
    treedata2.parentId=@"1";
    treedata2.value=@"first";
    treedata2.isOpen=YES;
    [threeDataSoure addObject:treedata2];
    
    YPTreeNode *treedata3=[[YPTreeNode alloc]init];
    treedata3.name=@"第二章";
    treedata3.treeId=@"2";
    treedata3.parentId=@"1";
    treedata3.value=@"second";
    treedata3.isOpen=YES;
    [threeDataSoure addObject:treedata3];
    
    YPTreeNode *treedata4=[[YPTreeNode alloc]init];
    treedata4.name=@"第一节 iOS简介";
    treedata4.treeId=@"5";
    treedata4.parentId=@"3";
    treedata4.value=@"second";
    treedata4.isOpen=YES;
    [threeDataSoure addObject:treedata4];
    
    
    YPTreeNode *treedata5=[[YPTreeNode alloc]init];
    treedata5.name=@"第一节 TableView的使用";
    treedata5.treeId=@"4";
    treedata5.parentId=@"2";
    treedata5.value=@"TableView";
    treedata5.isOpen=YES;
    [threeDataSoure addObject:treedata5];

    return threeDataSoure;
}
#pragma mark
#pragma mark --YPTreeViewDelegate

- (void)YPTreeTableView:(YPTreeView *)view didSelected:(YPTreeNode *)node{
    
        NSLog(@"----选中了节点-----\n 显示名:%@\n 值:%@\n ID:%@\n",node.name,node.value,node.treeId);
    
        NSLog(@"当前选中集合(多选时使用)：%@",view.chooseArry);
    
}

- (void)YPTreeTableView:(YPTreeView *)view didClicked:(YPTreeNode *)node{

        NSLog(@"------点击节点------\n 显示名:%@\n 值:%@\n ID:%@\n",node.name,node.value,node.treeId);

}
@end
