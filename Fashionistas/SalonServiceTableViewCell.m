//
//  SalonServiceTableViewCell.m
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "SalonServiceTableViewCell.h"

@implementation SalonServiceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // ignore the style argument, use our own to override
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        // If you need any further customization
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.width -= 2 * 10;
//    [super setFrame:frame];
//    
//}

@end
