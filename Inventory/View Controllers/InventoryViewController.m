//
//  InventoryViewController.m
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "InventoryViewController.h"
#import "ItemDetailViewController.h"
#import "Item.h"
#import "ItemStore.h"
#import "ImageStore.h"
#import "ItemTableViewCell.h"

@interface InventoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;
@property (nonatomic) ItemStore *itemStore;
@property (nonatomic) ImageStore *imageStore;

@end

@implementation InventoryViewController

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    [super initWithCoder:aDecoder];
//    self.navigationItem.leftBarButtonItem = editButtonItem;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemsTableView.delegate = self;
    _itemsTableView.dataSource = self;
    _itemsTableView.rowHeight = UITableViewAutomaticDimension;
    _itemsTableView.estimatedRowHeight = 65;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_itemsTableView reloadData];
}

- (IBAction)toggleEditingMode:(UIBarButtonItem *)sender {
    if (_itemsTableView.isEditing) {
        [sender setTitle:@"Edit"];
        sender.title = @"Edit";
        [_itemsTableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done"];
        sender.title = @"Done";
        [_itemsTableView setEditing:YES animated:YES];
    }
}

- (IBAction)addNewItemToInventory:(UIBarButtonItem *)sender {
    Item *newItem = _itemStore.createItem;
    NSInteger index = [_itemStore.allItems indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexArray = [NSArray arrayWithObjects:indexPath, nil];
    [_itemsTableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
}

- (void)setItemStore:(ItemStore*)itemStore {
    _itemStore = itemStore;
}

- (void)setImageStore:(ImageStore*)imageStore {
    _imageStore = imageStore;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ItemDetailSegue"]) {
        ItemDetailViewController *itemDVC = (ItemDetailViewController *)[segue destinationViewController];
        NSInteger index = _itemsTableView.indexPathForSelectedRow.row;
        itemDVC.item = _itemStore.getAllItems[index];
        [itemDVC setImageStore:_imageStore];
    }
}

#pragma mark - UITableViewDataSource methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemTableViewCell *itemCell = (ItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Item cell" forIndexPath:indexPath];
    Item *item = [_itemStore.getAllItems objectAtIndex:indexPath.row];
    [itemCell configureCellWith:item];
    return itemCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemStore.allItems.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *itemToDelete = [_itemStore.getAllItems objectAtIndex:indexPath.row];
        
        NSString *title = [NSString stringWithFormat:@"Delete %@?", itemToDelete.name];
        NSString * message = @"Are you sure tou want to delete this item?";
        UIAlertController *deleteAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self->_itemStore removeItem:itemToDelete];
            
            [self->_imageStore deleteImageforKey:itemToDelete.itemKey];
            
            NSArray *indexArray = [NSArray arrayWithObjects:indexPath, nil];
            [self->_itemsTableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
        }];
        [deleteAlertController addAction:deleteAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [deleteAlertController addAction:cancelAction];
        
        [self presentViewController:deleteAlertController animated:YES completion:nil];
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [_itemStore moveItemFrom:sourceIndexPath.row to:destinationIndexPath.row];
}

@end
