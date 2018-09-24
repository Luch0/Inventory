//
//  InventoryViewController.h
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemStore.h"
#import "ImageStore.h"

@interface InventoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (void)setItemStore:(ItemStore*)itemStore;
- (void)setImageStore:(ImageStore*)imageStore;

@end
