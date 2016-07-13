//
//  TreeTableViewCell.h
//  Inroad
//
//  Created by cyp on 16/1/12.
//  Copyright © 2016年 cyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPTreeNode.h"

@class YPTreeTableViewCell;

@protocol YPTreeCellDelegate <NSObject>


- (void)YPTreeTableViewCell:(YPTreeTableViewCell*)view clickBtnWithCellData:(YPTreeNode *)node;


@end

@interface YPTreeTableViewCell : UITableViewCell

@property (nonatomic, assign) id <YPTreeCellDelegate> delegate;

@property(nonatomic,strong)YPTreeNode *data;

@property(nonatomic,strong)UIButton *selectBtn;

@property(nonatomic)BOOL check;

@property(nonatomic)BOOL isCanMultipleChoice;

@property (nonatomic,strong)UIColor *textColor;

@property (nonatomic,strong)UIColor *lineColor;

@end
