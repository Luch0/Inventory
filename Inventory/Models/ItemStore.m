//
//  ItemStore.m
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

@implementation ItemStore

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = documentDirectories.firstObject;
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"items.archive"];
        _itemArchiveURL = [[NSURL alloc] initWithString:path];
        
        _allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:_itemArchiveURL.path];
        
        if (!_allItems) {
            _allItems = [[NSMutableArray alloc] init];
        }
        
        /*
        for (int i=0; i<8; i++) {
            Item* itemCreatedAndAdded = [self createItem];
            NSLog(@"Added item %@ with price of $%@ and serial number %@. Created %@", itemCreatedAndAdded.name, itemCreatedAndAdded.valueInDollars, itemCreatedAndAdded.serialNumber, itemCreatedAndAdded.dateCreated);
        }
         */

    }
    return self;
}

- (Item*)createItem {
    Item *newItem = [[Item alloc] initRandom:YES];
    [_allItems addObject:newItem];
    return newItem;
}

- (NSMutableArray*)getAllItems {
    return _allItems;
}

- (void)removeItem:(Item *)item {
    [_allItems removeObject:item];
}

- (void)moveItemFrom:(NSInteger)from to:(NSInteger)to {
    if (from == to) return;
    Item *movedItem = [_allItems objectAtIndex:from];
    [_allItems removeObjectAtIndex:from];
    [_allItems insertObject:movedItem atIndex:to];
}

- (BOOL)saveChanges {
    NSLog(@"Saving items to %@", _itemArchiveURL.path);
    return [NSKeyedArchiver archiveRootObject:_allItems toFile:_itemArchiveURL.path];
}

@end
