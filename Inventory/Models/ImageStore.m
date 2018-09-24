//
//  ImageStore.m
//  Inventory
//
//  Created by Luis Calle on 9/1/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "ImageStore.h"
#import <UIKit/UIKit.h>

@implementation ImageStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _sharedCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage*)image forKey:(NSString*)key {
    [_sharedCache setObject:image forKey:key];
    
    NSURL *path = [self imageURLForKey:key];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {
        BOOL didWrite = [imageData writeToURL:path options:NSDataWritingAtomic error:nil];
        if (didWrite) {
            NSLog(@"saved image to disk");
        } else {
            NSLog(@"not saved to disk");
        }
    }
}

- (UIImage*)imageForKey:(NSString*)key {
    UIImage *cachedImage = [_sharedCache objectForKey:key];
    if (cachedImage) {
        NSLog(@"Image from cache");
        return cachedImage;
    }
    
    NSURL *path = [self imageURLForKey:key];
    UIImage *imageFromDisk = [[UIImage alloc]initWithContentsOfFile:path.path];
    if (!imageFromDisk){
        NSLog(@"No image at all");
        return [UIImage imageNamed:@"noImageFound"];
    } else {
        [_sharedCache setObject:imageFromDisk forKey:key];
        NSLog(@"Image from disk");
        return imageFromDisk;
    }
}

- (void)deleteImageforKey:(NSString*)key {
    [_sharedCache removeObjectForKey:key];
    NSURL *path = [self imageURLForKey:key];
    [[NSFileManager defaultManager] removeItemAtURL:path error:nil];
    NSLog(@"Image removed from disk");
}

- (NSURL*)imageURLForKey:(NSString *)key {
    NSArray *documentDirectories = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentDirectory = documentDirectories.firstObject;
    NSURL *path = [documentDirectory URLByAppendingPathComponent:key];
    return path;
}

@end
