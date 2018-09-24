//
//  ItemTableViewCell.m
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _itemNameLabel.adjustsFontForContentSizeCategory = YES;
    _serialNumberLabel.adjustsFontForContentSizeCategory = YES;
    _itemPriceLabel.adjustsFontForContentSizeCategory = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCellWith:(Item *)item {
    _itemNameLabel.text = item.name;
    _serialNumberLabel.text = item.serialNumber;
    //_itemPriceLabel.text = item.valueInDollars.description;
    _itemPriceLabel.text = [NSString stringWithFormat:@"$%@", item.valueInDollars];
}
@end
