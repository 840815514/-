//
//  YClassifyNewsTableViewCell.m
//  悬停
//
//  Created by 尤艺琪 on 2018/10/22.
//  Copyright © 2018年 尤艺琪. All rights reserved.
//

#import "YClassifyNewsTableViewCell.h"

@interface YClassifyNewsTableViewCell()
@property (nonatomic, strong) UIImageView *newsImv;
@property (nonatomic, strong) UILabel *newsTitleLbl;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *dateLbl;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIImageView *lineImv;
@end



@implementation YClassifyNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self.contentView addSubview:self.newsImv];
        [self.contentView addSubview:self.newsTitleLbl];
        [self.contentView addSubview:self.nameLbl];
        [self.contentView addSubview:self.dateLbl];
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.lineImv];
    }
    return self;
}


-(UIImageView *)newsImv {
    if(_newsImv == nil) {
        _newsImv = [[UIImageView alloc]initWithFrame:CGRectMake(18, 14, 132, 83)];
        _newsImv.backgroundColor = [UIColor orangeColor];
    }
    return _newsImv;
}
-(UILabel *)newsTitleLbl {
    if(_newsTitleLbl == nil) {
        _newsTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(167, 13, [UIScreen mainScreen].bounds.size.width-219, 33)];
        _newsTitleLbl.numberOfLines = 2;
        _newsTitleLbl.text = @"俄罗斯选举负责人将采用全国区块链技术为普京投票";
        _newsTitleLbl.textColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1];
        _newsTitleLbl.font = [UIFont systemFontOfSize:13];
    }
    return _newsTitleLbl;
}
-(UILabel *)nameLbl {
    if(_nameLbl == nil){
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(167, 56,  [UIScreen mainScreen].bounds.size.width-219, 11)];
        _nameLbl.font = [UIFont systemFontOfSize:11];
        _nameLbl.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        _nameLbl.text = @"小葱App";
    }
    return _nameLbl;
}
-(UILabel *)dateLbl {
    if(_dateLbl == nil) {
        _dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(167, 89, [UIScreen mainScreen].bounds.size.width-219, 8)];
        _dateLbl.text = @"09-18";
        _dateLbl.font = [UIFont systemFontOfSize:8];
        _dateLbl.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    }
    return _dateLbl;
}
-(UIButton *)shareBtn {
    if(_shareBtn == nil) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 14, 30, 30)];
        _shareBtn.backgroundColor = [UIColor yellowColor];
    }
    return _shareBtn;
}
-(UIImageView *)lineImv {
    if(_lineImv == nil) {
        _lineImv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 109, [UIScreen mainScreen].bounds.size.width, 1)];
        _lineImv.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    }
    return _lineImv;
}
@end
