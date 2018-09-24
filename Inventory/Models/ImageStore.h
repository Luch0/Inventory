//
//  ImageStore.h
//  Inventory
//
//  Created by Luis Calle on 9/1/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

@property (nonatomic) NSCache *sharedCache;

- (void)setImage:(UIImage*)image forKey:(NSString*)key;

- (UIImage*)imageForKey:(NSString*)key;

- (void)deleteImageforKey:(NSString*)key;

@end
