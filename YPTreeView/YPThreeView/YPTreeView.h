//
//  YPTreeView.h
//  Inroad
//
//  Created by cyp on 16/1/12.
//  Copyright © 2016年 cyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPTreeNode.h"

@class YPTreeView;

@protocol YPTreeViewDelegate <NSObject>

@optional

- (void)YPTreeTableView:(YPTreeView*)view didSelected:(YPTreeNode *)node;

- (void)YPTreeTableView:(YPTreeView*)view didClicked:(YPTreeNode *)node;

@end



@interface YPTreeView : UIView

@property (nonatomic,strong)NSArray<YPTreeNode *> *dataArray;

@property (nonatomic, assign) id <YPTreeViewDelegate> delegate;

//是否支持多选
@property (nonatomic)BOOL isCanMultipleChoice;

//文字颜色
@property (nonatomic,strong)UIColor *textColor;

//线颜色
@property (nonatomic,strong)UIColor *lineColor;

//是否隐藏选择按钮
@property (nonatomic)BOOL rightButtonHide;

//当前选中点数组
@property(nonatomic,strong,readonly)NSArray *chooseArry;


@end
