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
        self.backgroundBtn=backgroundBtn;
        [self.contentView addSubview:backgroundBtn];

        self.nameLable=[[UILabel alloc]init];
        self.nameLable.font=[UIFont systemFontOfSize:14];
        self.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.nameLable];
        
        self.line=[[UILabel alloc]init];
        self.line.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.line];
        
        
        UIButton *icon=[[UIButton alloc]init];
        [icon setImage:[UIImage imageNamed:@"YPThreeView.bundle/three_icon"] forState:UIControlStateNormal];
        icon.imageEdgeInsets=UIEdgeInsetsMake(6, 6, 6, 6);
        icon.userInteractionEnabled=NO;
        self.icon=icon;
        self.icon.hidden=YES;
        [self.contentView addSubview:icon];

        
        self.selectBtn=[[UIButton alloc]init];
        self.selectBtn.frame=CGRectMake(30, 17.5, 20, 20);
        self.selectBtn.userInteractionEnabled=NO;
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/cell_unselect"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/cell_select"] forState:UIControlStateSelected];
        
        self.selectBtn.userInteractionEnabled=NO;
        [self.contentView addSubview:self.selectBtn];
        
        self.image=[[UIImageView alloc]init];
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


- (void)setIsCanMultipleChoice:(BOOL)isCanMultipleChoice{

    _isCanMultipleChoice=isCanMultipleChoice;
    if (!isCanMultipleChoice) {
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/radio_unchecked"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/radio_checked"] forState:UIControlStateSelected];
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/radio_checked"] forState:UIControlStateHighlighted];
    }else{
    
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/cell_unselect"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/cell_select"] forState:UIControlStateSelected];
         [self.selectBtn setImage:[UIImage imageNamed:@"YPThreeView.bundle/cell_select"] forState:UIControlStateHighlighted];

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


@end
