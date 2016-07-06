//
//  TreeData.h
//  Inroad
//
//  Created by cyp on 16/1/12.
//  Copyright © 2016年 cyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YPTreeNodeStyle;

@interface YPTreeNode : NSObject

@property (nonatomic) NSInteger  level;//等级
@property (nonatomic) BOOL       isOpen;//是否展开的
@property (nonatomic) BOOL       isHaveChild;//是否有子节点
@property (nonatomic) BOOL       selected;//是否被选中

@property (nonatomic, copy) NSString * treeId;//树节点ID--不能重复
@property (nonatomic, copy) NSString * parentId;//父节点ID
@property (nonatomic, copy) NSString * name;//显示值
@property (nonatomic, copy) NSString * value;//实际值 可以不填

@property (nonatomic, strong) NSArray<YPTreeNode*>    *subNodes;//子节点

@property (nonatomic, strong) YPTreeNodeStyle * nodeStyle;//节点样式

@property (nonatomic, strong) NSObject * extendObject;//拓展数据 可以关联一个对象

@end

@interface YPTreeNodeStyle : NSObject

@property (nonatomic, strong) UIColor * textColor;//颜色

@property (nonatomic, strong) UIImage * iconImage;//节点图表


@end