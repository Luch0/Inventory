//
//  ItemStore.h
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemStore : NSObject

@property NSMutableArray *allItems;
@property NSURL *itemArchiveURL;

- (instancetype) init;
- (Item*)createItem;
- (NSMutableArray*)getAllItems;
- (void)removeItem:(Item*)item;
- (void)moveItemFrom:(NSInteger)from to:(NSInteger)to;
- (BOOL)saveChanges;

@end
