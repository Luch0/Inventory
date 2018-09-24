//
//  ItemDetailViewController.h
//  Inventory
//
//  Created by Luis Calle on 9/1/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "ImageStore.h"

@interface ItemDetailViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) Item *item;

- (void)setImageStore:(ImageStore*)imageStore;

@end
