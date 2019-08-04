//
//  TextCollectionViewCell.m
//  CustomLayoutBestDemo
//
//  Created by DCH on 2019/8/4.
//  Copyright © 2019 DCH. All rights reserved.
//

#import "TextCollectionViewCell.h"

@interface TextCollectionViewCell ()

@property(strong,nonatomic)UILabel *textLabel;

@end

@implementation TextCollectionViewCell

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _textLabel.layer.cornerRadius = self.bounds.size.height*0.5;
        _textLabel.layer.borderWidth = 1;
        _textLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        _textLabel.backgroundColor = [UIColor lightGrayColor];
        _textLabel.layer.masksToBounds = YES;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

- (void)configCellWithContent:(NSString *)content
{
    self.textLabel.text = content;
}

@end
