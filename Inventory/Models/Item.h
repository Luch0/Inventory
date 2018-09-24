//
//  Item.h
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Item : NSObject <NSCoding>

@property NSString *name;
@property NSNumber *valueInDollars;
@property NSString *serialNumber;
@property NSDate *dateCreated;
@property NSString *itemKey;

- (instancetype)initWithName:(NSString*)name withValueInDollars:(NSNumber*)dollars withSerialNumber:(NSString*)serialNumber;
- (instancetype)initRandom:(BOOL)random;

@end
