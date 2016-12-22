//
//  GDTableViewCell.m
//  EditTableView
//
//  Created by X-Designer on 16/12/22.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "GDTableViewCell.h"

@implementation GDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
//                        img.image=[UIImage imageNamed:@"你的编辑模式下的图片"];
//                        img.size =CGSizeMake(20,20);
                    }
                }
            }
        }
    }
}

//重写父类点击方法  原理跟编辑模式修改图片相同

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
