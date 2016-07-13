//
//  TreeTableViewCell.m
//  Inroad
//
//  Created by cyp on 16/1/12.
//  Copyright © 2016年 cyp. All rights reserved.
//

#import "YPTreeTableViewCell.h"
//#import "UIView+RSAdditions.h"
//#import "UIColor+Hex.h"
//#import "NSString+Size.h"
/**
 *  屏幕高度，宽度，宽度比
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_SCALE ([[UIScreen mainScreen] bounds].size.width/360)
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface YPTreeTableViewCell ()

@property(nonatomic,strong)UILabel *nameLable;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)UIButton *icon;

@property(nonatomic,strong)UIButton *backgroundBtn;

@property(nonatomic,strong)UIImageView *image;


@end

@implementation YPTreeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UIButton *backgroundBtn=[[UIButton alloc]init];
        [backgroundBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        backgroundBtn.backgroundColor=[UIColor grayColor];
        self.backgroundBtn=backgroundBtn;
        [self.contentView addSubview:backgroundBtn];

        
        self.nameLable=[[UILabel alloc]init];
//        self.nameLable.textColor=[UIColor blackColor];
        self.nameLable.font=[UIFont systemFontOfSize:14];
//        self.nameLable.backgroundColor=[UIColor brownColor];
        self.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.nameLable];
        
        self.line=[[UILabel alloc]init];
        self.line.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.line];
        
        
      
        UIButton *icon=[[UIButton alloc]init];
        [icon setImage:[UIImage imageNamed:@"three_icon"] forState:UIControlStateNormal];
        //        icon.backgroundColor=[UIColor orangeColor];
        //        [icon.imageView setFrame:CGRectMake(6, 6, 12, 12)];
        icon.imageEdgeInsets=UIEdgeInsetsMake(6, 6, 6, 6);
        //        [icon addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        icon.userInteractionEnabled=NO;
        self.icon=icon;
        self.icon.hidden=YES;
        [self.contentView addSubview:icon];

        
        self.selectBtn=[[UIButton alloc]init];
        self.selectBtn.frame=CGRectMake(30, 17.5, 20, 20);
        self.selectBtn.userInteractionEnabled=NO;
        [self.selectBtn setImage:[UIImage imageNamed:@"cell_unselect"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"cell_select"] forState:UIControlStateSelected];
//        self.selectBtn.hidden=YES;
        
        self.selectBtn.userInteractionEnabled=NO;
//        [self.selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectBtn];
        
        self.image=[[UIImageView alloc]init];
//        self.image.backgroundColor=[UIColor brownColor];
        [self.contentView addSubview:self.image];
        
        self.isCanMultipleChoice=NO;



    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat labeLeft=10*SCREEN_SCALE+(SCREEN_SCALE*10*self.data.level);
    CGSize  textSize= [self sizeWithLabel:self.nameLable maxSize:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT)];

    [self.nameLable setFrame:CGRectMake(labeLeft, 0, self.frame.size.width-labeLeft-35, 40)];
    
    [self.image setFrame:CGRectMake(labeLeft+textSize.width+10,  (self.frame.size.height-25)/2, 25, 25)];

    [self.line setFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height-2, self.nameLable.frame.size.width, 1)];

    [self.icon setFrame:CGRectMake(self.nameLable.frame.origin.x-20, 10, 20, 20)];
    
    [self.backgroundBtn setFrame:CGRectMake(0, 0, self.frame.size.width-30, self.frame.size.height)];
    
    self.selectBtn.frame=CGRectMake(self.frame.size.width-30, (self.frame.size.height-20)/2, 20, 20);

}

- (void)setTextColor:(UIColor *)textColor{
    self.nameLable.textColor=textColor;
}

- (void)setLineColor:(UIColor *)lineColor{

    self.line.backgroundColor=lineColor;
}
- (void)setData:(YPTreeNode *)data{
    
    _data=data;

    self.nameLable.text=data.name;
    if (data.isOpen) {
        
        self.icon.transform=CGAffineTransformMakeRotation(M_PI_2);

    }else{
        self.icon.transform=CGAffineTransformMakeRotation(0);

    }

    self.icon.hidden=!data.isHaveChild;
    self.icon.selected=data.isOpen;
    self.check=data.selected;
    
    if (data.nodeStyle) {
        
        if (data.nodeStyle.textColor) {
            self.nameLable.textColor=data.nodeStyle.textColor;
        }
        if (data.nodeStyle.iconImage) {
            self.image.image=data.nodeStyle.iconImage;
        }
    }


}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
//
//    [super setSelected:selected animated:animated];
//    
//    if (!self.isMultipleTouchEnabled) {
//        self.check=selected;
//
//    }
//}

- (void)setIsCanMultipleChoice:(BOOL)isCanMultipleChoice{

    _isCanMultipleChoice=isCanMultipleChoice;
//    self.selectBtn.hidden=!isCanMultipleChoice;
    if (!isCanMultipleChoice) {
        [self.selectBtn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [self.selectBtn setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateHighlighted];
    }else{
    
        [self.selectBtn setImage:[UIImage imageNamed:@"cell_unselect"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"cell_select"] forState:UIControlStateSelected];
         [self.selectBtn setImage:[UIImage imageNamed:@"cell_select"] forState:UIControlStateHighlighted];

    }
   
    
}

- (void)setCheck:(BOOL)check{
    _check=check;
    
    self.selectBtn.selected=check;
    if (self.data) {
        _data.selected=check;
    }
    
    
}

-(void)clickBtn:(UIButton *)button{
    
    self.icon.selected=!self.icon.selected;
    
    if(self.icon.selected){
        
        [UIView animateWithDuration:0.2 animations:^{
        
             self.icon.transform=CGAffineTransformMakeRotation(M_PI_2);
            
        } completion:^(BOOL finished) {
            
            self.icon.transform=CGAffineTransformMakeRotation(M_PI_2);

        }];
       
        
    }else{
        
      [UIView animateWithDuration:0.2 animations:^{
          
          self.icon.transform=CGAffineTransformMakeRotation(0);
          
      } completion:^(BOOL finished) {
          
          self.icon.transform=CGAffineTransformMakeRotation(0);
          
      }];
        
    }

    if ([self.delegate respondsToSelector:@selector(YPTreeTableViewCell:clickBtnWithCellData:)]) {
        [self.delegate YPTreeTableViewCell:self clickBtnWithCellData:self.data];
        
    };

}
- (CGSize)sizeWithLabel:(UILabel *)lable maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName :lable.font};
    return [lable.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//-(void)selectClick:(UIButton *)button{
//
//
//}
//-(void)setIsDrawing:(BOOL)isDrawing{
//    
//    
////    if (_isDrawing!=isDrawing) {
//        _isDrawing=isDrawing;
//        if (isDrawing) {
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.2];
////            self.ic.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.dropHeight);
//            self.icon.transform=CGAffineTransformMakeRotation(M_PI_2);
//            [UIView commitAnimations];
////            [self.superview addSubview:self.table];
//
//        }else{
//        
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.2];
//            self.icon.transform=CGAffineTransformMakeRotation(0);
////            self.table.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.width, 0);
//            [UIView commitAnimations];
//        }
//        
////    }
//
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"isOpen"]) {
//        YPTreeNode *node=(YPTreeNode*)object;
//        if(node.isOpen){
//        
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:1.5];
//            self.icon.transform=CGAffineTransformMakeRotation(M_PI_2);
//            [UIView commitAnimations];
//
//        }else{
//        
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:1.5];
//            self.icon.transform=CGAffineTransformMakeRotation(0);
//            [UIView commitAnimations];
//
//        }
//        
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//- (void)dealloc
//{
//    [super dealloc];
//    [self.data removeObserver:self forKeyPath:@"isOpen" context:nil];
//}
@end
